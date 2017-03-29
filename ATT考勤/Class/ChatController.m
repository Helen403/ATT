//
//  ChatController.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChatController.h"
#import "ChatModel.h"
#import "ChatViewModel.h"
#import "InputToolbar.h"
#import "UIView+Extension.h"
#import "IQKeyboardManager.h"
#import "UserModel.h"
#import "IconView.h"


@interface ChatController ()<UITableViewDelegate,UITableViewDataSource,MoreButtonViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,InputToolbarDelegate>
@property(nonatomic,strong) NSTimer *timeNow;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) ChatViewModel *chatViewModel;

@property (nonatomic,strong)InputToolbar *inputToolbar;

@property (nonatomic,assign)CGFloat inputToolbarY;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,assign) NSInteger time;

@end

@implementation ChatController

- (void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"聊天";
}

-(void)h_addSubviews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputToolbar];
}

-(void)h_viewWillAppear{
    //打开键盘事件相应
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)h_viewWillDisappear{
    //关闭键盘事件相应
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    //关闭定时器
    [self.timeNow setFireDate:[NSDate distantFuture]];
}


-(void)keyboardShow:(NSNotification *)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    
    if (self.chatViewModel.arr.count>4) {
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            self.tableView.transform=CGAffineTransformMakeTranslation(0, -deltaY);
        }];
    }
    
}

-(void)keyboardHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
    }];
}

-(InputToolbar *)inputToolbar{
    if (!_inputToolbar) {
        _inputToolbar = [InputToolbar shareInstance];
        _inputToolbar.textViewMaxVisibleLine = 4;
        _inputToolbar.width = self.view.width;
        
        _inputToolbar.height = [self h_w:49];
        
        if (isPad) {
            _inputToolbar.y = self.view.height - _inputToolbar.height-[self h_w:7];
        }else{
            _inputToolbar.y = self.view.height - _inputToolbar.height-[self h_w:60];
        }
        
        _inputToolbar.delegate = self;
        [_inputToolbar setMorebuttonViewDelegate:self];
        
        WS(weakSelf);
        _inputToolbar.sendContent = ^(NSObject *content){
            
            //            NSLog(@"发射成功☀️:---%@",content);
            
            [weakSelf sendMsg:((NSAttributedString *)content).string andType:@"1" andVolumnTime:@"0"];
        };
        
        _inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
            _inputToolbarY = orignY;
        };
        [_inputToolbar resetInputToolbar];
    }
    return _inputToolbar;
    
}

-(void)setMyMsgModel:(MyMsgModel *)myMsgModel{
    if (!myMsgModel) {
        return;
    }
    _myMsgModel = myMsgModel;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.companyCode = companyCode;
    UserModel *user = getModel(@"user");
    self.userCode = user.userCode;
    //设置定时
    self.timeNow = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(h_loadData) userInfo:nil repeats:YES];
}

-(void)h_loadData{
    self.chatViewModel.companyCode = self.companyCode;
    self.chatViewModel.userCode = self.userCode;
    self.chatViewModel.targetId = self.myMsgModel.msgUserCode;
    [self.chatViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    [[self.chatViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            //滚动到最底下
            [self tableViewScrollCurrentIndexPath];
        });
    }];
    WS(weakSelf);
    self.inputToolbar.voiceRecord = ^(NSURL *file,NSInteger time){
        //NSString *str = [file absoluteString];
       //NSLog(@"地址%@ 时间%ld",str,(long)time);
        [weakSelf commitVoiceNotice:file and:time];
    };
    [[self.chatViewModel.fileSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self sendMsg:x andType:@"2" andVolumnTime:[NSString stringWithFormat:@"%ld",(long)self.time]];
        });
    }];
}

- (void)commitVoiceNotice:(NSURL *)Path and:(NSInteger)time{
    self.time = time;
    [LSCoreToolCenter audio_PCMtoMP3:Path];
    NSData *data = [NSData dataWithContentsOfFile:Path];
 
    NSString *base64Str = [LSCoreToolCenter Base64StrWithMp3Data:data];
    
    if ([LSCoreToolCenter isBlankString:base64Str]) {
        return;
    }
    self.chatViewModel.fileName =[NSString stringWithFormat:@"%@%@.mp3",self.userCode,[LSCoreToolCenter currentYearYMDHMSA]];
    self.chatViewModel.content = base64Str;
    self.chatViewModel.fileType = @"ios_audio";
    
    [self.chatViewModel.updataCommand execute:nil];
   
}



-(void)sendMsg:(NSString *)content andType:(NSString *)index andVolumnTime:(NSString *)time{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.chatViewModel.companyCode = companyCode;
    UserModel *user = getModel(@"user");
    self.chatViewModel.msgSenderId = user.userCode;
    self.chatViewModel.msgSenderName = user.userRealName;
    self.chatViewModel.msgReceId = self.myMsgModel.msgUserCode;
    self.chatViewModel.msgReceName =self.myMsgModel.msgUserName;
    self.chatViewModel.msgSendDate = [LSCoreToolCenter currentYearYMDHMS];
    self.chatViewModel.msgType = index;
    self.chatViewModel.msgContents = content;
    self.chatViewModel.msgVolumnTime = time;
    [self.chatViewModel.sendCommand execute:nil];
}

-(void)tableViewScrollCurrentIndexPath{
    if (self.chatViewModel.arr.count<1) {
        return;
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.chatViewModel.arr.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.inputToolbar.isBecomeFirstResponder = NO;
}

- (void)moreButtonView:(MoreButtonView *)moreButtonView didClickButton:(MoreButtonViewButtonType)buttonType{
    switch (buttonType) {
        case MoreButtonViewButtonTypeImages:{
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        } break;
            
        case MoreButtonViewButtonTypeCamera:{
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        } break;
            
        default:
            break;
    }
}

- (void)inputToolbar:(InputToolbar *)inputToolbar orignY:(CGFloat)orignY{
    _inputToolbarY = orignY;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *image = info[UIImagePickerControllerOriginalImage];
    //图片选取成功
}


#pragma mark lazyload
-(ChatViewModel *)chatViewModel{
    if (!_chatViewModel) {
        _chatViewModel = [[ChatViewModel alloc] init];
    }
    return _chatViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-[self h_w:100]);
    }
    return _tableView;
}


//泡泡文本
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf withPosition:(int)position{
    
    //计算大小
    CGSize size = [text sizeWithFont:H14 constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //背影图片
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"SenderAppNodeBkg_HL":@"ReceiverTextNodeBkg" ofType:@"png"]];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    
    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf?15.0f:22.0f, 20.0f, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = H14;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = text;
    
    bubbleImageView.frame = CGRectMake(0.0f, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    
    if(fromSelf)
        returnView.frame = CGRectMake(SCREEN_WIDTH-position-(bubbleText.frame.size.width+30.0f), [self h_w:15], bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    else
        returnView.frame = CGRectMake(position, [self h_w:15], bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
    
    return returnView;
}

//泡泡语音
- (UIView *)yuyinView:(NSInteger)logntime from:(BOOL)fromSelf withIndexRow:(NSInteger)indexRow  withPosition:(int)position{
    
    //根据语音长度
    int yuyinwidth = 66+fromSelf;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = indexRow;
    [button addTarget:self action:@selector(playMp3:) forControlEvents:UIControlEventTouchUpInside];
    if(fromSelf)
        button.frame = CGRectMake(SCREEN_WIDTH-position-yuyinwidth, [self h_w:30], yuyinwidth, [self h_w:54]);
    else
        button.frame =CGRectMake(position, [self h_w:30], yuyinwidth, [self h_w:54]);
    
    //image偏移量
    UIEdgeInsets imageInsert;
    imageInsert.top = -10;
    imageInsert.left = fromSelf?button.frame.size.width/3:-button.frame.size.width/3;
    button.imageEdgeInsets = imageInsert;
    
    [button setImage:[UIImage imageNamed:fromSelf?@"SenderVoiceNodePlaying":@"ReceiverVoiceNodePlaying"] forState:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:fromSelf?@"SenderVoiceNodeDownloading":@"ReceiverVoiceNodeDownloading"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fromSelf?-30:button.frame.size.width, 0, 30, button.frame.size.height)];
    label.text = [NSString stringWithFormat:@"%ld''",(long)logntime];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [button addSubview:label];
    
    return button;
}

-(void)playMp3:(UIButton *)button{
    NSInteger indexRow = button.tag;
    ChatModel *model = self.chatViewModel.arr[indexRow];
    [LSCoreToolCenter playMusic:model.msgContents];
}


#pragma UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatViewModel.arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatModel *model = self.chatViewModel.arr[indexPath.row];
    if ([model.msgType isEqualToString:@"2"]) {
        
        return [self h_w:84];
        
    }{
        CGSize size = [model.msgContents sizeWithFont:H14 constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height+[self h_w:70];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatModel *model = self.chatViewModel.arr[indexPath.row];
    if (![model.msgSenderId isEqualToString:self.myMsgModel.msgUserCode]){
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:30])];
        time.text = model.msgSendDate;
        time.textColor = MAIN_PAN_2;
        time.font = H14;
        time.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:time];
        IconView * icon = [[IconView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-[self h_w:60], [self h_w:23], [self h_w:50], [self h_w:50])];
        [cell addSubview:icon];
        
        [icon setContent:model.msgSenderName and:orange_color];
        
        if ([model.msgType isEqualToString:@"2"]) {
            [cell addSubview:[self yuyinView:model.msgVolumnTime.intValue from:YES withIndexRow:indexPath.row withPosition:65]];
        }else{
            [cell addSubview:[self bubbleView:model.msgContents from:YES withPosition:65]];
        }
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:30])];
        time.text = model.msgSendDate;
        time.textColor = MAIN_PAN_2;
        time.font = H14;
        time.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:time];
        IconView * icon = [[IconView alloc] initWithFrame:CGRectMake(10, [self h_w:23], [self h_w:50], [self h_w:50])];
        
        [cell addSubview:icon];
        [icon setContent:self.myMsgModel.msgUserName and:purple_color];
        
        if ([model.msgType isEqualToString:@"2"]) {
            [cell addSubview:[self yuyinView:model.msgVolumnTime.intValue from:NO withIndexRow:indexPath.row withPosition:65]];
        } else {
            [cell addSubview:[self bubbleView:model.msgContents from:NO withPosition:65]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end

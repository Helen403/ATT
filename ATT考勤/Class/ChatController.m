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


@interface ChatController ()<UITableViewDelegate,UITableViewDataSource,MoreButtonViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,InputToolbarDelegate>

@property (nonatomic, strong) NSMutableArray *resultArray;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) ChatViewModel *chatViewModel;

@property (nonatomic,strong)InputToolbar *inputToolbar;

@property (nonatomic,assign)CGFloat inputToolbarY;

@end

@implementation ChatController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"聊天";
}

-(void)h_addSubviews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputToolbar];
    //滚动到最底下
    [self tableViewScrollCurrentIndexPath];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification *)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;

    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.tableView.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
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
            
            [weakSelf sendMsg:((NSAttributedString *)content).string];
        };
        
        _inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
            _inputToolbarY = orignY;
        };
        [_inputToolbar resetInputToolbar];
    }
    return _inputToolbar;

}


-(void)sendMsg:(NSString *)content{
    ChatModel *chat = [[ChatModel alloc] init];
    chat.judge = @"0";
    chat.img = @"photo1";
    chat.name = @"helen";
    chat.content = content;
    
    
    [self.resultArray addObject:chat];
    [self.tableView reloadData];
    //滚动到最底下
    [self tableViewScrollCurrentIndexPath];
}

-(void)tableViewScrollCurrentIndexPath{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.resultArray.count-1 inSection:0];
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
-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
        [_resultArray addObjectsFromArray:self.chatViewModel.arr];
    }
    return _resultArray;
    
}

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
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-[self h_w:49]);
        
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
        returnView.frame = CGRectMake(SCREEN_WIDTH-position-(bubbleText.frame.size.width+30.0f), 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    else
        returnView.frame = CGRectMake(position, 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
    
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
    if(fromSelf)
        button.frame =CGRectMake(SCREEN_WIDTH-position-yuyinwidth, 10, yuyinwidth, 54);
    else
        button.frame =CGRectMake(position, 10, yuyinwidth, 54);
    
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

#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatModel *model = self.resultArray[indexPath.row];
    
    CGSize size = [model.content sizeWithFont:H14 constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+[self h_w:30];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatModel *model = self.resultArray[indexPath.row];
    if ([model.judge isEqualToString:@"0"]) {
        static NSString *CellIdentifier1 = @"Cell1";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        UITableViewCell *cell = nil;
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView * photo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
            [cell addSubview:photo];
            photo.image = ImageNamed(model.img);
            
            
            if ([model.content isEqualToString:@"0"]) {
                [cell addSubview:[self yuyinView:1 from:YES withIndexRow:indexPath.row withPosition:65]];
            }else{
                [cell addSubview:[self bubbleView:model.content from:YES withPosition:65]];
            }
            
        }
        return cell;
        
    }else{
        static NSString *CellIdentifier2 = @"Cell2";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
         UITableViewCell *cell = nil;
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView * photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            [cell addSubview:photo];
            photo.image = ImageNamed(model.img);
            
            if ([model.content isEqualToString:@"0"]) {
                [cell addSubview:[self yuyinView:1 from:NO withIndexRow:indexPath.row withPosition:65]];
            }else{
                [cell addSubview:[self bubbleView:model.content from:NO withPosition:65]];
            }
 
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

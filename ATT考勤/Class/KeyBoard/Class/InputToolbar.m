//
//  InputToolbar.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//


#define customKeyboardHeight 200
#define InputToolbarHeight 49
#define NavigationHeight 64

#define kFakeTimerDuration       0.2
#define kMaxRecordDuration       60     //最长录音时长
#define kRemainCountingDuration  10     //剩余多少秒开始倒计时

#import "InputToolbar.h"
#import "UIView+Extension.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+BBVoiceRecord.h"
#import "UIColor+BBVoiceRecord.h"
#import "BBVoiceRecordController.h"


@interface InputToolbar ()<UITextViewDelegate,EmojiButtonViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, assign)CGFloat textInputHeight;
@property (nonatomic, assign)NSInteger TextInputMaxHeight;
@property (nonatomic, assign)NSInteger keyboardHeight;
@property (nonatomic, assign)BOOL showKeyboardButton;

@property (nonatomic,strong)UIButton *voiceButton;
@property(nonatomic,strong) UILabel *voiceLabel;

@property (nonatomic,strong)UITextView *textInput;
@property (nonatomic,strong)UIButton *emojiButton;
@property (nonatomic,strong)UIButton *moreButton;

@property (nonatomic,strong)VoiceButtonView *voiceButtonView;
@property (nonatomic,strong)EmojiButtonView *emojiButtonView;
@property (nonatomic,strong)MoreButtonView *moreButtonView;


//==================================

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSInteger countDown;
@property(nonatomic,strong) NSString *filePath;
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器
@property (nonatomic, strong) AVAudioPlayer *player; //播放器
@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址

//==================================

@property (nonatomic, assign) BBVoiceRecordState currentRecordState;

@property (nonatomic, strong) NSTimer *fakeTimer;

@property (nonatomic, strong) BBVoiceRecordController *voiceRecordCtrl;
@property (nonatomic, assign) float duration;
@property (nonatomic, assign) BOOL canceled;

@end

@implementation InputToolbar

- (VoiceButtonView *)leftButtonView
{
    if (!_voiceButtonView) {
        _voiceButtonView = [[VoiceButtonView alloc] init];
        _voiceButtonView.width = self.width;
        _voiceButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _voiceButtonView;
}

-(UILabel *)voiceLabel{
    if (!_voiceLabel) {
        _voiceLabel = [[UILabel alloc] init];
        _voiceLabel.text = @"按住 说话";
        _voiceLabel.backgroundColor = white_color;
        _voiceLabel.font = H14;
        _voiceLabel.textColor = MAIN_PAN_2;
        _voiceLabel.textAlignment = NSTextAlignmentCenter;
        _voiceLabel.hidden = YES;
        _voiceLabel.userInteractionEnabled = YES;
        ViewBorderRadius(_voiceLabel, 5, 1, [UIColor lightGrayColor]);
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
        
        //代理
        longPress.delegate = self;
        longPress.minimumPressDuration = 0.5;
        [_voiceLabel addGestureRecognizer:longPress];
    }
    return _voiceLabel;
}

//长按事件的实现方法

- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state ==  UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan");
        self.voiceLabel.text = @"松手停止录音";
        self.currentRecordState = BBVoiceRecordState_Recording;
        self.voiceLabel.backgroundColor = [UIColor colorWithHex:0xC6C7CA];
        self.countDown = 0;
        [self startRecordNotice];
        [self startFakeTimer];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"UIGestureRecognizerStateEnded");
        self.currentRecordState = BBVoiceRecordState_ReleaseToCancel;
        self.voiceLabel.text = @"按住 说话";
        self.voiceLabel.backgroundColor = white_color;
        [self stopRecordNotice];
        [self stopFakeTimer];
    }
}

- (void)startFakeTimer{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
    self.fakeTimer = [NSTimer scheduledTimerWithTimeInterval:kFakeTimerDuration target:self selector:@selector(onFakeTimerTimeOut) userInfo:nil repeats:YES];
    [_fakeTimer fire];
}

- (void)onFakeTimerTimeOut{
    self.duration += kFakeTimerDuration;
    NSLog(@"+++duration+++ %f",self.duration);
    float remainTime = kMaxRecordDuration-self.duration;
    //if ((int)remainTime == 0) {
      //  self.currentRecordState = BBVoiceRecordState_Normal;
        //[self dispatchVoiceState];
    //}else{
        
        float fakePower = (float)(1+arc4random()%99)/100;
        [self.voiceRecordCtrl showRecordCounting:fakePower];
       // [self.voiceRecordCtrl updatePower:fakePower];
   // }
}

- (void)stopFakeTimer{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
}



- (void)dispatchVoiceState
{
    if (_currentRecordState == BBVoiceRecordState_Recording) {
        self.canceled = NO;
        [self startFakeTimer];
    }
    else if (_currentRecordState == BBVoiceRecordState_Normal){
       // [self resetState];
    }
   // [_btnRecord updateRecordButtonStyle:_currentRecordState];
    [self.voiceRecordCtrl updateUIWithRecordState:_currentRecordState];
}


-(void)startRecordNotice{
    NSLog(@"开始录音");
    [self addTimer];
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    self.session = session;
    //1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:self.filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        
    }
}

- (BBVoiceRecordController *)voiceRecordCtrl{
    if (_voiceRecordCtrl == nil) {
        _voiceRecordCtrl = [BBVoiceRecordController new];
    }
    return _voiceRecordCtrl;
}

-(void)stopRecordNotice{
    [self removeTimer];
    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self.filePath]){
        self.voiceRecord(self.recordFileUrl,self.countDown);
    }else{
        //_noticeLabel.text = @"最多录60秒";
    }
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }else{
        NSLog(@"计算文件大小：文件不存在");
    }
    
    return 0;
}




/**
 *  添加定时器
 */
- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}


-(void)refreshLabelText{
    ++self.countDown;
}

- (EmojiButtonView *)emojiButtonView
{
    if (!_emojiButtonView) {
        _emojiButtonView = [[EmojiButtonView alloc] init];
        _emojiButtonView.delegate = self;
        _emojiButtonView.width = self.width;
        _emojiButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _emojiButtonView;
}

- (MoreButtonView *)moreButtonView
{
    if (!_moreButtonView) {
        _moreButtonView = [[MoreButtonView alloc] init];
        _moreButtonView.width = self.width;
        _moreButtonView.height = customKeyboardHeight;
        _keyboardHeight = customKeyboardHeight;
    }
    return _moreButtonView;
}

static InputToolbar* _instance = nil;
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[InputToolbar alloc] init] ;
    });
    return _instance ;
}

+ (instancetype)alloc
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init] ;
    });
    return _instance ;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        [self layoutUI];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardFrame.size.height+60;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:7];
    self.y = keyboardFrame.origin.y - self.height-60;
    [UIView commitAnimations];
    _inputToolbarFrameChange(self.height,self.y);
    self.keyboardIsVisiable = YES;
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.y = keyboardFrame.origin.y - self.height-60;
    }];
    _inputToolbarFrameChange(self.height,self.y);
    self.keyboardIsVisiable = NO;
    [self setShowKeyboardButton:NO];
}

- (void)layoutUI
{
    self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 9, 30, 30)];
    [self.voiceButton setImage:[UIImage imageNamed:@"liaotian_ic_yuyin_nor"] forState:UIControlStateNormal];
    [self.voiceButton setImage:[UIImage imageNamed:@"liaotian_ic_press"] forState:UIControlStateHighlighted];
    [self.voiceButton addTarget:self action:@selector(clickVoiceButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voiceButton];
    
    
    self.textInput = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.voiceButton.frame) + 5, 5, SCREEN_WIDTH - 115, 36)];
    self.textInput.font = [UIFont systemFontOfSize:18];
    self.textInput.layer.cornerRadius = 3;
    self.textInput.layer.masksToBounds = YES;
    self.textInput.returnKeyType = UIReturnKeySend;
    self.textInput.enablesReturnKeyAutomatically = YES;
    self.textInput.delegate = self;
    [self addSubview:self.textInput];
    
    self.voiceLabel.frame = CGRectMake(CGRectGetMaxX(self.voiceButton.frame) + 5, 5, SCREEN_WIDTH - 115, 36);
    [self addSubview:self.voiceLabel];
    
    self.emojiButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textInput.frame) + 5, 9, 30, 30)];
    [self.emojiButton setImage:[UIImage imageNamed:@"liaotian_ic_biaoqing_nor"] forState:UIControlStateNormal];
    [self.emojiButton setImage:[UIImage imageNamed:@"liaotian_ic_biaoqing_press"] forState:UIControlStateHighlighted];
    [self.emojiButton addTarget:self action:@selector(clickEmojiButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.emojiButton];
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.emojiButton.frame) + 5, 9, 30, 30)];
    [self.moreButton setImage:[UIImage imageNamed:@"liaotian_ic_gengduo_nor"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"liaotian_ic_gengduo_press"] forState:UIControlStateHighlighted];
    [self.moreButton addTarget:self action:@selector(clickMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreButton];
}



- (void)textViewDidChange:(UITextView *)textView
{
    _textInputHeight = ceilf([self.textInput sizeThatFits:CGSizeMake(self.textInput.bounds.size.width, MAXFLOAT)].height);
    self.textInput.scrollEnabled = _textInputHeight > _TextInputMaxHeight && _TextInputMaxHeight > 0;
    if (self.textInput.scrollEnabled) {
        self.textInput.height = 5 + _TextInputMaxHeight;
        self.y = SCREEN_HEIGHT - _keyboardHeight - _TextInputMaxHeight - 5 - 8;
        self.height = _TextInputMaxHeight + 15;
    } else {
        self.textInput.height = _textInputHeight;
        self.y = SCREEN_HEIGHT - _keyboardHeight - _textInputHeight - 5 - 8;
        self.height = _textInputHeight + 15;
    }
    if ([_delegate respondsToSelector:@selector(inputToolbar:orignY:)]) {
        [_delegate inputToolbar:self orignY:self.y];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textInput.inputView = nil;
}

- (void)emojiButtonView:(EmojiButtonView *)emojiButtonView emojiText:(NSObject *)text
{
    if ([text  isEqual: deleteButtonId]) {
        [self.textInput deleteBackward];
        return;
    }
    if (![text isKindOfClass:[UIImage class]]) {
        [self.textInput replaceRange:self.textInput.selectedTextRange withText:(NSString *)text];
    } else {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
        textAttachment.image = (UIImage *)text;
        textAttachment.bounds = CGRectMake(0, - 5, self.textInput.font.lineHeight + 2, self.textInput.font.lineHeight + 2);
        NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.textInput.attributedText];
        [strM replaceCharactersInRange:self.textInput.selectedRange withAttributedString:imageText];
        [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(self.textInput.selectedRange.location, 1)];
        self.textInput.attributedText = strM;
        self.textInput.selectedRange = NSMakeRange(self.textInput.selectedRange.location + 1,0);
        [self.textInput.delegate textViewDidChange:self.textInput];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if (_sendContent) {
            _sendContent(self.textInput.attributedText);
            self.y = SCREEN_HEIGHT - _keyboardHeight - InputToolbarHeight;
            _inputToolbarFrameChange(self.height,self.y);
        }
        textView.text = nil;
        self.textInput.height = 36;
        self.height = InputToolbarHeight;
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   /* if (_sendContent) {
        _sendContent(self.textInput.attributedText);
        self.y = SCREEN_HEIGHT - _keyboardHeight - InputToolbarHeight;
        _inputToolbarFrameChange(self.height,self.y);
    }
    self.textInput.text = nil;
    self.textInput.height = 36;
    self.height = InputToolbarHeight;
    NSLog(@"点击了搜索");*/
    return YES;
}


- (void)emojiButtonView:(EmojiButtonView *)emojiButtonView sendButtonClick:(UIButton *)sender
{
    if (_sendContent) {
        _sendContent(self.textInput.attributedText);
        self.y = SCREEN_HEIGHT - _keyboardHeight - InputToolbarHeight;
        _inputToolbarFrameChange(self.height,self.y);
    }
    self.textInput.text = nil;
    self.textInput.height = 36;
    self.height = InputToolbarHeight;
}

- (void)clickVoiceButton{
    if (self.voiceLabel.isHidden) {
        self.voiceLabel.hidden = NO;
        [self.voiceLabel setEnabled:YES];
        [self setIsBecomeFirstResponder:NO];
    }else{
        self.voiceLabel.hidden = YES;
        [self.voiceLabel setEnabled:NO];
        [self setIsBecomeFirstResponder:NO];
    }
}


- (void)clickEmojiButton
{
    self.voiceLabel.hidden = YES;
    if (self.textInput.inputView == nil || !self.keyboardIsVisiable) {
        self.textInput.inputView = self.emojiButtonView;
        self.showKeyboardButton = YES;
    } else {
        
        if (self.textInput.inputView != self.emojiButtonView) {
            self.textInput.inputView = self.emojiButtonView;
            self.showKeyboardButton = YES;
        } else {
            self.textInput.inputView = nil;
            self.showKeyboardButton = NO;
        }
    }
    [self.textInput endEditing:YES];
    [self.textInput becomeFirstResponder];
}

- (void)clickMoreButton
{
    self.voiceLabel.hidden = YES;
    [self switchToKeyboard:self.moreButtonView];
}

- (void)switchToKeyboard:(UIView *)keyboard
{
    if (self.textInput.inputView == nil || !self.keyboardIsVisiable) {
        self.textInput.inputView = keyboard;
    } else {
        //优先弹出非键盘keyboard
        if (self.textInput.inputView != keyboard) {
            self.textInput.inputView = keyboard;
        } else {
            self.textInput.inputView = nil;
        }
        self.showKeyboardButton = NO;
    }
    [self.textInput endEditing:YES];
    [self.textInput becomeFirstResponder];
}

- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"liaotian_ic_biaoqing_nor";
    NSString *highImage = @"liaotian_ic_biaoqing_press";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"liaotian_ic_jianpan_nor";
        highImage = @"liaotian_ic_jianpan_press";
    }
    
    // 设置图片
    [self.emojiButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emojiButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

- (void)setIsBecomeFirstResponder:(BOOL)isBecomeFirstResponder
{
    if (isBecomeFirstResponder) {
        [self.textInput becomeFirstResponder];
    } else {
        [self.textInput resignFirstResponder];
    }
}

- (void)setMorebuttonViewDelegate:(id)delegate
{
    self.moreButtonView.delegate = delegate;
}

- (void)setTextViewMaxVisibleLine:(NSInteger)textViewMaxVisibleLine
{
    _textViewMaxVisibleLine = textViewMaxVisibleLine;
    _TextInputMaxHeight = ceil(self.textInput.font.lineHeight * (textViewMaxVisibleLine - 1) + self.textInput.textContainerInset.top + self.textInput.textContainerInset.bottom);
}

- (void)clearInputToolbarContent
{
    self.textInput.text = nil;
}

- (void)resetInputToolbar
{
    self.textInput.text = nil;
    self.textInput.height = 36;
    self.height = InputToolbarHeight;
}

@end

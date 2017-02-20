//
//  ScanCodeController.m
//  ATT考勤
//
//  Created by Helen on 17/2/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ScanCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanCodeViewModel.h"
#import "ScanCodeModel.h"

#import "CompanyCodeCellView.h"

/**
 *  屏幕 高 宽 边界
 */

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface ScanCodeController ()<AVCaptureMetadataOutputObjectsDelegate,UITableViewDelegate,UITableViewDataSource>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) ScanCodeViewModel *scanCodeViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ScanCodeController

#pragma mark system
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"扫码加入";
}

-(void)h_bindViewModel{
    [[self.scanCodeViewModel.addclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        if (self.index == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
        }
    }];
    
    //加入公司后弹出部门选择
    [[self.scanCodeViewModel.showClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
}


-(void)mainThread{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, self.scanCodeViewModel.arr.count*[self h_w:40]);
    [self.tableView reloadData];
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].tapOutsideToDismiss = NO;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:self.tableView animated:NO];
}



-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 30)];
    label.center = CGPointMake(SCREEN_WIDTH*0.5, TOP+220+30);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"将二维码放在取景框内可自动扫码";
    label.textColor = MAIN_ORANGER;
    label.font = H12;
    [self.view addSubview:label];
    
    //    NSString *str = @"{companyCode:3,companyInvitationCode:'ccc'}";
    //
    //
    //    NSLog(@"666");
    //    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([self h_w:10], TOP+220+30+30, SCREEN_WIDTH-[self h_w:20], [self h_w:35])];
    //    [button setTitle:@"取消" forState:UIControlStateNormal];
    //    button.titleLabel.textColor = white_color;
    //    button.titleLabel.font = H20;
    //    [button addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [button.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    //
    //    [button.layer setCornerRadius:10];
    //
    //    [button.layer setBorderWidth:2];//设置边界的宽度
    //
    //    [button setBackgroundColor:MAIN_ORANGER];
    //    //设置按钮的边界颜色
    //    [button.layer setBorderColor:MAIN_ORANGER.CGColor];
    //
    //    [self.view addSubview:button];
    
}
//-(void)finish:(UIButton *)button{
//
//}


-(void)viewWillAppear:(BOOL)animated{
    
    [self setCropRect:kScanRect];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

- (void)setCropRect:(CGRect)cropRect{
    
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.3];
    
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
    
    
    
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //        NSLog(@"扫描结果：%@",stringValue);
        
        
        stringValue =  [LSCoreToolCenter changeJsonStringToTrueJsonString:stringValue];
        NSDictionary *dict = [stringValue dictionaryWithJsonString];
        ScanCodeModel *scanCodeModel =  [ScanCodeModel mj_objectWithKeyValues:dict];
        NSString *str =  [[NSUserDefaults standardUserDefaults] objectForKey:@"returnCode"];
        self.scanCodeViewModel.userCode = str;
        self.scanCodeViewModel.inviteCode = scanCodeModel.companyInvitationCode;
        [self.scanCodeViewModel.sendclickCommand execute:nil];
        //        NSArray *arry = metadataObject.corners;
        //        for (id temp in arry) {
        //            NSLog(@"%@",temp);
        //        }
        
        
        //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        //        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //            if (_session != nil && timer != nil) {
        //                [_session startRunning];
        //                [timer setFireDate:[NSDate date]];
        //            }
        //
        //        }]];
        //        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

-(ScanCodeViewModel *)scanCodeViewModel{
    if (!_scanCodeViewModel) {
        _scanCodeViewModel = [[ScanCodeViewModel alloc] init];
    }
    return _scanCodeViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyCodeCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyCodeCellView class])]];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.scanCodeViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyCodeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyCodeCellView class])] forIndexPath:indexPath];
    
    cell.teamModel = self.scanCodeViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamModel *teamModel =  self.scanCodeViewModel.arr[indexPath.row];
    self.scanCodeViewModel.deptCode = teamModel.deptCode;
    [self.scanCodeViewModel.addTeamCommand execute:nil];
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        
    }];
}


@end

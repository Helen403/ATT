//
//  MineController.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MineController.h"
#import "MineView.h"
#import "MineViewModel.h"

#import "TZImagePickerController.h"
#import "ChangeNameController.h"
#import "ChangeSignNameController.h"
#import "UserModel.h"
#import "MySchedulieController.h"


@interface MineController ()<TZImagePickerControllerDelegate>

@property(nonatomic,strong) MineView *mineView;

@property(nonatomic,strong) MineViewModel *mineViewModel;

@property(nonatomic,strong) TZImagePickerController *imagePickerVc;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.mineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的信息";
}

-(void)h_viewWillAppear{
    [self.mineView h_refreash];
}

-(void)h_addSubviews{
    [self.view addSubview:self.mineView];
}

-(void)h_bindViewModel{
    //跳转到考勤
    [[self.mineViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x intValue]) {
            //上传头像
            case 0:{
                [self imagePicker];
                break;
            }
                //修改名字
            case 1:{
                ChangeNameController *changeName = [[ChangeNameController alloc] init];
                
                [self.navigationController pushViewController:changeName animated:NO];
                
                break;
            }
                //修改签名
            case 2:{
            
                ChangeSignNameController *signName = [[ChangeSignNameController alloc] init];
                
                [self.navigationController pushViewController:signName animated:NO];
                
                break;
            }
                //我的排班
            case 6:{
                MySchedulieController *mySchedulie = [[MySchedulieController alloc] init];
                
                [self.navigationController pushViewController:mySchedulie animated:NO];
                
                break;
            }
        
        }
    }];
}

/**
 *  上传头像
 */
-(void)imagePicker{
    [self presentViewController:self.imagePickerVc animated:YES completion:nil];
}

-(TZImagePickerController *)imagePickerVc{
    if (!_imagePickerVc) {
        _imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        _imagePickerVc.sortAscendingByModificationDate = NO;
//        _imagePickerVc.allowCrop = YES;
//        _imagePickerVc.cropRect = CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH);
        _imagePickerVc.photoWidth = 300;
        _imagePickerVc.photoPreviewMaxWidth = 300;
    }
    return _imagePickerVc;
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    UIImage *img = photos[0];
    NSData *data = UIImagePNGRepresentation(img);
    NSString *base64Str = [LSCoreToolCenter Base64StrWithMp3Data:data];
    
    if ([LSCoreToolCenter isBlankString:base64Str]) {
        return;
    }
    UserModel *userModel = getModel(@"user");
    self.mineViewModel.fileName =[NSString stringWithFormat:@"%@%@.png",userModel.userCode,[LSCoreToolCenter currentYearYMDHMSA]];
    self.mineViewModel.content = base64Str;
    self.mineViewModel.fileType = @"image";
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    NSString *imagePath = [NSString stringWithFormat:@"%@portrait/%@",vadaMusic,self.mineViewModel.fileName];
    self.mineViewModel.userCode = userModel.userCode;
    self.mineViewModel.companyCode =  companyCode;
    self.mineViewModel.imagePath = imagePath;
    [self.mineViewModel.updataCommand execute:nil];
}

#pragma mark lazyload
-(MineView *)mineView{
    if (!_mineView) {
        _mineView = [[MineView alloc] initWithViewModel:self.mineViewModel];
    }
    return _mineView;
}


-(MineViewModel *)mineViewModel{
    if (!_mineViewModel) {
        _mineViewModel = [[MineViewModel alloc] init];
    }
    return _mineViewModel;
    
}

@end

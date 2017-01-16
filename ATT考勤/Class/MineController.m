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
#import "CheckController.h"
#import "TZImagePickerController.h"


@interface MineController ()<TZImagePickerControllerDelegate>

@property(nonatomic,strong) MineView *mineView;

@property(nonatomic,strong) MineViewModel *mineViewModel;

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
               //跳转到考勤
            case 7:{
                CheckController *check = [[CheckController alloc] init];
                [self.navigationController pushViewController:check animated:NO];
                break;
            }
                
            default:
                break;
        }

    }];
}

/**
 *  上传头像
 */
-(void)imagePicker{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
//        
//    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
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

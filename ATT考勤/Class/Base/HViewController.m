//
//  HViewController.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewController.h"
#import "HView.h"

@interface HViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@end

@implementation HViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    HViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController h_addSubviews];
        [viewController h_loadData];
        [viewController h_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController h_layoutNavigation];
        [viewController h_viewWillAppear];
        
    }];
    
    
    [[viewController rac_signalForSelector:@selector(viewWillDisappear:
                                                     )] subscribeNext:^(id x) {
        
        @strongify(viewController)
        
        [viewController h_viewWillDisappear];
        
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setIsExtendLayout:NO];
    
    [self h_removeNavgationBarLine];
    
    [self layoutNavigationBar:[UIImage imageNamed:@"navigationBarBG@2x.png"] titleColor:[UIColor blackColor] titleFont:[UIFont fontWithName:@"MicrosoftYaHei" size:18] leftBarButtonItem:nil rightBarButtonItem:nil];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - system
//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//    if (self.statusBarStyle) {
//
//        return self.statusBarStyle;
//    } else {
//
//        return UIStatusBarStyleLightContent;
//    }
//}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    //    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)h_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden = isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden = isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)h_addSubviews {}

/**
 *  绑定
 */
- (void)h_bindViewModel {}

/**
 *  设置navation
 */
- (void)h_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)h_viewWillAppear {
    
}


-(void)h_viewWillDisappear{
}

-(void)h_loadData{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Toast
//-(void)toast:(NSString *)text{
//    [Toast showWithText:text bottomOffset:60];
//}

-(NSInteger)h_w:(NSInteger)width{
    return autoScaleW(width);
}

//-(void)hideNav{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//}

@end

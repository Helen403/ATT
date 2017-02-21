//
//  HView.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HView.h"
#import "AppDelegate.h"

@implementation HView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self h_setupViews];
        [self h_loadData];
        [self h_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self h_setupViews];
        [self h_loadData];
        [self h_bindViewModel];
    }
    return self;
}


- (void)h_setupViews {
}

- (void)h_loadData{

}

- (void)h_bindViewModel {
}

- (void)h_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}


-(NSInteger)h_w:(NSInteger)width{
    return autoScaleW(width);
}


//Toast
//-(void)toast:(NSString *)text{
//    [Toast showWithText:text bottomOffset:60];
//}

-(UIView *)rippleView{
    if (!_rippleView) {
        _rippleView = [[UIView alloc] initWithFrame:(CGRect){0,0,300,300}];
        _rippleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _rippleView.layer.cornerRadius = 150;
        _rippleView.layer.masksToBounds=true;
        _rippleView.alpha=0;
        
    }
    return _rippleView;
}

-(void)addDynamic:(UIView *)tmpView{
    self.tmpView = tmpView;
    self.tmpView.userInteractionEnabled = YES;
    UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    [self.tmpView addGestureRecognizer:setTap];
}

-(void)onClick:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.tmpView];
    
    [self.tmpView endEditing:YES];
    
    [self.tmpView addSubview:self.rippleView];
    self.rippleView.center = point;
    self.rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.1
                     animations:^{
                         self.rippleView.alpha=1;
                     }];
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.rippleView.transform = CGAffineTransformMakeScale(1,1);
                         self.rippleView.alpha=0;
                     } completion:^(BOOL finished) {
                         
                         [self.rippleView removeFromSuperview];
                     }];
}

@end

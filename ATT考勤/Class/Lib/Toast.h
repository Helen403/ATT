//
//  Toast.h
//
//  Created by Helen on 16/11/20.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//[Toast showWithText:@"中间显示" duration:5];
//[Toast showWithText:@"距离上方50像素" topOffset:50 duration:5];
//[Toast showWithText:@"文字很多的时候，我就会自动折行，最大宽度280像素" topOffset:100 duration:5];
//[Toast showWithText:@"加入\\n也可以\n显示\n多\n行" topOffset:300 duration:5];
//[Toast showWithText:@"距离下方3像素" bottomOffset:3 duration:5];

#define DEFAULT_DISPLAY_DURATION 1.0f

@interface Toast : NSObject
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;

@end



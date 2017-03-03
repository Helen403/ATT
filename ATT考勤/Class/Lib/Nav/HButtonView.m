//
//  HelenButtonView.m
//  优积分
//
//  Created by Helen on 16/10/1.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HButtonView.h"

#define paddingTop 5
//图片和文字之间的间距
#define drawPadding 2

@implementation HButtonView


//重写图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    int W = contentRect.size.width;
    int H = contentRect.size.height;
    CGFloat imageW = H*4/9.0;
    CGFloat imageH = H*4/9.0;
    CGFloat imageX = (W - imageW) * 0.5;
    CGFloat imageY = paddingTop;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//重写文字的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    int W = contentRect.size.width;
    int H = contentRect.size.height;
    CGFloat titleW = W;
    //整个的高度－paddingTop－图片高度－底部的paddingTop;
    CGFloat titleH = H-paddingTop-H*4/9.0-paddingTop;
    CGFloat titleX = (W - titleW) * 0.5;
    //整个的高度－paddingTop-图片高度－drawPadding
    CGFloat titleY = paddingTop+H*4/9.0+drawPadding;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //[super setHighlighted:highlighted];
}

@end

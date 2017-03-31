/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: UILabel的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */

/**********************************************************************************************
 **********************************************************************************************
 摘抄自：http://www.th7.cn/Program/IOS/201603/790469.shtml
 UILabel的attributedText属性解析介绍
 
 1> NSFontAttributeName(字体)
 该属性所对应的值是一个 UIFont 对象。该属性用于改变一段文本的字体。如果不指定该属性，则默认为12-point Helvetica(Neue)。
 
 2> NSParagraphStyleAttributeName(段落)
 该属性所对应的值是一个 NSParagraphStyle 对象。该属性在一段文本上应用多个属性。如果不指定该属性，则默认为 NSParagraphStyle 的defaultParagraphStyle 方法返回的默认段落属性。
 
 3> NSForegroundColorAttributeName(字体颜色)
 该属性所对应的值是一个 UIColor 对象。该属性用于指定一段文本的字体颜色。如果不指定该属性，则默认为黑色
 
 4> NSBackgroundColorAttributeName(字体背景色）
 该属性所对应的值是一个 UIColor 对象。该属性用于指定一段文本的背景颜色。如果不指定该属性，则默认无背景色。
 
 5> NSLigatureAttributeName(连字符)
 该属性所对应的值是一个 NSNumber 对象(整数)。连体字符是指某些连在一起的字符，它们采用单个的图元符号。0 表示没有连体字符。1 表示使用默认的连体字符。2表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）。
 
 6> NSKernAttributeName(字间距)
 该属性所对应的值是一个 NSNumber 对象(整数)。字母紧排指定了用于调整字距的像素点数。字母紧排的效果依赖于字体。值为 0 表示不使用字母紧排。默认值为0。
 
 7> NSStrikethroughStyleAttributeName(删除线)
 该属性所对应的值是一个 NSNumber 对象(整数)。该值指定是否在文字上加上删除线，该值参考“Underline Style Attributes”。默认值是NSUnderlineStyleNone。
 
 8> NSUnderlineStyleAttributeName(下划线)
 该属性所对应的值是一个 NSNumber 对象(整数)。该值指定是否在文字上加上下划线，该值参考“Underline Style Attributes”。默认值是NSUnderlineStyleNone。
 
 9> NSStrokeColorAttributeName(边线颜色)
 该属性所对应的值是一个 UIColor 对象。如果该属性不指定（默认），则等同于 NSForegroundColorAttributeName。否则，指定为删除线或下划线颜色。更多细节见“Drawing attributedstrings that are both filled and stroked”。
 
 10> NSStrokeWidthAttributeName(边线宽度)
 该属性所对应的值是一个 NSNumber 对象(小数)。该值改变描边宽度（相对于字体size 的百分比）。默认为 0，即不改变。正数只改变描边宽度。负数同时改变文字的描边和填充宽度。例如，对于常见的空心字，这个值通常为3.0。
 
 11> NSShadowAttributeName(阴影)
 该属性所对应的值是一个 NSShadow 对象。默认为 nil。
 
 12> NSVerticalGlyphFormAttributeName(横竖排版)
 该属性所对应的值是一个 NSNumber 对象(整数)。0 表示横排文本。1 表示竖排文本。在 iOS 中，总是使用横排文本，0 以外的值都未定义。
 **********************************************************************************************
 **********************************************************************************************/

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
/*********************************************************************************************
**********************************************************************************************
 富文本的NSRange
**********************************************************************************************
**********************************************************************************************/
@interface RichLabelRange : NSObject

/**
 富文本的NSRange转对象构造方法
 */
+ (instancetype)richLabelRangeWithLoc:(NSUInteger)aLoc length:(NSUInteger)aLength;

/**
 构造NSRange
 */
- (NSRange)makeRange;

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@interface UILabel (YXAdd)
/**
 设置placeholder的颜色
 */
- (void)setPlaceholderTextColor:(UIColor *)aColor;

#pragma mark - 加上中划线或下划线

typedef NS_ENUM(NSInteger, LabelUnderline) {
    UnderlineMid,   // < 中划线
    UnderlineBottom // < 下划线
};

/**
 设置下划线或中划线，默认颜色为label的textColor
 */
- (void)setText:(NSString *)text forUnderlineStyle:(LabelUnderline)style;

/**
 设置下划线或中划线，并设置其颜色
 */
- (void)setText:(NSString *)text withColor:(UIColor *)aColor forUnderlineStyle:(LabelUnderline)style;

#pragma mark - 富文本

/**
 创建富文本label，使用时请注意allAttributes和allRanges的一一映射关系

 @param aRichText       富文本的字符串
 @param allAttributes   每段富文本的属性字典
 @param allRanges       每段富文本的位置信息
 */
- (void)setRichText:(NSString *)aRichText forAttributes:(NSArray <NSDictionary<NSString *,id> *>*)allAttributes withRanges:(NSArray <RichLabelRange *>*)allRanges;

/**********************************************************************************************
 **********************************************************************************************
 
 存在问题
 #pragma mark - 部分文字可点击
 
 部分文字可点击的回调
 
 @param string  被点击区域的文字
 @param range   被点击文字的range
typedef void(^LabelParTapBlock)(NSString *string , NSRange range);
 
 给部分文字添加点击事件，注意只判断了attributedText
 - (void)addParTapForString:(NSArray <NSString *>*)strings tapAcionBlock:(LabelParTapBlock)aTapBlock;
 
 **********************************************************************************************
 **********************************************************************************************/

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: UILabel的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */

#import "UILabel+YXAdd.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

///**
// 计算totalString中aString的所有NSRange
// */
//static NSArray <RichLabelRange *>* caculateSameStr(NSString *aString, NSAttributedString *totalString)
//{
//    NSString *aTotalString = totalString.string.copy;
//
//    NSRange range = [aTotalString rangeOfString:aString];
//    if (range.location == NSNotFound) return nil;
//    NSMutableArray *rlrArr = [NSMutableArray array];
//    NSUInteger length = 0;
//    while (range.location != NSNotFound) {
//        [rlrArr addObject:[RichLabelRange richLabelRangeWithLoc:range.location+length length:range.length]];
//        aTotalString = [aTotalString stringByReplacingCharactersInRange:range withString:@""];
//        range = [aTotalString rangeOfString:aString];
//        length = range.length;
//    }
//    return rlrArr;
//}
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@interface RichLabelRange ()

@property (nonatomic) NSUInteger loc;
@property (nonatomic) NSUInteger length;

@end

@implementation RichLabelRange

+ (instancetype)richLabelRangeWithLoc:(NSUInteger)aLoc length:(NSUInteger)aLength
{
    RichLabelRange *rlr = [RichLabelRange new];
    rlr.loc = aLoc;
    rlr.length = aLength;
    return rlr;
}

- (NSRange)makeRange
{
    return NSMakeRange(self.loc, self.length);
}

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@implementation UILabel (YXAdd)

- (void)setPlaceholderTextColor:(UIColor *)aColor
{
    [self setValue:aColor forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - 加上中划线或下划线

- (void)setText:(NSString *)text forUnderlineStyle:(LabelUnderline)style
{
    [self setText:text withColor:self.textColor forUnderlineStyle:style];
}

- (void)setText:(NSString *)text withColor:(UIColor *)aColor forUnderlineStyle:(LabelUnderline)style
{
    NSDictionary *attribtDic = nil;
    if (style == UnderlineMid) {
        //中划线
        attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName:aColor};
    }else {
        //下划线
        attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName:aColor};
    }
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
    self.attributedText = attribtStr;
}

#pragma mark - 富文本

- (void)setRichText:(NSString *)aRichText forAttributes:(NSArray <NSDictionary<NSString *,id> *>*)allAttributes withRanges:(NSArray <RichLabelRange *>*)allRanges
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:aRichText];
    NSAssert(allRanges.count == allAttributes.count, @"富文本的allAttributes和allRanges错误");
    [allAttributes enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attrStr addAttributes:obj range:[allRanges[idx] makeRange]];
    }];
    self.attributedText = attrStr;
}

/**********************************************************************************************
 **********************************************************************************************
#pragma mark - 部分文字可点击

static const char *kPartTapBlockKey = "kPartTapBlockKey";                   // < 关联所有点击字符串的回调block
static const char *kPartTapStringsRangesKey = "kPartTapStringsRangesKey";   // < 关联所有点击字符串的range数组
- (void)addParTapForString:(NSArray <NSString *>*)strings tapAcionBlock:(LabelParTapBlock)aTapBlock
{
    if (self.attributedText == nil) return;
    self.userInteractionEnabled = YES;
    // 获取ranges，如果没有就初始化一个，并设置关联
    NSMutableDictionary *stringsRanges = objc_getAssociatedObject(self, kPartTapStringsRangesKey);
    if (!stringsRanges) {
        stringsRanges = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, kPartTapStringsRangesKey, stringsRanges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *ranges = caculateSameStr(obj, self.attributedText);
        [stringsRanges setValue:ranges forKey:obj];
    }];
    // 关联回调
    objc_setAssociatedObject(self, kPartTapBlockKey, aTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LabelParTapBlock aBlock = objc_getAssociatedObject(self, kPartTapBlockKey);
    if (!aBlock) return;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self tapPoint:point labelParTapBlock:aBlock];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    LabelParTapBlock aBlock = objc_getAssociatedObject(self, kPartTapBlockKey);
    if (!aBlock) return [super hitTest:point withEvent:event];
    if ([self tapPoint:point labelParTapBlock:nil]) {
        return self;
    }else {
        return [super hitTest:point withEvent:event];
    }
}

- (BOOL)tapPoint:(CGPoint)point labelParTapBlock:(LabelParTapBlock)aResultBlock
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (self.attributedText.length > range.length) {
        
        UIFont *font ;
        
        if ([self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            
            font = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
            
        }else if (self.font){
            font = self.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        return NO;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
    
    CGFloat verticalOffset = 0;
    
    NSMutableDictionary *stringsRanges = objc_getAssociatedObject(self, kPartTapStringsRangesKey);
    
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
 
        CGRect flippedRect = [self lineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        
        CGFloat lineSpace;
        
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        
        if (CGRectContainsPoint(rect, point)) {
            
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            
            CGFloat offset;
            
            CTLineGetOffsetForStringIndex(line, index, &offset);
            
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            
            NSArray *keys = stringsRanges.allKeys;
            NSInteger link_count = keys.count;
            
            for (int j = 0; j < link_count;++ j ) {
                NSString *str = keys[j];
                NSArray *values = stringsRanges[str];
                NSInteger range_count = values.count;
                
                for (int n = 0; n < range_count;++ n ) {
                    RichLabelRange *rlr = values[n];
                    NSRange range = [rlr makeRange];
#warning 有问题
                    if (index >= range.location && index <= range.location+range.length) {
                        if (aResultBlock) {
                            aResultBlock (str , [rlr makeRange]);
                        }
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (CGRect)lineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}
 **********************************************************************************************
 **********************************************************************************************/

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

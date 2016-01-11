
//
//  GRMessagesTextView.m
//  GRMessages
//
//  Created by chengbin on 15/12/30.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import "GRMessagesTextView.h"
#import "NSString+Extensions.h"
#if !__has_feature(objc_arc)
#error This file must be complied with ARC. Convert your project to ARC or specify the -fobjc-arc flag.
#endif

@implementation GRMessagesTextView
#pragma mark- Initialization

-(void)_configureTextView{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    CGFloat cornerRadius = 6.0f;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(cornerRadius, 0.0, cornerRadius, 0.0f);
    self.contentInset = UIEdgeInsetsMake(1.0, 0.0f, 1.0f, 0.0f);
    self.textContainerInset = UIEdgeInsetsMake(4.0f, 2.0f, 4.0f, 2.0f);
    self.scrollsToTop = NO;
    self.scrollEnabled = YES;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentNatural;
    self.contentMode = UIViewContentModeRedraw;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.text = nil;
    _placeHolder = nil;
    _displayPlaceHolder = YES;
    _placeHolderTextColor = [UIColor lightGrayColor];
    [self _addTextViewNotificationObservers];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self _configureTextView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self _configureTextView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self _configureTextView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _configureTextView];
}
-(void)dealloc{
    _displayPlaceHolder = NO;
    _placeHolder = nil;
    _placeHolderTextColor = nil;
    [self _removeTextViewNotifcaionObservers];
}

#pragma mark- Puplic Methods
-(BOOL)hasText{
    return ([[self.text stringByStrippingWhitespace] length] > 0);
}
-(void)setDisplayPlaceHolder:(BOOL)displayPlaceHolder{
    _displayPlaceHolder = displayPlaceHolder;
    [self setNeedsDisplay];
}

#pragma mark Setters
-(void)setPlaceHolder:(NSString *)placeHolder{
    if ([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor{
    if ([placeHolderTextColor isEqual:placeHolderTextColor]) {
        return;
    }
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark- Private Methods
-(void)setText:(NSString *)text{
    BOOL originalValue = self.scrollEnabled;
    [self setScrollEnabled:YES];
    [super setText:text];
    [self setScrollEnabled:originalValue];
    [self setNeedsDisplay];
}
-(void)setScrollEnabled:(BOOL)scrollEnabled{
    [super setScrollEnabled:scrollEnabled];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}
-(void)paste:(id)sender{
    if (self.pasteDelegate || [self.pasteDelegate grmsg_TextView:self shouldPasteWithSender:sender]) {
        [super paste:sender];
    }
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if ([self.text length] == 0 && self.placeHolder && self.placeHolderTextColor && self.displayPlaceHolder) {
        if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.alignment = self.textAlignment;
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            [self.placeHolder drawInRect:CGRectMake(5.0f, 8.0f + self.contentInset.top, self.frame.size.width-self.contentInset.left, self.frame.size.height - self.contentInset.top) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.placeHolderTextColor,NSParagraphStyleAttributeName:paragraphStyle}];
        }else{
            [self.placeHolderTextColor set];
            [self.placeHolder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height -16.0f) withAttributes:@{NSFontAttributeName:self.font}];
        }
    }
}

- (void)_addTextViewNotificationObservers{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_refreshTextViw) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_refreshTextViw) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_refreshTextViw) name:UITextViewTextDidEndEditingNotification object:self];
}
- (void)_removeTextViewNotifcaionObservers{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}
- (void)_refreshTextViw{
    [self setNeedsDisplay];
}
@end

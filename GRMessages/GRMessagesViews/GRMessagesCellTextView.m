//
//  GRMessagesCellTextView.m
//  GRMessages
//
//  Created by chengbin on 16/1/18.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesCellTextView.h"

@implementation GRMessagesCellTextView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.textColor = [UIColor whiteColor];
    self.editable = NO;
    self.selectable = YES;
    self.userInteractionEnabled = YES;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    self.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.contentOffset = CGPointZero;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding =0;
    self.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSUnderlineColorAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)};
    
}

-(void)setSelectedRange:(NSRange)selectedRange{
    [super setSelectedRange:selectedRange];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return NO;
        }
    }
    return YES;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
  
}


@end

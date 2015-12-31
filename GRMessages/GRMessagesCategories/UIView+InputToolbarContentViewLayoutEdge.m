//
//  UIView+InputToolbarContentViewLayoutEdge.m
//  GRMessages
//
//  Created by chengbin on 15/12/31.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import "UIView+InputToolbarContentViewLayoutEdge.h"

@implementation UIView (InputToolbarContentViewLayoutEdge)
-(void)_insertSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute constant:(CGFloat)constant{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:subview attribute:attribute multiplier:1.0f constant:constant]];
}
-(void)GRMessages_insertSubView:(UIView *)subview toEdage:(NSLayoutAttribute )attribute constant:(CGFloat)constant{
    [self _insertSubview:subview toEdge:attribute constant:constant];
}
-(void)GRMessages_insertSubView:(UIView *)subview constant:(CGFloat)constant{
     [self GRMessages_insertSubView:subview toEdage:NSLayoutAttributeTop constant:constant];
     [self GRMessages_insertSubView:subview toEdage:NSLayoutAttributeBottom constant:constant];
     [self GRMessages_insertSubView:subview toEdage:NSLayoutAttributeLeading constant:constant];
     [self GRMessages_insertSubView:subview toEdage:NSLayoutAttributeTrailing constant:constant];
}
-(void)GRMessages_insertSubView:(UIView *)subview{
    [self GRMessages_insertSubView:subview constant:0.0f];
}
@end

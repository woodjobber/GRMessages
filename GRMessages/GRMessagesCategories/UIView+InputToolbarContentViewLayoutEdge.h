//
//  UIView+InputToolbarContentViewLayoutEdge.h
//  GRMessages
//
//  Created by chengbin on 15/12/31.
//  Copyright © 2015年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InputToolbarContentViewLayoutEdge)
-(void)GRMessages_insertSubView:(UIView *)subview;//constant =0.0f;
-(void)GRMessages_insertSubView:(UIView *)subview constant:(CGFloat)constant;
-(void)GRMessages_insertSubView:(UIView *)subview toEdage:(NSLayoutAttribute )attribute constant:(CGFloat)constant;

@end

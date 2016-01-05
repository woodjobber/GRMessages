//
//  UIColor+GRMessages.h
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

struct CGRGBA {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
};
typedef struct CGRGBA CGRGBA;

@interface UIColor (GRMessages)

+ (UIColor *)grmsg_BubbleGreenColor;

+ (UIColor *)grmsg_BubbleLightGrayColor;

+ (UIColor *)grmsg_BubbleRedColor;

+ (UIColor *)grmsg_BubbleBlueColor;

- (UIColor *)grmsg_colorByAdjustingColorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

- (UIColor *)grmsg_colorByDarkeningColorWithValue:(CGFloat)value;

- (CGRGBA)grmsg_getRGBAOfColor;

@end

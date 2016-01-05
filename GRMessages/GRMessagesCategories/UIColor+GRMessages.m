//
//  UIColor+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "UIColor+GRMessages.h"
//Hue: 色相 , Saturation:饱和度, brightness:亮度
@implementation UIColor (GRMessages)
#pragma mark -- Public Methods

+ (UIColor *)grmsg_BubbleGreenColor{
    return [UIColor colorWithHue:130.0f / 360.0f saturation:0.68f brightness:0.84f alpha:1.0f];
}
+ (UIColor *)grmsg_BubbleLightGrayColor{
    return [UIColor colorWithHue:240.0f / 360.0f saturation:0.02f brightness:0.92f alpha:1.0f];
}
+ (UIColor *)grmsg_BubbleRedColor{
    return [UIColor colorWithHue:0.0f / 360.f saturation:0.79f brightness:1.0f alpha:1.0f];
}
+ (UIColor *)grmsg_BubbleBlueColor{
    return [UIColor colorWithHue:210.0f / 360.0f saturation:0.94f brightness:1.0f alpha:1.0f];
}

- (UIColor *)grmsg_colorByAdjustingColorWithHue:(CGFloat)hue
                                     saturation:(CGFloat)saturation
                                     brightness:(CGFloat)brightness
                                          alpha:(CGFloat)alpha{
    CGFloat h = .0f,s = .0f, b = .0f, a =.0f;

    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        BOOL ok = [self getHue:&h saturation:&s brightness:&b alpha:&a];
        if (ok) {
            h = fmodf(h + hue , 1.0f);
            s = [self _clamp:saturation + s];
            b = [self _clamp:brightness + b];
            a = [self _clamp:alpha + a];
            return [UIColor colorWithHue:h  saturation:s  brightness:b alpha:a];
        }
    }
   
    return self;
}
- (UIColor *)grmsg_colorByDarkeningColorWithValue:(CGFloat)value{
    
    const CGFloat *oldColorComponents = CGColorGetComponents(self.CGColor);
    CGFloat newColorComponents[4] = {};
    
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        newColorComponents[0] = [self _compare:(oldColorComponents[0]- value)];
        newColorComponents[1] = [self _compare:(oldColorComponents[0]- value)];
        newColorComponents[2] = [self _compare:(oldColorComponents[0]- value)];
        newColorComponents[3] = oldColorComponents[1];
        
    }else if (CGColorGetNumberOfComponents(self.CGColor) == 4){
        newColorComponents[0] = [self _compare:(oldColorComponents[0]- value)];
        newColorComponents[1] = [self _compare:(oldColorComponents[1]- value)];
        newColorComponents[2] = [self _compare:(oldColorComponents[2]- value)];
        newColorComponents[3] = oldColorComponents[3];
    }
    CGColorSpaceRef  colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef newColor = CGColorCreate(colorSpace, newColorComponents);
    CGColorSpaceRelease(colorSpace);
    UIColor * color = [UIColor colorWithCGColor:newColor];
    CGColorRelease(newColor);
    return color;
}
- (CGRGBA)grmsg_getRGBAOfColor{
    CGFloat r  = .0f, g = .0f, b = .0f, a =.0f;
    const CGFloat *colorComponents = CGColorGetComponents(self.CGColor);
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }else{
        if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
            r = colorComponents[0];
            g = colorComponents[0];
            b = colorComponents[0];
            a = colorComponents[1];
        }else if (CGColorGetNumberOfComponents(self.CGColor) == 4){
            r = colorComponents[0];
            g = colorComponents[1];
            b = colorComponents[2];
            a = colorComponents[3];
        }
    }
    
    CGRGBA rgba = {0};
    rgba.r = r;
    rgba.g = g;
    rgba.b = b;
    rgba.a = a;
    return rgba;
}

#pragma mark -- Private Methods
/**
 *  Ternary clamp (0.0f to 1.0f)
 *
 *  @param a {CGFloat} Input
 *
 *  @return {CGFloat}
 */
- (CGFloat)_clamp:(CGFloat)a{
    static const CGFloat min = 0.0f;
    static const CGFloat max = 1.0f;
    return (a > max) ? max : ((a < min)? min : a);
}

- (CGFloat)_compare:(CGFloat)a{
    return  a < 0.0f ? 0.0f : a;
}
@end

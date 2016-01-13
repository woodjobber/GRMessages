//
//  GRMessagesAvatarImageFactory.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesAvatarImageFactory.h"
#import "UIColor+GRMessages.h"

@implementation GRMessagesAvatarImageFactory
#pragma mark - Public Methods

+ (GRMessasgesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage  radius:(CGFloat)radius{
    UIImage *circlePlaceholderImage = [self _circularImage:placeholderImage withRadius:radius hightlightedColor:nil];
    return [GRMessasgesAvatarImage avatarImageWithPlaceholder:circlePlaceholderImage];
}

+ (GRMessasgesAvatarImage *)avatarImageWithImage:(UIImage *)image radius:(CGFloat)radius{
  
    UIImage *avatar = [GRMessagesAvatarImageFactory circularAvatarImage:image radius:radius];
    UIImage *highlightedAvatar = [GRMessagesAvatarImageFactory circularAvatarHighlightedImage:image radius:radius];
    return [[GRMessasgesAvatarImage alloc]initWithAvatarImage:avatar highlightedImage:highlightedAvatar placeholderImage:avatar];
}

+ (UIImage *)circularAvatarImage:(UIImage *)image radius:(CGFloat)radius{
    return [GRMessagesAvatarImageFactory _circularImage:image withRadius:radius hightlightedColor:nil];
}

+ (UIImage *)circularAvatarHighlightedImage:(UIImage *)image radius:(CGFloat)radius{
    return [GRMessagesAvatarImageFactory _circularImage:image withRadius:radius hightlightedColor:[UIColor colorWithWhite:0.1f alpha:0.03f]];
}

+ (GRMessasgesAvatarImage *)avatarImageWithUserLabel:(NSString *)label backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font radius:(CGFloat)radius{
    UIImage *avatarImage = [GRMessagesAvatarImageFactory _imageWithLabel:label backgroundColor:backgroundColor textColor:textColor font:font radius:radius];
    UIImage *avatarHightlightedImage = [GRMessagesAvatarImageFactory _circularImage:avatarImage withRadius:radius hightlightedColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
    return [[GRMessasgesAvatarImage alloc]initWithAvatarImage:avatarImage highlightedImage:avatarHightlightedImage placeholderImage:avatarImage];
}

#pragma mark - Private Methods


+ (UIImage *)_imageWithLabel:(NSString *)label backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font radius:(CGFloat )radius{

    NSParameterAssert(label != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(textColor != nil);
    NSParameterAssert(font != nil);
    NSParameterAssert(radius > 0.0f);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 2 * radius, 2 * radius);
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor};
    CGRect textFrame =[label boundingRectWithSize:frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    CGPoint frameMidPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint textFrameMidPoint = CGPointMake(CGRectGetMinX(textFrame), CGRectGetMidY(textFrame));
    
    CGFloat dx = frameMidPoint.x -textFrameMidPoint.x;
    CGFloat dy = frameMidPoint.y -textFrameMidPoint.y;
    CGPoint drawPoint = CGPointMake(dx, dy);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, frame);
        [label drawAtPoint:drawPoint withAttributes:attributes];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    
    return [self _circularImage:newImage withRadius:radius hightlightedColor:nil];
}
+ (UIImage *)_circularImage:(UIImage *)image withRadius:(CGFloat)radius hightlightedColor:(UIColor *)hightlightedColor{
    NSParameterAssert(image!=nil);
    NSParameterAssert(radius > 0);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, radius * 2, radius *2);
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIBezierPath *imagePath = [UIBezierPath bezierPathWithRect:frame];
        [imagePath addClip];
        [image drawInRect:frame];
        if (hightlightedColor != nil) {
            CGContextSetFillColorWithColor(context, hightlightedColor.CGColor);
            CGContextFillEllipseInRect(context, frame);
        }
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    }
    UIGraphicsEndImageContext();
    return newImage;
}
@end

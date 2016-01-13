//
//  GRMessagesAvatarImageFactory.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GRMessasgesAvatarImage.h"

@interface GRMessagesAvatarImageFactory : NSObject

+ (GRMessasgesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage  radius:(CGFloat)radius;

+ (GRMessasgesAvatarImage *)avatarImageWithImage:(UIImage *)image radius:(CGFloat)radius;

+ (UIImage *)circularAvatarImage:(UIImage *)image radius:(CGFloat)radius;

+ (UIImage *)circularAvatarHighlightedImage:(UIImage *)image radius:(CGFloat)radius;

+ (GRMessasgesAvatarImage *)avatarImageWithUserLabel:(NSString *)label backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font radius:(CGFloat)radius;

@end

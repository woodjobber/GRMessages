//
//  GRMessasgesAvatarImage.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessasgesAvatarImage.h"

@implementation GRMessasgesAvatarImage
+ (instancetype)avatarWithImage:(UIImage *)image
{
    NSParameterAssert(image != nil);
    return [[self alloc] initWithAvatarImage:image highlightedImage:image placeholderImage:image];
}

+ (instancetype)avatarImageWithPlaceholder:(UIImage *)placeholderImage{
    return [[self alloc]initWithAvatarImage:nil highlightedImage:nil placeholderImage:placeholderImage];
}

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage highlightedImage:(UIImage *)hightlightedImage placeholderImage:(UIImage *)placeholderImage{
    NSParameterAssert(placeholderImage != nil);
    if (self =[super init]) {
        _avatarImage = avatarImage;
        _avatarHighlightedImage =hightlightedImage;
        _avatarPlaceholderImage = placeholderImage;
    }
    
    return self;
}
-(instancetype)init{
    NSAssert(NO, @"%s is not avlid initializer for %@.Use instead.",__PRETTY_FUNCTION__, [self class],NSStringFromSelector(@selector(initWithAvatarImage:highlightedImage:placeholderImage:)));
    return nil;
}



-(id)copyWithZone:(NSZone *)zone{
    
    return [[[self class]allocWithZone:zone] initWithAvatarImage:[UIImage imageWithCGImage:self.avatarImage.CGImage] highlightedImage:[UIImage imageWithCGImage:self.avatarHighlightedImage.CGImage] placeholderImage:[UIImage imageWithCGImage:self.avatarPlaceholderImage.CGImage]];
}
@end

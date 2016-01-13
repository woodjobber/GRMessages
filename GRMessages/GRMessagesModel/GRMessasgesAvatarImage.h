//
//  GRMessasgesAvatarImage.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesImage.h"
#import "GRMessagesAvatarImageDataSource.h"

@interface GRMessasgesAvatarImage : GRMessagesImage<GRMessagesAvatarImageDataSource,NSCopying>

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, strong) UIImage *avatarHighlightedImage;

@property (nonatomic, strong,readonly) UIImage *avatarPlaceholderImage;


+ (instancetype)avatarWithImage:(UIImage *)image;

+ (instancetype)avatarImageWithPlaceholder:(UIImage *)placeholderImage;

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage highlightedImage:(UIImage *)hightlightedImage placeholderImage:(UIImage *)placeholderImage;


@end

//
//  GRMessagesBubbleImage.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesImage.h"
#import "GRMessagesBubbleImageDataSource.h"

@interface GRMessagesBubbleImage : GRMessagesImage<NSCopying,GRMessagesBubbleImageDataSource>

@property (nonatomic, strong, readonly) UIImage *messageBubbleImage;

@property (nonatomic, strong, readonly) UIImage *messageBubbleHightlightedImage;

- (instancetype)initWithMessageBubbleImage:(UIImage *)image highligtedImage:(UIImage *)hightlightedImage;


@end

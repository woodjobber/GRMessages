//
//  GRMessagesBubbleImage.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesBubbleImage.h"

@implementation GRMessagesBubbleImage

- (instancetype)initWithMessageBubbleImage:(UIImage *)image highligtedImage:(UIImage *)hightlightedImage{

    NSParameterAssert( image != nil);
    NSParameterAssert( hightlightedImage !=nil);
    if (self = [super init]) {
        _messageBubbleHightlightedImage = hightlightedImage;
        _messageBubbleImage = image;
    }
    return self;
}

-(instancetype)init{
    NSAssert(NO, @"%s is not avlid initializer for %@.Use instead.",__PRETTY_FUNCTION__, [self class],NSStringFromSelector(@selector(initWithMessageBubbleImage:highligtedImage:)));
    return nil;
}

-(id)copyWithZone:(NSZone *)zone{
    return [[[self class]allocWithZone:zone] initWithMessageBubbleImage:[UIImage imageWithCGImage:self.messageBubbleImage.CGImage] highligtedImage:[UIImage imageWithCGImage:self.messageBubbleHightlightedImage.CGImage]];

}

@end

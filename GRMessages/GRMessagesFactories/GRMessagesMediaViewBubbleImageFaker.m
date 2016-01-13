//
//  GRMessagesMediaViewBubbleImageFaker.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaViewBubbleImageFaker.h"
#import "GRMessagesBubbleImageFactory.h"

@implementation GRMessagesMediaViewBubbleImageFaker

- (instancetype)initWithBubbleImageFactory:(GRMessagesBubbleImageFactory *)bubbleImageFactory{
    NSParameterAssert(bubbleImageFactory != nil);
    if (self =[super init]) {
        _bubbleImageFactory = bubbleImageFactory;
    }
    return self;
}

#pragma mark -Public Methods

- (void)configureBubbleImageFakeToMediaView:(UIView *)mediaView ActionType:(GRMessagesMediaItemActionType)actionType{
    GRMessagesBubbleImage *bubbleImageData = [self.bubbleImageFactory messagesBubbleImageActionType:actionType withColor:[UIColor whiteColor]];
    [self _fakeView:mediaView image:[bubbleImageData messageBubbleImage]];
}
+ (void)configureBubbleImageFakeToMediaView:(UIView *)mediaView ActionType:(GRMessagesMediaItemActionType)actionType{
    [self configureBubbleImageFakeToMediaView:mediaView ActionType:actionType];
}


#pragma mark -Private Methods

- (void)_fakeView:(UIView *)view image:(UIImage *)image{
    
    UIImageView *imageViewFake = [[UIImageView alloc]initWithImage:image];
    imageViewFake.frame = CGRectInset(view.frame, 2.0f, 2.0f);
    view.layer.mask = imageViewFake.layer;
    
}
@end

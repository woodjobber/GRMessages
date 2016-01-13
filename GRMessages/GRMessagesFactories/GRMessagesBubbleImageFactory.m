//
//  GRMessagesBubbleImageFactory.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesBubbleImageFactory.h"
#import "UIColor+GRMessages.h"
#import "UIImage+GRMessages.h"


@interface GRMessagesBubbleImageFactory ()

@property (nonatomic,strong,readonly)UIImage *bubbleImage;
@property (nonatomic,assign,readonly)UIEdgeInsets capInsets;

@end

@implementation GRMessagesBubbleImageFactory

-(instancetype)initWithBubbleImage:(UIImage *)bubbleImage capInsets:(UIEdgeInsets)capInsets{
    NSParameterAssert(bubbleImage != nil);
    if (self =[super init]) {
        _bubbleImage = bubbleImage;
        if (UIEdgeInsetsEqualToEdgeInsets(capInsets, UIEdgeInsetsZero)) {
            _capInsets = [self _centerPointEdageInsetsForImageSize:bubbleImage.size];
        }else{
            _capInsets = capInsets;
        }
    }
    return self;
}
-(instancetype)init{
    return [self initWithBubbleImage:[UIImage grmsg_bubbleCompactImage] capInsets:UIEdgeInsetsZero];
}

-(void)dealloc{
    _bubbleImage = nil;
}

#pragma mark- Public Methods

- (GRMessagesBubbleImage *)messagesBubbleImageActionType:(GRMessagesMediaItemActionType)actionType withColor:(UIColor *)color{
    return [self _messagesBubbleImageWithColor:color flippedForActionType:actionType];
}

#pragma mark- Private Methods

- (UIEdgeInsets)_centerPointEdageInsetsForImageSize:(CGSize)bubbleImageSize{
    CGPoint center = CGPointMake(bubbleImageSize.width/2.0f, bubbleImageSize.height/2.0f);
    return UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
}
- (GRMessagesBubbleImage *)_messagesBubbleImageWithColor:(UIColor *)color flippedForActionType:(GRMessagesMediaItemActionType)actionType{
    NSParameterAssert(color != nil);
    UIImage *normalBubble =[self.bubbleImage grmsg_imageMaskdWithColor:color];
    UIImage *highligthedBubble =[self.bubbleImage grmsg_imageMaskdWithColor:[color grmsg_colorByDarkeningColorWithValue:0.12f]];
    if (actionType == GRMessagesMediaItemActionTypeIncoming) {
        normalBubble = [self _horizontallyFlippedImageForImage:normalBubble];
        highligthedBubble = [self _horizontallyFlippedImageForImage:highligthedBubble];
    }
    normalBubble = [self _stretchableImageForImage:normalBubble withCapInsets:self.capInsets];
    highligthedBubble =[self _horizontallyFlippedImageForImage:highligthedBubble];
    
    return [[GRMessagesBubbleImage alloc] initWithMessageBubbleImage:normalBubble highligtedImage:highligthedBubble];
    
}

- (UIImage *)_horizontallyFlippedImageForImage:(UIImage *)image{
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
}
- (UIImage *)_stretchableImageForImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets{
    
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end

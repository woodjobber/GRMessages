//
//  UIImage+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "UIImage+GRMessages.h"
#import "NSBundle+GRMessages.h"

@implementation UIImage (GRMessages)
- (UIImage *)grmsg_imageMaskdWithColor:(UIColor *)maskColor{
    NSParameterAssert(maskColor != nil);
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)grmsg_readImageWithImageName:(NSString *)imageName{
    return [NSBundle grmsg_bundleImageWithImageName:imageName];
}
+ (UIImage *)grmsg_bubbleRegularImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_regular"];
}
+ (UIImage *)grmsg_bubbleRegularTaillessImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_tailless"];
}
+ (UIImage *)grmsg_bubbleRegularStrokedImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_stroked"];
}
+ (UIImage *)grmsg_bubbleRegularStrokedTaillessImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_stroked_tailless"];
}
+ (UIImage *)grmsg_bubbleCompactImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_min"];
}
+ (UIImage *)grmsg_bubbleCompactTaillessImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"bubble_min_tailless"];
}
+ (UIImage *)grmsg_defaultAccessoryImage{
    return [NSBundle grmsg_bundleImageWithImageName:@""];
}
+ (UIImage *)grmsg_defaultTypingIndicatorImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"typing"];
}
+ (UIImage *)grmsg_defaultPlayImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"play"];
}
+ (UIImage *)grmsg_defaultRegularBucketBodyImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"BucketBodyTemplate"];
}
+ (UIImage *)grmsg_defaultRegularBucketLidImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"BucketLidTemplate"];
}
+ (UIImage *)grmsg_defaultRegularMicRecRedImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"MicRecRed"];
}
+ (UIImage *)grmsg_defaultRegularMicRecImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"MicRecRegular"];
}
+ (UIImage *)grmsg_defaultRegularEmotionDownImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"chat_emotion_down"];
}
+ (UIImage *)grmsg_defaultRegularEmotionUpImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"chat_emotion_up"];
}
+ (UIImage *)grmsg_defaultRegularShareUpImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"chat_share_up"];
}
+ (UIImage *)grmsg_defaultRegularShareDownImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"chat_share_down"];
}
+ (UIImage *)grmsg_defaultRegularSlideArrowImage{
    return [NSBundle grmsg_bundleImageWithImageName:@"SlideArrow"];
}
@end

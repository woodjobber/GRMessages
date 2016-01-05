//
//  UIImage+GRMessages.h
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GRMessages)

- (UIImage *)grmsg_imageMaskdWithColor:(UIColor *)maskColor;

+ (UIImage *)grmsg_readImageWithImageName:(NSString *)imageName;

+ (UIImage *)grmsg_bubbleRegularImage;

+ (UIImage *)grmsg_bubbleRegularTaillessImage;

+ (UIImage *)grmsg_bubbleRegularStrokedImage;

+ (UIImage *)grmsg_bubbleRegularStrokedTaillessImage;

+ (UIImage *)grmsg_bubbleCompactImage;

+ (UIImage *)grmsg_bubbleCompactTaillessImage;

+ (UIImage *)grmsg_defaultAccessoryImage;

+ (UIImage *)grmsg_defaultTypingIndicatorImage;

+ (UIImage *)grmsg_defaultPlayImage;

+ (UIImage *)grmsg_defaultRegularBucketBodyImage;

+ (UIImage *)grmsg_defaultRegularBucketLidImage;

+ (UIImage *)grmsg_defaultRegularMicRecRedImage;

+ (UIImage *)grmsg_defaultRegularMicRecImage;

+ (UIImage *)grmsg_defaultRegularEmotionDownImage;

+ (UIImage *)grmsg_defaultRegularEmotionUpImage;

+ (UIImage *)grmsg_defaultRegularShareUpImage;

+ (UIImage *)grmsg_defaultRegularShareDownImage;

+ (UIImage *)grmsg_defaultRegularSlideArrowImage;

@end

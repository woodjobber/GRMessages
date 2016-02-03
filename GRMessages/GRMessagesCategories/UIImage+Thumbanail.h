//
//  UIImage+Thumbanail.h
//  GRUC
//
//  Created by chengbin on 16/1/28.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Thumbanail)
+ (UIImage *)imageFromView:(UIView *)view;
+ (UIImage *)imageFromView:(UIView *)view scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end

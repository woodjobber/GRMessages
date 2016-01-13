//
//  GRMessagesMediaPlaceholderView.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRMessagesMediaPlaceholderView : UIView

@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, weak, readonly) UIImageView *imageView;

+ (instancetype)viewWithActivityIndicator;

+ (instancetype)viewWithAttachmentIcon;

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor imageView:(UIImageView *)imageView;
@end

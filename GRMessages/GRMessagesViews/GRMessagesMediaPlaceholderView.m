//
//  GRMessagesMediaPlaceholderView.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaPlaceholderView.h"
#import "UIColor+GRMessages.h"
#import "UIImage+GRMessages.h"

@implementation GRMessagesMediaPlaceholderView
- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backgroundColor;
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor imageView:(UIImageView *)imageView{
    if (self = [self initWithFrame:frame backgroundColor:backgroundColor]) {
        [self addSubview:imageView];
        _imageView = imageView;
        _imageView.center = self.center;
        _activityIndicatorView = nil;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView{

    if (self = [self initWithFrame:frame backgroundColor:backgroundColor]) {
        [self addSubview:activityIndicatorView];
        _activityIndicatorView = activityIndicatorView;
        _activityIndicatorView.center = self.center;
        _imageView = nil;
    }
    return self;
}
+(instancetype)viewWithActivityIndicator{
    UIColor *lightGrayColor = [UIColor grmsg_BubbleLightGrayColor];
    UIActivityIndicatorView *pinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    pinner.color = [lightGrayColor grmsg_colorByDarkeningColorWithValue:0.4f];
    GRMessagesMediaPlaceholderView *view = [[GRMessagesMediaPlaceholderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 120.0f) backgroundColor:lightGrayColor activityIndicatorView:pinner];
    return view;
}

+(instancetype)viewWithAttachmentIcon{
    UIColor *lightGrayColor = [UIColor grmsg_BubbleLightGrayColor];
    UIImage *paperclip = [[UIImage grmsg_defaultAccessoryImage] grmsg_imageMaskdWithColor:[lightGrayColor grmsg_colorByDarkeningColorWithValue:0.4f]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:paperclip];
    GRMessagesMediaPlaceholderView *view = [[GRMessagesMediaPlaceholderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 120.0f) backgroundColor:lightGrayColor imageView:imageView];
    
    return view;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.activityIndicatorView) {
        self.activityIndicatorView.center = self.center;
    }else if (self.imageView){
        self.imageView.center = self.center;
    }
}



@end

//
//  GRMessagesSlideView.m
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesSlideView.h"


@interface GRMessagesSlideView()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation GRMessagesSlideView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)_buildView{
    self.clipsToBounds = YES;
    
    _textLabel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        _text =label.text = @"Slide To Cancel";
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        
        label;
    });
    
    _arrowImageView = ({
        _arrowImage = [UIImage grmsg_defaultRegularSlideArrowImage];
        UIImageView *bkImageView = [[UIImageView alloc]initWithImage:_arrowImage];
        CGRect frame = bkImageView.frame;
        frame.origin.x = self.frame.size.width /2.0f +60.0f;
        frame.origin.y = self.frame.size.height /2.0f - frame.size.height/2;
        [bkImageView setFrame:frame];
        
        bkImageView;
    });
}
-(void)updateLocation:(CGFloat )offsetX{
    
    CGRect labelFrame = self.textLabel.frame;
    labelFrame.origin.x += offsetX;
    self.textLabel.frame = labelFrame;
    CGRect imageFrame = self.arrowImageView.frame;
    imageFrame.origin.x += offsetX;
    self.arrowImageView.frame = imageFrame;
}
- (void)setArrowImage:(UIImage *)arrowImage{
    self.arrowImageView.image = arrowImage;
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text{
    self.textLabel.text = text;
    [self setNeedsDisplay];
}

@end

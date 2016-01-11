//
//  GRMessagesSlideView.m
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesSlideView.h"
#import "UIImage+GRMessages.h"
static void setViewFixedAnchorPoint(CGPoint anchorPoint, UIView *view)
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height *anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    CGPoint postion = view.layer.position;
    postion.x -= oldPoint.x;
    postion.y += newPoint.x;
    
    postion.y -= oldPoint.x;
    postion.y += newPoint.y;
    view.layer.position = postion;
    view.layer.anchorPoint = anchorPoint;
}
@interface GRMessagesSlideView()

@property (nonatomic, strong) UIImageView *bodyView;
@property (nonatomic, strong) UIImageView *headerView;

@end

@implementation GRMessagesSlideView
-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 18.0f, 26.0f)];
    if (self) {
        _bodyImage = [UIImage grmsg_defaultRegularBucketBodyImage];
        _headerImage = [UIImage grmsg_defaultRegularBucketLidImage];
        _bodyView = [[UIImageView alloc]initWithImage:_bodyImage];
        _headerView = [[UIImageView alloc]initWithImage:_headerImage];
        CGRect frame = _bodyView.frame;
        frame.origin.y = 1.0f;
        [_bodyView setFrame:frame];
        setViewFixedAnchorPoint(CGPointMake(0.0f, 1.0f), _headerView);
    }
    return self;
}
-(void)setHeaderImage:(UIImage *)headerImage{
    _headerView.image = headerImage;
    [self setNeedsDisplay];
}

-(void)setBodyImage:(UIImage *)bodyImage{
    _bodyView.image = bodyImage;
    [self setNeedsDisplay];
}
@end

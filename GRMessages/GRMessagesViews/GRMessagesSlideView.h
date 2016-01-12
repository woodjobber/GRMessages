//
//  GRMessagesSlideView.h
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+GRMessages.h"
@interface GRMessagesSlideView : UIView
@property (nonatomic, strong)UIImage *bodyImage;
@property (nonatomic, strong)UIImage *headerImage;
@property (nonatomic, strong)UIImage *arrowImage;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)UIButton *recordBtn;
-(void)updateLocation:(CGFloat )offsetX;
@end

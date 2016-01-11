//
//  GRMessagesGarbageView.h
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRMessagesGarbageView : UIView
@property (nonatomic, strong)UIImage *arrowImage;
@property (nonatomic, strong)NSString *text;
-(void)updateLocation:(CGFloat )offsetX;
@end

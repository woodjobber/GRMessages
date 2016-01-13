//
//  GRMessagesBubbleImageFactory.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GRMessagesBubbleImage.h"
#import "GRMessagesOptions.h"


@interface GRMessagesBubbleImageFactory : NSObject

-(instancetype)init;

-(instancetype)initWithBubbleImage:(UIImage *)bubbleImage capInsets:(UIEdgeInsets)capInsets;

- (GRMessagesBubbleImage *)messagesBubbleImageActionType:(GRMessagesMediaItemActionType)actionType withColor:(UIColor *)color;


@end

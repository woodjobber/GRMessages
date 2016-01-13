//
//  GRMessagesMediaViewBubbleImageFaker.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRMessagesOptions.h"
#import <UIKit/UIKit.h>

@class GRMessagesBubbleImageFactory;

@interface GRMessagesMediaViewBubbleImageFaker : NSObject

@property (nonatomic ,strong ,readonly) GRMessagesBubbleImageFactory *bubbleImageFactory;

- (void)configureBubbleImageFakeToMediaView:(UIView *)mediaView ActionType:(GRMessagesMediaItemActionType)actionType;

+ (void)configureBubbleImageFakeToMediaView:(UIView *)mediaView ActionType:(GRMessagesMediaItemActionType)actionType;


@end

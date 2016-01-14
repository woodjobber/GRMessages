//
//  GRMessagesMediaItem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GRMessagesMediaData.h"
#import "GRMessagesOptions.h"
#import "UIImage+GRMessages.h"
#import "GRMessagesMediaViewBubbleImageFaker.h"
#import "GRMessagesMediaPlaceholderView.h"

@interface GRMessagesMediaItem : NSObject<GRMessagesMediaData,NSCopying,NSCoding>

@property (nonatomic, assign) GRMessagesMediaItemActionType appliesMediaViewFakeActionType;

@property (nonatomic, assign) GRMessagesMediaItemType appliesMediaItemType;

- (instancetype)initWithFakeActionType:(GRMessagesMediaItemActionType)fakeActionType;

- (void)clearCacheMediaViews;

@end

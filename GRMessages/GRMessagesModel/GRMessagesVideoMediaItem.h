//
//  GRMessagesVideoMediaItem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"

@interface GRMessagesVideoMediaItem : GRMessagesMediaItem

@property (nonatomic ,strong) NSObject *videoObject;

@property (nonatomic ,assign) BOOL isReadyToPlay;

- (instancetype)initWithVideoObject:(NSObject *)videoObject isReadyToPlay:(BOOL)isReadyToPlay;

@end

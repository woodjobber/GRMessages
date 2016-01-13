//
//  GRMessagesVideoMediaItem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"

@interface GRMessagesVideoMediaItem : GRMessagesMediaItem

@property (nonatomic ,strong) NSURL *fileURL;

@property (nonatomic ,assign) BOOL isReadyToPlay;

- (instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay;

@end

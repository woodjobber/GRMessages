//
//  GRMessagesAudioMedialtem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"

@interface GRMessagesAudioMedialtem : GRMessagesMediaItem

@property (nonatomic, strong)NSObject* audioObject;

@property (nonatomic, assign)BOOL isReadyToPlay;

- (instancetype)initWithAudioObject:(NSObject *)audioObject isReadyToPlay:(BOOL)isReadyToPlay;


@end

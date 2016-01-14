//
//  GRMessagesFileMedialtem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"

typedef NS_OPTIONS(NSUInteger, GRMessagesFileMediaItemOptionsType){
    GRMessagesFileMediaItemOptionsTypeDownload,
    GRMessagesFileMediaItemOptionsTypeOnlinePreview
};
@interface GRMessagesFileMediaItem : GRMessagesMediaItem

@property (nonatomic, strong) NSObject *fileObject;

@property (nonatomic, assign) GRMessagesFileMediaItemOptionsType optionsType;

- (instancetype)initWithFileObject:(NSObject *)fileObject fileOptionsType:(GRMessagesFileMediaItemOptionsType)fileOptionsType;


@end

//
//  GRMessagesOptions.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#ifndef GRMessagesOptions_h
#define GRMessagesOptions_h
typedef  NS_OPTIONS (NSUInteger,GRMessagesMediaItemActionType){
    GRMessagesMediaItemActionTypeOutgoing,
    GRMessagesMediaItemActionTypeIncoming
};
typedef NS_OPTIONS(NSUInteger, GRMessagesMediaItemType){
    GRMessagesMediaItemTypeFile = 0,
    GRMessagesMediaItemTypeLocation,
    GRMessagesMediaItemTypePhoto,
    GRMessagesMediaItemTypeAudio,
    GRMessagesMediaItemTypeVideo
};

#endif /* GRMessagesOptions_h */

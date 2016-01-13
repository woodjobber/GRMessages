//
//  GRMessagesData.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GRMessagesMediaData.h"

@protocol GRMessagesData <NSObject>

- (NSString *)senderId;

- (NSString *)senderDisplayName;

- (NSDate *)date;

- (BOOL) isMediaMessage;

- (NSUInteger)messageHash;

@optional
- (NSString *)timestamp;

- (NSString *)text;

- (id <GRMessagesMediaData>)media;

@end
//
//  GRMessage.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GRMessagesData.h"

@interface GRMessage : NSObject <GRMessagesData,NSCoding,NSCopying>

@property (copy, nonatomic, readonly) NSString *senderId;

@property (copy, nonatomic, readonly) NSString *senderDisplayName;

@property (copy, nonatomic, readonly) NSDate *date;

@property (copy, nonatomic, readonly) NSString *text;

@property (assign,nonatomic, readonly) BOOL isMediaMessage;

@property (copy, nonatomic, readonly) id<GRMessagesMediaData>media;

@property (copy, nonatomic, readonly) NSString *timestamp;


+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date text:(NSString *)text;
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date text:(NSString *)text;


+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp text:(NSString *)text;
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp text:(NSString *)text;


+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp media:(id<GRMessagesMediaData>)media;
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp media:(id<GRMessagesMediaData>)media;


+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName media:(id<GRMessagesMediaData>)media;
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date media:(id<GRMessagesMediaData>)media;


@end

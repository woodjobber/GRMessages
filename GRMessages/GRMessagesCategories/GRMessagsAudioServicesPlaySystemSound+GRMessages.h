//
//  GRMessagsAudioServicesPlaySystemSound+GRMessages.h
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagsAudioServicesPlaySystemSound.h"

@interface GRMessagsAudioServicesPlaySystemSound (GRMessages)

+ (void)grmsg_playMessageReceivedSoundFromUISounds;

+ (void)grmsg_playMessageReceivedAlertSoundFromUISounds;

+ (void)grmsg_playMessageSentSoundFromUISounds;

+ (void)grmsg_playMessageSentAlertSoundFromUISounds;

+ (void)grmsg_palyMessageReceivedSoundFromBundle;

+ (void)grmsg_playMessageReceivedAlertSoundFromBundle;

+ (void)grmsg_playMessageSentSoundFromBundle;

+ (void)grmsg_playMessageSentAlertSoundFromBundle;

@end

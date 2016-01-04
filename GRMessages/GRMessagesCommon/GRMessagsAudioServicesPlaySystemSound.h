//
//  GRMessagsAudioServicesPlaySystemSound.h
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
//It only supports audio data formats linear PCM or IMA4
//It only supports audio file formats caf, aif, or waf,aiff
//The sounds must be 30 seconds or less in length
//The sound plays at once
//Only one sound can play at a time

FOUNDATION_EXPORT NSString * const kGRMessagesAudioServicePlaySystemSoundTypeCAF;
FOUNDATION_EXPORT NSString * const kGRMessagesAudioServicePlaySystemSoundTypeWAV;
FOUNDATION_EXPORT NSString * const kGRMessagesAudioServicePlaySystemSoundTypeAIF; // aif == aiff
FOUNDATION_EXPORT NSString * const kGRMessagesAudioServicePlaySystemSoundTypeAIFF;

typedef void(^GRMessagesAudioServicePlaySystemSoundCompletionBlock)(void);

@interface GRMessagsAudioServicesPlaySystemSound : NSObject

@property (nonatomic,assign,readonly) BOOL isEnable;

@property (nonatomic,strong,readwrite) NSBundle *bundle;

AS_SINGLETON(GRMessagsAudioServicesPlaySystemSound);

- (void)grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType;

- (void)grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType completion:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completion;

- (void)grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType;

- (void)grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType completion:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completion;

- (void)grmsg_AudioServicesPlaySystemSoundToTogglePlaySoundEnable:(BOOL)isEnable;

- (void)grmsg_AudioServicesPlaySystemSoundToStopAllSounds;

- (void)grmsg_AudioServicesPlaySystemSoundToPlayVibrateSound;

- (void)grmsg_AudioServicesPlaySystemSoundToStopSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType;

- (void)grmsg_AudioServicesPlaySystemSoundToPreloadSoundWithFullPathFileNmae:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType;

@end

//
//  GRMessagsAudioServicesPlaySystemSound+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//  NSFileManager *fileManager = [[NSFileManager alloc] init];
//  NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
//
//  NSDirectoryEnumerator *enumerator = [fileManager
//                                     enumeratorAtURL:directoryURL
//                                     includingPropertiesForKeys:keys
//                                     options:0
//                                     errorHandler:^(NSURL *url, NSError *error) {
//
//                                         return YES;
//                                     }];
//
//   for (NSURL *url in enumerator) {
//    NSError *error;
//    NSNumber *isDirectory = nil;
//    if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
//        // handle error
//    }
//    else if (! [isDirectory boolValue]) {
//
//    }
//}

#import "GRMessagsAudioServicesPlaySystemSound+GRMessages.h"
#import "NSBundle+GRMessages.h"

static NSString *const kGRMessagesBundlePath         = @"/System/Library/Audio/UISounds";
static NSString *const kGRMessagesBundleAssetsPath   = @"GRMessagesAssets.bundle/Sound/";

static NSString *const kGRMessagesReceivedSoundName  = @"ReceivedMessage";
static NSString *const kGRMessagesSentSoundName      = @"SentMessage";

static NSString *const kGRMessages_ReceivedSoundName = @"Received_Message";
static NSString *const kGRMessages_SentSoundName     = @"Sent_Message";

typedef NS_OPTIONS(NSUInteger, GRMessagesPlaySoundType) {
    GRMessagesPlaySoundTypeReceivedAlert = 1,
    GRMessagesPlaySoundTypeSentAlert     = 2,
    GRMessagesPlaySoundTypeReceived      = 3,
    GRMessagesPlaySoundTypeSent          = 4
};

@implementation GRMessagsAudioServicesPlaySystemSound (GRMessages)
#pragma mark -
#pragma  mark -- Public Methods

#pragma mark -
#pragma mark Sound From UISounds

+ (void)grmsg_playMessageReceivedSoundFromUISounds{
    [self grmsg_playSoundWithSoundName:kGRMessagesReceivedSoundName Type:GRMessagesPlaySoundTypeReceived];
}

+ (void)grmsg_playMessageReceivedAlertSoundFromUISounds{
    [self grmsg_playSoundWithSoundName:kGRMessagesReceivedSoundName Type:GRMessagesPlaySoundTypeReceivedAlert];
}

+ (void)grmsg_playMessageSentSoundFromUISounds{
    [self grmsg_playSoundWithSoundName:kGRMessagesSentSoundName Type:GRMessagesPlaySoundTypeSent];
}
+ (void)grmsg_playMessageSentAlertSoundFromUISounds{
    [self grmsg_playSoundWithSoundName:kGRMessagesSentSoundName Type:GRMessagesPlaySoundTypeSentAlert];
}

#pragma mark -
#pragma mark Sound From Bundle

+ (void)grmsg_palyMessageReceivedSoundFromBundle{
    [self grmsg_playSoundWithSoundName:kGRMessages_ReceivedSoundName Type:GRMessagesPlaySoundTypeReceived];
}
+ (void)grmsg_playMessageReceivedAlertSoundFromBundle{
    [self grmsg_playSoundWithSoundName:kGRMessages_ReceivedSoundName Type:GRMessagesPlaySoundTypeReceivedAlert];
}
+ (void)grmsg_playMessageSentSoundFromBundle{
    [self grmsg_playSoundWithSoundName:kGRMessages_SentSoundName Type:GRMessagesPlaySoundTypeSent];
}
+ (void)grmsg_playMessageSentAlertSoundFromBundle{
    [self grmsg_playSoundWithSoundName:kGRMessages_SentSoundName Type:GRMessagesPlaySoundTypeSentAlert];
}

#pragma mark -
#pragma mark -- Private Methods

+ (void)grmsg_playSoundWithSoundName:(NSString *)soundName Type:(GRMessagesPlaySoundType)type{
    NSString * budleIdentifier = [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle.bundleIdentifier;
    NSString * fileName = [NSString stringWithFormat:@"%@%@",kGRMessagesBundleAssetsPath,soundName];
    NSString * filePath = nil;
    NSString * fileExtensionType = nil;
    if ([soundName isEqualToString:kGRMessages_ReceivedSoundName]) {
        [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle  = [NSBundle grmsg_bundle];
        filePath = fileName;
        fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeAIFF;
    }else if ([soundName isEqualToString:kGRMessages_SentSoundName]){
         [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle = [NSBundle grmsg_bundle];
         filePath = fileName;
         fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeAIFF;
        
    }else if ([soundName isEqualToString:kGRMessagesReceivedSoundName]){
         [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle = [NSBundle grmsg_bundleFromSystem];
         fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeCAF;
         filePath = soundName;
    }else if ([soundName isEqualToString:kGRMessagesSentSoundName]){
          NSBundle *bundle = [NSBundle grmsg_bundleFromSystem];
         [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle = bundle;
         filePath = soundName;
         fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeCAF;
    }
   
    switch (type) {
        case GRMessagesPlaySoundTypeReceivedAlert: {
            [[GRMessagsAudioServicesPlaySystemSound sharedInstance]grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:filePath fileExtensionType:fileExtensionType];
            break;
        }
        case GRMessagesPlaySoundTypeSentAlert: {
            [[GRMessagsAudioServicesPlaySystemSound sharedInstance]grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:filePath fileExtensionType:fileExtensionType];
            break;
        }
        case GRMessagesPlaySoundTypeReceived: {
            [[GRMessagsAudioServicesPlaySystemSound sharedInstance]grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:filePath fileExtensionType:fileExtensionType];
            break;
        }
        case GRMessagesPlaySoundTypeSent: {
              [[GRMessagsAudioServicesPlaySystemSound sharedInstance]grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:filePath fileExtensionType:fileExtensionType];
            break;
        }
        default: {
            break;
        }
    }
    
    [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle = [NSBundle bundleWithIdentifier:budleIdentifier];
   
}
@end

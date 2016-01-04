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

static NSString *const kGRMessagesBundlePath        = @"/System/Library/Audio/UISounds";

static NSString *const kGRMessagesReceivedSoundName = @"ReceivedMessage";
static NSString *const kGRMessagesSentSoundName     = @"SentMessage";

typedef NS_OPTIONS(NSUInteger, GRMessagesPlaySoundType) {
    GRMessagesPlaySoundTypeReceivedAlert = 1,
    GRMessagesPlaySoundTypeSentAlert = 2,
    GRMessagesPlaySoundTypeReceived = 3,
    GRMessagesPlaySoundTypeSent = 4
};

@implementation GRMessagsAudioServicesPlaySystemSound (GRMessages)

#pragma  mark -- Public Methods
+ (void)grmsg_playMessageReceivedSound{
    [self grmsg_playSoundWithSoundName:kGRMessagesReceivedSoundName Type:GRMessagesPlaySoundTypeReceived];
}

+ (void)grmsg_playMessageReceivedAlertSound{
    [self grmsg_playSoundWithSoundName:kGRMessagesReceivedSoundName Type:GRMessagesPlaySoundTypeReceivedAlert];
}

+ (void)grmsg_playMessageSentSound{
    [self grmsg_playSoundWithSoundName:kGRMessagesSentSoundName Type:GRMessagesPlaySoundTypeSent];
}
+ (void)grmsg_playMessageSentAlertSound{
    [self grmsg_playSoundWithSoundName:kGRMessagesSentSoundName Type:GRMessagesPlaySoundTypeSentAlert];
}

#pragma mark -- Private Methods
+ (void)grmsg_playSoundWithSoundName:(NSString *)soundName Type:(GRMessagesPlaySoundType)type{
    NSString *budleIdentifier = [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle.bundleIdentifier;
    NSBundle *_bundle = [NSBundle grmsg_bundle];
    NSString *filePath = nil;
    NSString * fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeCAF;
    if (_bundle) {
        [GRMessagsAudioServicesPlaySystemSound sharedInstance].bundle = _bundle;
        filePath = [NSString stringWithFormat:@"GRMessagesAssets.bundle/Sounds.%@",soundName];
        fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeAIFF;
        if (!filePath) {
            NSBundle *bundle = [NSBundle bundleWithPath:kGRMessagesBundlePath];
            filePath = [bundle pathForResource:soundName ofType:kGRMessagesAudioServicePlaySystemSoundTypeCAF];
            
            if ([filePath hasSuffix:[@"." stringByAppendingString:kGRMessagesAudioServicePlaySystemSoundTypeCAF]]) {
                NSArray *array = [filePath componentsSeparatedByString:@"."];
                if (array.count == 2) {
                    filePath = [array objectAtIndex:0];
                    fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeCAF;
                }else{
                    return;
                }
                if (!filePath) {
                    return;
                }
            }
        }
        
    }else{
        NSBundle *bundle = [NSBundle bundleWithPath:kGRMessagesBundlePath];
        filePath = [bundle pathForResource:soundName ofType:kGRMessagesAudioServicePlaySystemSoundTypeCAF];
        
        if ([filePath hasSuffix:[@"." stringByAppendingString:kGRMessagesAudioServicePlaySystemSoundTypeCAF]]) {
            NSArray *array = [filePath componentsSeparatedByString:@"."];
            if (array.count == 2) {
               filePath = [array objectAtIndex:0];
               fileExtensionType = kGRMessagesAudioServicePlaySystemSoundTypeCAF;
            }else{
                return;
            }
            if (!filePath) {
                return;
            }
        }
        
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

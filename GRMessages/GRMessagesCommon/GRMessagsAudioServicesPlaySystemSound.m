 
#import "GRMessagsAudioServicesPlaySystemSound.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <objc/runtime.h>
@interface NSMutableDictionary (safe)
- (id)safeObjectForKey:(id)key;
- (void)safeSetObject:(id)object forKey:(id)key;
- (void)safeRemoveObjectForKey:(id)key;
@end

@implementation NSMutableDictionary (safe)
-(id)safeObjectForKey:(id)key{
    if (key && self) {
       return [self objectForKey:key];
    }
    return nil;
}

-(void)safeSetObject:(id)object forKey:(id)key{
    if (object && key && self) {
        [self setObject:object forKey:key];
    }
}
-(void)safeRemoveObjectForKey:(id)key{
    if (key && self) {
        [self removeObjectForKey:key];
    }
}

@end

static NSString * const kGRMessagesAudioServicesPlaySystemSoundUserDefaultsKey = @"kGRMessagesAudioServicesPlaySystemSoundUserDefaultsKey";

NSString * const kGRMessagesAudioServicePlaySystemSoundTypeCAF  = @"caf";
NSString * const kGRMessagesAudioServicePlaySystemSoundTypeWAV  = @"wav";
NSString * const kGRMessagesAudioServicePlaySystemSoundTypeAIF  = @"aif"; // aif == aiff
NSString * const kGRMessagesAudioServicePlaySystemSoundTypeAIFF = @"aiff";

static void audioServicesSystemSoundCompletionProc(SystemSoundID ssID, void *data);

@interface GRMessagsAudioServicesPlaySystemSound ()
@property (nonatomic, assign, readwrite) BOOL isEnable;
@property (nonatomic, strong, readwrite) NSMutableDictionary *sounds;
@property (nonatomic, strong, readwrite) NSMutableDictionary *completionData;
@property (nonatomic, strong, readwrite) NSMutableDictionary *completionBlocks;
@end

@implementation GRMessagsAudioServicesPlaySystemSound
#pragma mark -- config
-(void)didReceiveMemoryWarningNot:(NSNotification *)noti{
    [self _configAudioServicesPlaySystemSoundToStopAllSounds:nil];
}
-(instancetype)init{
    if (self = [super init]) {
        _sounds = [[NSMutableDictionary alloc]init];
        _bundle = [NSBundle mainBundle];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMemoryWarningNot:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
-(void)setCompletionBlocks:(NSMutableDictionary *)completionBlocks{
    objc_setAssociatedObject(self, @selector(completionData), completionBlocks, OBJC_ASSOCIATION_RETAIN);
}
-(NSMutableDictionary *)completionBlocks{
    return objc_getAssociatedObject(self, _cmd);
}
-(NSMutableDictionary *)completionData{
    NSMutableDictionary *dic = [self completionBlocks];
    if (!dic) {
        [self setCompletionBlocks:[NSMutableDictionary dictionaryWithCapacity:0]];
        dic = self.completionBlocks;
    }
    return _completionData = dic;
}

-(void)dealloc{
    [self _configAudioServicesPlaySystemSoundToStopAllSounds:nil];
    _sounds = nil;
    _completionData = nil;
    self.completionBlocks = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

#pragma mark -- Puplic Methods

DEF_SINGLETON(GRMessagsAudioServicesPlaySystemSound);

- (void)grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
    [self grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:fullPathFileName fileExtensionType:fileExtensionType completion:nil];
}
- (void)grmsg_AudioServicesPlaySystemSoundToPlaySoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType completion:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completion{
[self _configAudioServicesPlaySystemSoundToPlaySoundWithFullPathFullName:fullPathFileName extensionType:fileExtensionType isAlertSound:NO completionBlock:completion];
}
- (void)grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
    [self grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:fullPathFileName fileExtensionType:fileExtensionType completion:nil];
}
- (void)grmsg_AudioServicesPlaySystemSoundToPlayAlertSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType completion:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completion{
    [self _configAudioServicesPlaySystemSoundToPlaySoundWithFullPathFullName:fullPathFileName extensionType:fileExtensionType isAlertSound:YES completionBlock:completion];
}
- (void)grmsg_AudioServicesPlaySystemSoundToPlayVibrateSound{
    [self _configAudioServicesPlaySystemSoundToPlayVibrateSound];
}
- (void)grmsg_AudioServicesPlaySystemSoundToTogglePlaySoundEnable:(BOOL)isEnable{
    [self _configAudioServicesPlaySystemSoundEnable:isEnable];
}

- (void)grmsg_AudioServicesPlaySystemSoundToStopSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
    [self _configAudioServicesPlaySystemSoundToStopSoundWithFullPathFileName:fullPathFileName fileExtensionType:fileExtensionType];
}

- (void)grmsg_AudioServicesPlaySystemSoundToStopAllSounds{
    [self grmsg_AudioServicesPlaySystemSoundToStopAllSoundsAfterCompletionBlcok:nil];
    
}
- (void)grmsg_AudioServicesPlaySystemSoundToStopAllSoundsAfterCompletionBlcok:(GRMessagesAudioServicePlaySystemSoundRemoveCompletionBlock)completionBlock{
    [self _configAudioServicesPlaySystemSoundToStopAllSounds:completionBlock];
}
- (void)grmsg_AudioServicesPlaySystemSoundToPreloadSoundWithFullPathFileNmae:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
    [self _configAudioServicesPlaySystemSoundToPreloadSoundWithFullPathFileNmae:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType];
}


#pragma mark -- Private Methods

-(void)_configAudioServicesPlaySystemSoundToPreloadSoundWithFullPathFileNmae:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
    if (![self.sounds objectForKey:fullPathFileName]) {
        [self _configAudioServicesPlaySystemSoundToAddSoundIDForAudioFileWithFullPathFileName:fullPathFileName withExtensionType:fileExtensionType];
    }
}
-(void)_configAudioServicesPlaySystemSoundToStopSoundWithFullPathFileName:(NSString *)fullPathFileName fileExtensionType:(NSString *)fileExtensionType{
     SystemSoundID soundID = [self _configAudioServicesPlaySystemSoundToGetSoundIDForFullPathFileNameKey:fullPathFileName];
    [self _configAudioServicesPlaySystemSoundToUnloadSoundIDForFullPathFileNamed:fullPathFileName];
    [self.sounds safeRemoveObjectForKey:fullPathFileName];
    [self.completionData safeRemoveObjectForKey:[self _configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:soundID]];
    
}
-(void)_configAudioServicesPlaySystemSoundToPlaySoundWithFullPathFullName:(NSString *)fullPathFullName extensionType:(NSString *)fileExtensionType isAlertSound:(BOOL)isAlertSound completionBlock:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completionBlock{
    if (!self.isEnable) {
        return;
    }
    if (!fileExtensionType || !fullPathFullName) {
        return;
    }
    if (![self.sounds safeObjectForKey:fullPathFullName]) {
        [self _configAudioServicesPlaySystemSoundToAddSoundIDForAudioFileWithFullPathFileName:fullPathFullName withExtensionType:fileExtensionType];
    }
    
    SystemSoundID soundID = [self _configAudioServicesPlaySystemSoundToGetSoundIDForFullPathFileNameKey:fullPathFullName];
    if (soundID == 0) {
        return;
    }
    if (completionBlock) {
       OSStatus error = AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, audioServicesSystemSoundCompletionProc, NULL);
        if (error!= kAudioServicesNoError) {
            
        }else{
            [self _configAudioServicesPlaySystemSoundToAddCompletionBlock:completionBlock ForSoundID:soundID];
        }
    }
}

-(void)_configAudioServicesPlaySystemSoundToAddSoundIDForAudioFileWithFullPathFileName:(NSString *)fullPathFileName withExtensionType:(NSString *)fileExtensionType{
    SystemSoundID soundID = [self _configAudioServicesPlaySystemSoundToCreateSoundIDWithFullPathFullName:fullPathFileName withExtensionType:fileExtensionType];
    if (soundID == 0) {
        return;
    }
     NSData *data = [self _configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:soundID];
    [self.sounds safeSetObject:data forKey:fullPathFileName];
}
-(SystemSoundID)_configAudioServicesPlaySystemSoundToCreateSoundIDWithFullPathFullName:(NSString *)fullPathFullName withExtensionType:(NSString *)fileExtensionType{
     NSURL *fileURL = [self.bundle URLForResource:fullPathFullName withExtension:fileExtensionType];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        SystemSoundID soundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(fileURL), &soundID);
        NSString *message = @"SystemSoundID could not be created";
      
        if (error == kAudioServicesNoError) {
            return soundID;
        }else{
             [self logError:error withMessage:message];
             return 0;
        }
    }else{
        NSLog(@"[%@] Error: can not find at URL: %@",[self class],fileURL);
    }
    return 0;
}
-(void)_configAudioServicesPlaySystemSoundToPlayVibrateSound{
    if (self.isEnable) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}
-(BOOL)_configAudioServicesPlaySystemSoundToToGetAudioServicesPlaySystemSoundEnableFromNSUserDefaults{
    NSNumber *state = [[NSUserDefaults standardUserDefaults]objectForKey:kGRMessagesAudioServicesPlaySystemSoundUserDefaultsKey];
    if (!state) {
        [self _configAudioServicesPlaySystemSoundEnable:YES];
        
        return YES;
    }
    return [state boolValue];
}
-(void)_configAudioServicesPlaySystemSoundEnable:(BOOL)enable{
    _isEnable = enable;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(enable) forKey:kGRMessagesAudioServicesPlaySystemSoundUserDefaultsKey];

    [userDefaults synchronize];
    if (!enable) {
        [self _configAudioServicesPlaySystemSoundToStopAllSounds:nil];
    }
}

-(void)_configAudioServicesPlaySystemSoundToStopAllSounds:(GRMessagesAudioServicePlaySystemSoundRemoveCompletionBlock)completionBlock{
   [self.sounds enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       [self _configAudioServicesPlaySystemSoundToUnloadSoundIDForFullPathFileNamed:key];
   }];
    [self.sounds removeAllObjects];
    [self.completionData removeAllObjects];
    if (completionBlock) {
        completionBlock();
    }
}

-(void)_configAudioServicesPlaySystemSoundToUnloadSoundIDForFullPathFileNamed:(NSString *)fullPathFileName{
    SystemSoundID soundID =[self _configAudioServicesPlaySystemSoundToGetSoundIDForFullPathFileNameKey:fullPathFileName];
    if (soundID) {
        AudioServicesRemoveSystemSoundCompletion(soundID);
        OSStatus error = AudioServicesDisposeSystemSoundID(soundID);
        NSString *messgae = [NSString stringWithFormat:@"SystemSoundID(%d) disposed info.",soundID];
        [self logError:error withMessage:messgae];
    }
}
-(SystemSoundID)_configAudioServicesPlaySystemSoundToGetSoundIDForFullPathFileNameKey:(NSString *)fullPathFileNameKey{
    NSData *soundData = [self.sounds objectForKey:fullPathFileNameKey];
    return [self _configAudioServicesPlaySystemSoundToGetSoundIDForSoundDataKey:soundData];
}
-(SystemSoundID)_configAudioServicesPlaySystemSoundToGetSoundIDForSoundDataKey:(NSData *)soundDataKey{
    if (!soundDataKey) {
        return 0;
    }
    SystemSoundID soundID;
    [soundDataKey getBytes:&soundID length:sizeof(SystemSoundID)];
    return soundID;
}
-(NSData *)_configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:(SystemSoundID)soundID{
    return [NSData dataWithBytes:&soundID length:sizeof(SystemSoundID)];
}
-(void)_configAudioServicesPlaySystemSoundToAddCompletionBlock:(GRMessagesAudioServicePlaySystemSoundCompletionBlock)completionBlock ForSoundID:(SystemSoundID)SoundID{
    [self.completionData safeSetObject:completionBlock forKey:[self _configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:SoundID]];
}
-(GRMessagesAudioServicePlaySystemSoundCompletionBlock)_configAudioServicesPlaySystemSoundToGetCompletionBlockForSoundID:(SystemSoundID)SoundID{
    return [self.completionData safeObjectForKey:[self _configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:SoundID]];
}
-(void)logError:(OSStatus)errorStatus withMessage:(NSString *)message{
    /*!
     @enum           AudioServices error codes
     @abstract       Error codes returned from the AudioServices portion of the API.
     @constant       kAudioServicesNoError
     No error has occurred
     @constant       kAudioServicesUnsupportedPropertyError
     The property is not supported.
     @constant       kAudioServicesBadPropertySizeError
     The size of the property data was not correct.
     @constant       kAudioServicesBadSpecifierSizeError
     The size of the specifier data was not correct.
     @constant       kAudioServicesSystemSoundUnspecifiedError
     A SystemSound unspecified error has occurred.
     @constant       kAudioServicesSystemSoundClientTimedOutError
     SystemSound client message timed out
     */
    
    NSString *errorMsg =nil;
    switch (errorStatus) {
        case kAudioServicesUnsupportedPropertyError:
            errorMsg = @" The property is not supported.";
            break;
        case kAudioServicesBadSpecifierSizeError:
            errorMsg =@"The size of the specifier data was not correct.";
            break;
            
        case kAudioServicesNoError:
            errorMsg = @"No error has occurred";
            break;
        case kAudioServicesSystemSoundUnspecifiedError:
            errorMsg = @"A SystemSound unspecified error has occurred.";
            break;
        case kAudioServicesBadPropertySizeError:
            errorMsg = @"The size of the property data was not correct.";
            break;
    
        case kAudioServicesSystemSoundClientTimedOutError:
            errorMsg = @"SystemSound client message timed out";
            break;
       
        default:
            break;
    }
    
    NSLog(@"<[%@], %@ <errorStautus>:(code: %d) <errorMsg>%@>",[self class],message,errorStatus,errorMsg);
}
-(void)_configAudioServicesPlaySystemSoundToRemoveCompletionBlockForSoundID:(SystemSoundID)soundID{
    NSData *key = [self _configAudioServicesPlaySystemSoundToTransformIntoDataBySoundID:soundID];
    [self.completionData safeRemoveObjectForKey:key];
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

@end

static void audioServicesSystemSoundCompletionProc(SystemSoundID ssID, void *data){
    GRMessagsAudioServicesPlaySystemSound *play = [GRMessagsAudioServicesPlaySystemSound sharedInstance];
    GRMessagesAudioServicePlaySystemSoundCompletionBlock completionBlock = [play _configAudioServicesPlaySystemSoundToGetCompletionBlockForSoundID:ssID];
    if (completionBlock) {
        completionBlock();
        [play _configAudioServicesPlaySystemSoundToRemoveCompletionBlockForSoundID:ssID];
    }
}
//
//  GRMessage.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessage.h"
#import <objc/message.h>
#import "NSString+Extensions.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
static NSArray *GetIvarList(Class cls)
{
    NSMutableArray *propertyNames = [[NSMutableArray alloc]initWithCapacity:0];
    unsigned int IvarCount = 0;
    Ivar*ivars= class_copyIvarList(cls, &IvarCount);
    unsigned int i;
    for (i = 0; i < IvarCount; i++) {
        Ivar aIvar = ivars[i];
        const char *name = ivar_getName(aIvar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [propertyNames addObject:nameStr];
    }
    free(ivars);
    return propertyNames.copy;
}

@implementation GRMessage

#pragma mark- Public Methods
+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date text:(NSString *)text{
    return [[self alloc]initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:text];
}
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date text:(NSString *)text{
    NSParameterAssert(text != nil);
    if (self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName date:date isMedia:NO]) {
        _text = text.copy;
    }
    
    return self;
}


+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp text:(NSString *)text{
    return [[self alloc]initWithSenderId:senderId senderDisplayName:senderDisplayName timestamp:timestamp text:text];
}
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp text:(NSString *)text{
    NSParameterAssert(text != nil);
    if (self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName timestamp:timestamp isMedia:NO]) {
        _text = text.copy;
    }
    return self;
}



+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName media:(id<GRMessagesMediaData>)media{
    return [[self alloc]initWithSenderId:senderId senderDisplayName:senderDisplayName date:[NSDate date] media:media];
}

- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date media:(id<GRMessagesMediaData>)media{
    NSParameterAssert(media != nil);
    if (self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName date:date isMedia:YES]) {
        _media = media;
    }
    return self;
}



+ (instancetype)messageWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp media:(id<GRMessagesMediaData>)media{
    return [[self alloc]initWithSenderId:senderId senderDisplayName:senderDisplayName timestamp:timestamp media:media];
}

- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp media:(id<GRMessagesMediaData>)media{
    NSParameterAssert(media != nil);
    if (self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName timestamp:timestamp isMedia:YES]) {
        _media = media;
    }
    return self;
}


#pragma mark- Private Methods
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date isMedia:(BOOL)isMedia{
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(senderId != nil);
    NSParameterAssert(date != nil);
    
    if (self = [super init]) {
        _senderId          = senderId.copy;
        _senderDisplayName = senderDisplayName.copy;
        _date              = date.copy;
        _isMediaMessage    = isMedia;
    }
    
    return self;
}
- (instancetype)initWithSenderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName timestamp:(NSString *)timestamp isMedia:(BOOL)isMedia{
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(senderId != nil);
    NSParameterAssert(timestamp != nil);
    
    if (self = [super init]) {
        _senderId          = senderId.copy;
        _senderDisplayName = senderDisplayName.copy;
        _timestamp         = timestamp.copy;
        _isMediaMessage    = isMedia;
    }
    
    return self;
}

- (instancetype)init{
    NSAssert(NO, @"%s is not a valid initializer for %@",__PRETTY_FUNCTION__ , [self class]);return nil;
}


-(void)dealloc{
    _senderId          = nil;
    _senderDisplayName = nil;
    _timestamp         = nil;
    _text              = nil;
    _media             = nil;
}
-(NSUInteger)messageHash{
    return self.hash;
}

-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    GRMessage *aMessage = (GRMessage *)object;
    
    if (self.isMediaMessage != aMessage.isMediaMessage) {
        return NO;
    }
    BOOL ret = NO ;
    if (self.date != nil) {
        ret = [self.date compare:aMessage.date] == NSOrderedSame;
    }else if (self.timestamp != nil) {
         NSString *_times = [self.timestamp filterSpecialString];
         NSString *a_times = [aMessage.timestamp filterSpecialString];
        ret = [_times compare:a_times] == NSOrderedSame;
    }
    BOOL hasEqualContent = self.isMediaMessage ? [self.media isEqual:aMessage.media]:[self.text isEqualToString:aMessage.text];
    return [self.senderId isEqualToString:aMessage.senderId] && [self.senderDisplayName isEqualToString:aMessage.senderDisplayName] && hasEqualContent && ret;
}
-(NSUInteger)hash{
    if (self.date) {
         return self.senderId.hash^self.date.hash^(self.isMediaMessage ?[self.media mediaHash]:self.text.hash);
    }else if (self.timestamp){
         NSString *_times = [self.timestamp filterSpecialString];
         return self.senderId.hash^_times.hash^(self.isMediaMessage ?[self.media mediaHash]:self.text.hash);
    }
    return self.senderId.hash^self.date.hash^(self.isMediaMessage ?[self.media mediaHash]:self.text.hash);
}



#pragma mark -- NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    NSArray *propertyNames = GetIvarList([self class]);
    
    for (NSString *name in propertyNames) {
        id value = [self valueForKey:name];
        [encoder encodeObject:value forKey:name];
    }
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        NSArray *propertyNames = GetIvarList([self class]);
        
        for (NSString *key in propertyNames) {
            
            id value = [decoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
        }
        
    }
    
    return self;
}

- (NSString *)description{
    
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    
    NSArray *properNames = GetIvarList([self class]);
    
    for (NSString *propertyName in properNames) {
        
        NSString *key = nil;
        
        if ([propertyName hasPrefix:@"_"]) {
            
            key = [propertyName substringFromIndex:1];
        }else{
            key = [propertyName substringFromIndex:0];
        }
        SEL getSel = NSSelectorFromString(key);
        
        NSString *propertyNameString = nil;
        
        id _getSel = nil;
        
        SuppressPerformSelectorLeakWarning(_getSel=[self performSelector:getSel]);
        
        propertyNameString = [NSString stringWithFormat:@"%@:%@,\n",key,_getSel];
        
        [descriptionString appendFormat:@"%@",propertyNameString];
    }
    NSString *str_n = @"{";
    
    NSString *str_m = @"}";
    
    NSString *desc = [NSString stringWithFormat:@"\n%@%@%@",str_n,descriptionString,str_m];
    
    return [desc copy];
}


#pragma mark - NSCopying

-(id)copyWithZone:(NSZone *)zone{
    if (self.isMediaMessage) {
        if (self.date != nil) {
           return [[[self class]allocWithZone:zone]initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:self.date media:self.media];
        }else if (self.timestamp != nil){
           return [[[self class]allocWithZone:zone]initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName timestamp:self.timestamp media:self.media];
        }
      
    }else{
        if (self.date != nil) {
            return [[[self class]allocWithZone:zone] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:self.date text:self.text];
        }else if (self.timestamp != nil){
            return [[[self class]allocWithZone:zone] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName timestamp:self.timestamp text:self.text];
        }
    }
    return [[[self class]allocWithZone:zone] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName timestamp:self.timestamp text:self.text];
}

@end

//
//  GRMessagesMediaItem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"
#import <objc/runtime.h>

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
@interface GRMessagesMediaItem()
@property (nonatomic, strong) UIView *cachedPlaceholderView;
@end

@implementation GRMessagesMediaItem

- (instancetype)initWithFakeActionType:(GRMessagesMediaItemActionType)fakeActionType
{
    if (self = [super init]) {
        _appliesMediaViewFakeActionType = fakeActionType;
        _cachedPlaceholderView = nil;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
- (instancetype)init{
    return [self initWithFakeActionType:GRMessagesMediaItemActionTypeOutgoing];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    _cachedPlaceholderView = nil;
}
- (void)setAppliesMediaViewFakeActionType:(GRMessagesMediaItemActionType)appliesMediaViewFakeActionType{
    _appliesMediaViewFakeActionType = appliesMediaViewFakeActionType;
    _cachedPlaceholderView = nil;
}

-(void)setAppliesMediaItemType:(GRMessagesMediaItemType)appliesMediaItemType{
    _appliesMediaItemType = appliesMediaItemType;
    _cachedPlaceholderView = nil;
}

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification{
    [self clearCacheMediaViews];
}
- (void)clearCacheMediaViews{
    _cachedPlaceholderView = nil;
}

- (UIView *)mediaView{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s",__PRETTY_FUNCTION__);
    return nil;
}

- (CGSize)mediaViewDisplaySize{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (self.appliesMediaItemType == GRMessagesMediaItemTypeFile) {
            return CGSizeMake(315.0f, 85.0f);
        }else if (self.appliesMediaItemType == GRMessagesMediaItemTypeAudio){
            return CGSizeMake(100.0f, 40.0f);
        }
        
        return CGSizeMake(315.0f, 225.0f);
    }
    
    if (self.appliesMediaItemType == GRMessagesMediaItemTypeFile) {
        return CGSizeMake(210.0f, 85.0f);
    }else if (self.appliesMediaItemType == GRMessagesMediaItemTypeAudio){
        return CGSizeMake(100.0f, 40.0f);
    }
    return CGSizeMake(210.0f, 150.0f);
    
}

- (UIView *)mediaPlaceholderView{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIView *view = [GRMessagesMediaPlaceholderView viewWithActivityIndicator];
        view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        self.cachedPlaceholderView = view;
    }
    return self.cachedPlaceholderView;
}
- (NSUInteger)mediaHash{
    return self.hash;
}
- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.appliesMediaViewFakeActionType == ((GRMessagesMediaItem *)object).appliesMediaViewFakeActionType;
}

- (NSUInteger)hash{
    return [NSNumber numberWithUnsignedInteger:self.appliesMediaViewFakeActionType].hash;
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

-(id)copyWithZone:(NSZone *)zone{
    return [[[self class]allocWithZone:zone] initWithFakeActionType:self.appliesMediaViewFakeActionType];
}
@end

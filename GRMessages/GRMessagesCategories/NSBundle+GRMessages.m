//
//  NSBundle+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "NSBundle+GRMessages.h"
#import "GRMessagesViewController.h"

static NSString * const kBundleResourcePath = @"GRMessagesAssets.bundle";

static NSString * const kBundleSystemPath = @"/System/Library/Audio/UISounds";

@implementation NSBundle (GRMessages)
+(NSBundle *)grmsg_bundle{
    return [NSBundle bundleForClass:[GRMessagesViewController class]];
}
+(NSBundle *)grmsg_bundleFromAssets{
    return [NSBundle bundleWithPath:[[NSBundle grmsg_bundle].resourcePath stringByAppendingString:kBundleResourcePath]];
}
+(NSBundle *)grmsg_bundleFromSystem{
    return [NSBundle bundleWithPath:kBundleSystemPath];
}
+ (UIImage *)grmsg_bundleImageWithImageName:(NSString *)imageName{
   return [self grmsg_bundleImageWithImageName:imageName Type:@"png"];
}
+ (UIImage *)grmsg_bundleImageWithImageName:(NSString *)imageName Type:(NSString *)type{
    return [UIImage imageWithContentsOfFile:[[NSBundle grmsg_bundleFromAssets] pathForResource:imageName ofType:type inDirectory:@"Images"]];
}
+(NSString *)grmsg_localizedStringForKey:(NSString *)key comment:(NSString *)comment{
    return NSLocalizedStringFromTableInBundle(key, @"GRMessages", [NSBundle grmsg_bundleFromAssets], comment);
}
@end

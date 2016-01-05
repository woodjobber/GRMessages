//
//  UIDevice+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "UIDevice+GRMessages.h"

@implementation UIDevice (GRMessages)
+ (BOOL)grmsg_isCurrentDeviceBeforeiOS7{
    return [[UIDevice currentDevice].systemVersion compare:@"7.0f" options:NSNumericSearch] == NSOrderedAscending;
}

+ (BOOL)grmsg_isCurrentDeviceBeforeiOS8{
    return [[UIDevice currentDevice].systemVersion compare:@"8.0f" options:NSNumericSearch] == NSOrderedAscending;
}
+ (NSString *)grmsg_getCurrentDeviceSystemVersion{
    return [UIDevice currentDevice].systemVersion;
}

@end

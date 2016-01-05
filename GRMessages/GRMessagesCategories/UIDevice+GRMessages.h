//
//  UIDevice+GRMessages.h
//  GRMessages
//
//  Created by chengbin on 16/1/5.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (GRMessages)

+ (BOOL)grmsg_isCurrentDeviceBeforeiOS7;

+ (BOOL)grmsg_isCurrentDeviceBeforeiOS8;

+ (NSString *)grmsg_getCurrentDeviceSystemVersion;

@end

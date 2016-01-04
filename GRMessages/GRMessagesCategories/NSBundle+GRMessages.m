//
//  NSBundle+GRMessages.m
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "NSBundle+GRMessages.h"
#import "GRMessagesViewController.h"
@implementation NSBundle (GRMessages)
+(NSBundle *)grmsg_bundle{
    return [NSBundle bundleForClass:[GRMessagesViewController class]];
}
@end

//
//  NSBundle+GRMessages.h
//  GRMessages
//
//  Created by chengbin on 16/1/4.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (GRMessages)

+ (NSBundle *)grmsg_bundle;

+ (NSBundle *)grmsg_bundleFromAssets;

+ (NSBundle *)grmsg_bundleFromSystem;

+ (UIImage *)grmsg_bundleImageWithImageName:(NSString *)imageName;

+ (UIImage *)grmsg_bundleImageWithImageName:(NSString *)imageName Type:(NSString *)type;

+ (NSString *)grmsg_localizedStringForKey:(NSString *)key comment:(NSString *)comment;

@end

//
//  GRMessagesInputToolbarButtonFactroy.h
//  GRMessages
//
//  Created by chengbin on 16/1/11.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GRMessagesInputToolbarButtonFactroy : NSObject
+ (UIButton *)defaultAccessoryButtonItem;

+ (UIButton *)defaultVoiceButtonItem;

+ (UIButton *)defaultSecondAccessoryButtonItem;

@end

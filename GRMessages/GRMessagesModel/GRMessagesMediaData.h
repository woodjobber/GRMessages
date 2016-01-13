//
//  GRMessagesMediaData.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GRMessagesMediaData <NSObject>

@required

- (UIView *)mediaView;

- (CGSize)mediaViewDisplaySize;

- (UIView *)mediaPlaceholderView;

- (NSUInteger)mediaHash;



@end

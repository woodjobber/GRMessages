//
//  GRMessagesBubbleImageDataSource.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GRMessagesBubbleImageDataSource  <NSObject>

@required

- (UIImage *)messageBubbleImage;

- (UIImage *)messageBubbleHightlightedImage;

@end
//
//  GRMessagesPhotoMediaItem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"

@interface GRMessagesPhotoMediaItem : GRMessagesMediaItem 
@property (copy,nonatomic) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;
@end

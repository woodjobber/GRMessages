//
//  GRMessagesPhotoMediaItem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesPhotoMediaItem.h"
@interface GRMessagesPhotoMediaItem()

@property (nonatomic, strong) UIImageView *cachedImageView;

@end

@implementation GRMessagesPhotoMediaItem
-(instancetype)initWithImage:(UIImage *)image{
    if (self =[super init]) {
        _cachedImageView = nil;
        _image = image.copy;
         self.appliesMediaItemType = GRMessagesMediaItemTypePhoto;
    }
    return self;
}

-(void)dealloc{
    _cachedImageView = nil;
    _image = nil;
}

-(void)clearCacheMediaViews{
    [super clearCacheMediaViews];
    _cachedImageView = nil;
}

-(void)setImage:(UIImage *)image{
    _image = image.copy;
    _cachedImageView = nil;
}
-(void)setAppliesMediaViewFakeActionType:(GRMessagesMediaItemActionType)appliesMediaViewFakeActionType{
    [super setAppliesMediaViewFakeActionType:appliesMediaViewFakeActionType];
    _cachedImageView = nil;
}
-(void)setAppliesMediaItemType:(GRMessagesMediaItemType)appliesMediaItemType{
    [super setAppliesMediaItemType:appliesMediaItemType];
    _cachedImageView = nil;
}
-(UIView *)mediaView{
    if (self.image == nil) {
        return nil;
    }
    if (self.cachedImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.image];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [GRMessagesMediaViewBubbleImageFaker configureBubbleImageFakeToMediaView:imageView ActionType:self.appliesMediaViewFakeActionType];
        self.cachedImageView = imageView;
    }
    return self.cachedImageView;
}
-(BOOL)isEqual:(id)object{
    if (![super isEqual:object]) {
        return NO;
    }
    GRMessagesPhotoMediaItem *photoItem = (GRMessagesPhotoMediaItem *)object;
    return [self.image isEqual:photoItem.image];
}
-(NSUInteger)mediaHash{return self.hash;}

-(NSUInteger)hash{
    return super.hash ^ self.image.hash;
}

-(id)copyWithZone:(NSZone *)zone{
    GRMessagesPhotoMediaItem *copy = [[GRMessagesPhotoMediaItem allocWithZone:zone]initWithImage:self.image];
    copy.appliesMediaViewFakeActionType = self.appliesMediaViewFakeActionType;
    return copy;
}
@end

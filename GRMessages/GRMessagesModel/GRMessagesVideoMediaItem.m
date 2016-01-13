//
//  GRMessagesVideoMediaItem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesVideoMediaItem.h"
#import "UIImage+GRMessages.h"
#import "GRMessagesMediaViewBubbleImageFaker.h"
#import "GRMessagesMediaPlaceholderView.h"

@interface GRMessagesVideoMediaItem()
@property (nonatomic, strong)UIImageView *cachedVideoImageView;
@end
@implementation GRMessagesVideoMediaItem
-(instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay{
    if (self = [super init]) {
        _fileURL = fileURL;
        _isReadyToPlay =isReadyToPlay;
        _cachedVideoImageView = nil;
    }
    return self;
}

-(void)dealloc{
    _fileURL = nil;
    _cachedVideoImageView = nil;

}

-(void)clearCacheMediaViews{
    [super clearCacheMediaViews];
    _cachedVideoImageView = nil;
}

-(void)setFileURL:(NSURL *)fileURL{
    _fileURL = fileURL;
    _cachedVideoImageView = nil;
}

-(void)setIsReadyToPlay:(BOOL)isReadyToPlay{
    _isReadyToPlay = isReadyToPlay;
    _cachedVideoImageView = nil;
}

-(void)setAppliesMediaViewFakeActionType:(GRMessagesMediaItemActionType)appliesMediaViewFakeActionType{

    [super setAppliesMediaViewFakeActionType:appliesMediaViewFakeActionType];
    _cachedVideoImageView = nil;
}


- (NSUInteger)mediaHash{
    return self.hash;
}

-(UIView *)mediaView{
    if (self.fileURL == nil || self.isReadyToPlay) {
        return nil;
    }
    if (self.cachedVideoImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImage *palyIcon = [[UIImage grmsg_defaultPlayImage] grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:palyIcon];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeCenter;
        imageView.clipsToBounds = YES;
        [GRMessagesMediaViewBubbleImageFaker configureBubbleImageFakeToMediaView:imageView ActionType:self.appliesMediaViewFakeActionType];
        self.cachedVideoImageView = imageView;
    }
    return self.cachedVideoImageView;
    
}

- (BOOL)isEqual:(id)object{
    if (![super isEqual:object]) {
        return NO;
    }
    GRMessagesVideoMediaItem *item = (GRMessagesVideoMediaItem *)object;
    return [self.fileURL isEqual:item.fileURL] && self.isReadyToPlay == item.isReadyToPlay;
}
-(NSUInteger)hash{
    return super.hash^self.fileURL.hash;
}

-(id)copyWithZone:(NSZone *)zone{
    GRMessagesVideoMediaItem *copy = [[[self class] allocWithZone:zone] initWithFileURL:self.fileURL isReadyToPlay:self.isReadyToPlay];
    copy.appliesMediaViewFakeActionType = self.appliesMediaViewFakeActionType;
    return copy;
}

@end

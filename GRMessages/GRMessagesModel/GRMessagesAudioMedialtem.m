//
//  GRMessagesAudioMedialtem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesAudioMedialtem.h"
@interface GRMessagesAudioMedialtem()
@property (nonatomic, strong)UIImageView *cachedImageView;
@end

@implementation GRMessagesAudioMedialtem

-(instancetype)initWithAudioObject:(NSObject*)audioObject isReadyToPlay:(BOOL)isReadyToPlay{
    if (self = [super init]) {
        _audioObject = audioObject;
        _cachedImageView = nil;
         self.appliesMediaItemType = GRMessagesMediaItemTypeAudio;
    }
    return self;
}
-(void)dealloc{
    _audioObject = nil;
    _cachedImageView = nil;
}

-(void)clearCacheMediaViews{
    [super clearCacheMediaViews];
    _cachedImageView = nil;
}
-(void)setFileObject:(NSObject*)fileObject{
    _audioObject = fileObject;
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

-(void)setIsReadyToPlay:(BOOL)isReadyToPlay{
    _isReadyToPlay = isReadyToPlay;
    _cachedImageView = nil;
}
-(NSUInteger)mediaHash{
    return self.hash;
}
-(UIView *)mediaView{
    if (self.audioObject == nil ||!self.isReadyToPlay) {
        return nil;
    }
    if (self.cachedImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImage *audioIcon = [[UIImage grmsg_defaultAudioImage]grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
        UIImageView *imageView =[[UIImageView alloc]initWithImage:audioIcon];
        imageView.backgroundColor =[UIColor lightGrayColor];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.clipsToBounds = YES;
    }
    return self.cachedImageView;
}
-(NSUInteger)hash{
    return super.hash ^ self.audioObject.hash;
}
-(BOOL)isEqual:(id)object{
    if (![super isEqual:object]) {
        return NO;
    }
    GRMessagesAudioMedialtem *audioItem = (GRMessagesAudioMedialtem *)object;
    return [self.audioObject isEqual:audioItem.audioObject] && self.isReadyToPlay == audioItem.isReadyToPlay;
}

-(id)copyWithZone:(NSZone *)zone{
    GRMessagesAudioMedialtem *copy = [[[self class]allocWithZone:zone]initWithAudioObject:self.audioObject isReadyToPlay:self.isReadyToPlay];
    copy.appliesMediaViewFakeActionType = self.appliesMediaViewFakeActionType;
    return copy;
}
@end

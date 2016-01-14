//
//  GRMessagesFileMedialtem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesFileMediaItem.h"
@interface GRMessagesFileMediaItem()

@property (nonatomic ,strong) UIImageView *cachedFileImageView;

@end

@implementation GRMessagesFileMediaItem
-(instancetype)init{
      NSAssert(NO, @"%s is not avlid initializer for %@.Use instead.",__PRETTY_FUNCTION__, [self class],NSStringFromSelector(@selector(initWithFileObject:fileOptionsType:)));
    return nil;
}
-(instancetype)initWithFileObject:(NSObject *)fileObject fileOptionsType:(GRMessagesFileMediaItemOptionsType)fileOptionsType {
    if (self =[super init]) {
        _fileObject = fileObject;
        _optionsType = fileOptionsType;
        _cachedFileImageView = nil;
         self.appliesMediaItemType = GRMessagesMediaItemTypeFile;
    }
    return self;
}

-(void)dealloc{
    _fileObject = nil;
    _cachedFileImageView = nil;
}

-(void)clearCacheMediaViews{
    [super clearCacheMediaViews];
    _cachedFileImageView = nil;
}

-(void)setFileURL:(NSURL *)fileURL{
    _fileObject = fileURL.copy;
    _cachedFileImageView = nil;
}
-(void)setOptionsType:(GRMessagesFileMediaItemOptionsType)optionsType{
    _optionsType = optionsType;
}
-(void)setAppliesMediaViewFakeActionType:(GRMessagesMediaItemActionType)appliesMediaViewFakeActionType{
    [super setAppliesMediaViewFakeActionType:appliesMediaViewFakeActionType];
    _cachedFileImageView = nil;
}

-(void)setAppliesMediaItemType:(GRMessagesMediaItemType)appliesMediaItemType{
    [super setAppliesMediaItemType:appliesMediaItemType];
    _cachedFileImageView = nil;
}

-(UIView *)mediaView{
    if (self.fileObject == nil) {
        return nil;
    }
   
    if (self.cachedFileImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImage *fileIcon = [[UIImage grmsg_defaultFileImage]grmsg_imageMaskdWithColor:[UIColor lightGrayColor]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:fileIcon];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.frame = CGRectMake(0.0f,0.0f , size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [GRMessagesMediaViewBubbleImageFaker configureBubbleImageFakeToMediaView:imageView ActionType:self.appliesMediaViewFakeActionType];
        self.cachedFileImageView = imageView;
    }
    
    return self.cachedFileImageView;
}

-(NSUInteger)mediaHash{
    return self.hash;
}

-(BOOL)isEqual:(id)object{
    if (![super isEqual:object]) {
        return NO;
    }
    GRMessagesFileMediaItem *fileItem  = (GRMessagesFileMediaItem *)object;
    return [self.fileObject isEqual:fileItem.fileObject] && (self.optionsType == fileItem.optionsType);
}
-(NSUInteger)hash{
    return super.hash^self.fileObject.hash;
}

-(id)copyWithZone:(NSZone *)zone{
    GRMessagesFileMediaItem *copy = [[GRMessagesFileMediaItem allocWithZone:zone]initWithFileObject:self.fileObject fileOptionsType:self.optionsType];
    copy.appliesMediaViewFakeActionType = self.appliesMediaViewFakeActionType;
    return copy;
}

@end

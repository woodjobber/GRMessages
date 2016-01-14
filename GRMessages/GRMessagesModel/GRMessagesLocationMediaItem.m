//
//  GRMessagesLocationMediaItem.m
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesLocationMediaItem.h"
@interface GRMessagesLocationMediaItem()

@property (nonatomic, strong) UIImage *cachedMapSnapshotImage;

@property (nonatomic, strong) UIImageView *cachedMapImageView;

@end

@implementation GRMessagesLocationMediaItem

-(instancetype)initWithLocation:(CLLocation *)location{
    if (self =[super init]) {
         self.appliesMediaItemType = GRMessagesMediaItemTypeLocation;
        [self setLocation:location withCompletionHandler:nil];
    }
    return self;
}
-(void)dealloc{
    _location = nil;
    _cachedMapImageView = nil;
    _cachedMapSnapshotImage = nil;
}

-(void)setLocation:(CLLocation *)location{
    [self setLocation:location withCompletionHandler:nil];
}
-(void)setAppliesMediaViewFakeActionType:(GRMessagesMediaItemActionType)appliesMediaViewFakeActionType{
    [super setAppliesMediaViewFakeActionType:appliesMediaViewFakeActionType];
    _cachedMapSnapshotImage = nil;
    _cachedMapImageView = nil;
}
-(void)setAppliesMediaItemType:(GRMessagesMediaItemType)appliesMediaItemType{
    [super setAppliesMediaItemType:appliesMediaItemType];
    _cachedMapImageView = nil;
}
-(void)setLocation:(CLLocation *)location region:(MKCoordinateRegion)region withCompletionHandler:(GRMessagesMediaItemCompletionBlock)completionBlock{
    _location = location.copy;
    _cachedMapImageView = nil;
    _cachedMapSnapshotImage = nil;
    if (_location == nil) {
        return;
    }
    [self _createMapSnapshotForLocation:location coordinateRegion:region withCompletionHandler:completionBlock];
}

-(void)setLocation:(CLLocation *)location withCompletionHandler:(GRMessagesMediaItemCompletionBlock)completionBlock{
   
    [self setLocation:location region:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0f, 500.0f) withCompletionHandler:completionBlock];
}



-(void)_createMapSnapshotForLocation:(CLLocation *)location coordinateRegion:(MKCoordinateRegion)region withCompletionHandler:(GRMessagesMediaItemCompletionBlock)completion{

    NSParameterAssert(location !=nil);
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc]init];
    options.region = region;
    options.size = [self mediaViewDisplaySize];
    options.scale = [UIScreen mainScreen].scale;
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc]initWithOptions:options];
    [snapshotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        MKAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:nil];
        CGPoint coordinatePoint =[snapshot pointForCoordinate:location.coordinate];
        UIImage *image = snapshot.image;
        coordinatePoint.x += pin.centerOffset.x - (CGRectGetWidth(pin.bounds)/2.0f);
        coordinatePoint.y += pin.centerOffset.y - (CGRectGetHeight(pin.bounds)/2.0f);
        UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
        {
            [image drawAtPoint:CGPointZero];
            [pin.image drawAtPoint:coordinatePoint];
            self.cachedMapSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    }];
}

-(CLLocationCoordinate2D)coordinate{
    return self.location.coordinate;
}

-(UIView *)mediaView{
    if (self.cachedMapSnapshotImage == nil||self.location == nil) {
        UIImageView *imageView =[[UIImageView alloc]initWithImage:self.cachedMapSnapshotImage];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [GRMessagesMediaViewBubbleImageFaker configureBubbleImageFakeToMediaView:imageView ActionType:self.appliesMediaViewFakeActionType];
        self.cachedMapImageView= imageView;
    }
    return self.cachedMapImageView;
}
-(NSUInteger)mediaHash{
    return self.hash;
}
-(BOOL)isEqual:(id)object{

    if (![super isEqual:object]) {
        return NO;
    }
    GRMessagesLocationMediaItem *locationItem = (GRMessagesLocationMediaItem *)object;
    return [self.location isEqual:locationItem.location];
    
}
-(NSUInteger)hash{
    return super.hash ^ self.location.hash;
}
-(id)copyWithZone:(NSZone *)zone{
    GRMessagesLocationMediaItem *copy = [[GRMessagesLocationMediaItem allocWithZone:zone]initWithLocation:self.location];
    copy.appliesMediaViewFakeActionType = self.appliesMediaViewFakeActionType;
    return copy;
}

@end

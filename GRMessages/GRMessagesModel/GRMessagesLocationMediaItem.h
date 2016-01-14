//
//  GRMessagesLocationMediaItem.h
//  GRMessages
//
//  Created by chengbin on 16/1/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "GRMessagesMediaItem.h"
#import <MapKit/MapKit.h>
typedef void (^GRMessagesMediaItemCompletionBlock)(void);
@interface GRMessagesLocationMediaItem : GRMessagesMediaItem <MKAnnotation>

@property (copy , nonatomic)CLLocation *location;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
-(instancetype)initWithLocation:(CLLocation *)location;
-(void)setLocation:(CLLocation *)location withCompletionHandler:(GRMessagesMediaItemCompletionBlock)completionBlock;
-(void)setLocation:(CLLocation *)location
            region:(MKCoordinateRegion)region
withCompletionHandler:(GRMessagesMediaItemCompletionBlock)completionBlock;


@end

//
//  SaveImage.h
//  GRUC
//
//  Created by chengbin on 16/1/21.
//
//

#import <Foundation/Foundation.h>

@interface SaveImage : NSObject
- (void)saveImagesToSql:(NSData *)imgData withimageName:(NSString *)name;

- (NSData *)loadImagesFromSql:(NSString *)imageName;
@end

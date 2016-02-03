
//
//  UIImage+Thumbanail.m
//  GRUC
//
//  Created by chengbin on 16/1/28.
//
//

#import "UIImage+Thumbanail.h"

@implementation UIImage (Thumbanail)
+ (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0f) {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0f);
        }else if ([[UIScreen mainScreen] scale] == 3.0f){
            UIGraphicsBeginImageContextWithOptions(size, YES, 3.0f);
        }
        else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
            UIGraphicsBeginImageContext(size);
    }
}

+ (void)endImageContext
{
    UIGraphicsEndImageContext();
}

+ (UIImage*)imageFromView:(UIView*)view
{
    [self beginImageContextWithSize:[view bounds].size];
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    [view setHidden:hidden];
    return image;
}

+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize
{
    UIImage *image = [self imageFromView:view];
    if ([view bounds].size.width != newSize.width ||
        [view bounds].size.height != newSize.height) {
        image = [self imageWithImage:image scaledToSize:newSize];
    }
    return image;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    [self beginImageContextWithSize:newSize];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    return newImage;
}

- (UIImage *)thumbWithSideOfLength:(CGFloat)length
{
    
    NSString *subdir = @"my/images/directory";
    NSString *filename = @"myOriginalImage.png";
    NSString *fullPathToThumbImage = [subdir stringByAppendingPathComponent:[NSString stringWithFormat:@"%dx%d%@",(int) length, (int) length,filename]];
  
    NSString *fullPathToMainImage = [subdir stringByAppendingPathComponent:filename];
  
    UIImage *thumbnail;
  
    NSFileManager *fileManager = [NSFileManager defaultManager];
  
    if ([fileManager fileExistsAtPath:fullPathToThumbImage] == YES) {
      thumbnail = [UIImage imageWithContentsOfFile:fullPathToThumbImage];
      
    }else {
      //couldn’t find a previously created thumb image so create one first…
      UIImage *mainImage = [UIImage imageWithContentsOfFile:fullPathToMainImage];
      
      UIImageView *mainImageView = [[UIImageView alloc] initWithImage:mainImage];
      
      BOOL widthGreaterThanHeight = (mainImage.size.width > mainImage.size.height);
      float sideFull = (widthGreaterThanHeight) ? mainImage.size.height : mainImage.size.width;
      
      CGRect clippedRect = CGRectMake(0, 0, sideFull, sideFull);
      
      //creating a square context the size of the final image which we will then
      // manipulate and transform before drawing in the original image
      UIGraphicsBeginImageContext(CGSizeMake(length, length));
      CGContextRef currentContext = UIGraphicsGetCurrentContext();
      
      CGContextClipToRect( currentContext, clippedRect);
      
      CGFloat scaleFactor = length/sideFull;
      
      if (widthGreaterThanHeight) {
          //a landscape image – make context shift the original image to the left when drawn into the context
          CGContextTranslateCTM(currentContext, -((mainImage.size.width - sideFull) / 2) * scaleFactor, 0);
          
      }
      else {
          //a portfolio image – make context shift the original image upwards when drawn into the context
          CGContextTranslateCTM(currentContext, 0, -((mainImage.size.height - sideFull) / 2) * scaleFactor);
          
      }
      //this will automatically scale any CGImage down/up to the required thumbnail side (length) when the CGImage gets drawn into the context on the next line of code
      CGContextScaleCTM(currentContext, scaleFactor, scaleFactor);
      
      [mainImageView.layer renderInContext:currentContext];
      
      thumbnail = UIGraphicsGetImageFromCurrentImageContext();
      
      UIGraphicsEndImageContext();
      NSData *imageData = UIImagePNGRepresentation(thumbnail);
      
      [imageData writeToFile:fullPathToThumbImage atomically:YES];
      
      thumbnail = [UIImage imageWithContentsOfFile:fullPathToThumbImage];
  }
      return thumbnail;
}


@end

//
//  BGImaging.m
//
//  Created by Bren on 22/11/2012.
//  Copyright (c) 2012 Brengun. All rights reserved.
//

#import "BGImaging.h"

@implementation BGImaging

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageCroppedToSquare:(UIImage *)image withSize:(CGFloat)squareSize {
    
    // Get size of current image
    CGSize size = [image size];
    
    CGFloat minSize = size.height;
    if (size.height > size.width)
        minSize = size.width;
    
    // Create rectangle that represents a cropped image
    // from the middle of the existing image
    CGRect rect = CGRectMake(size.width / 2 - minSize / 2, size.height / 2 - minSize / 2,
                             minSize, minSize);
    
    // Create bitmap image from original image data,
    // using rectangle to specify desired crop area
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    img = [self imageWithImage:img scaledToSize:CGSizeMake(squareSize, squareSize)];
    
    return img;
}


+ (UIImage *)imageCroppedToSize:(UIImage *)image withSize:(CGSize)newSize {
    
    // Get size of current image
    CGSize size = [image size];
    CGFloat trimBit = (size.height - newSize.height);
    
    // Create rectangle that represents a cropped image
    // from the middle of the existing image
    CGRect rect = CGRectMake(0, trimBit, newSize.width * 2, newSize.height * 2);
    
    // Create bitmap image from original image data,
    // using rectangle to specify desired crop area
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    //img = [self imageWithImage:img scaledToSize:newSize];
    
    return img;
    
}

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight, BOOL top, BOOL bottom)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 0);
    
    NSLog(@"bottom? %d", bottom);
    
    if (top) {
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 3);
    } else {
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 0);
    }
    
    if (bottom) {
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 3);
    } else {
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 0);
    }
    
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 0);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage *)roundCornersOfImage:(UIImage *)source roundTop:(BOOL)top roundBottom:(BOOL)bottom {
    //int w = source.size.width;
    //int h = source.size.height;
    int w = 110.0;
    int h = 110.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, rect, 4, 4, top, bottom);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), source.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
}

+ (UIImage *)roundImage:(UIImage *)source {
    int w = source.size.width;
    int h = source.size.height;
    //int w = 110.0;
    //int h = 110.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, rect, source.size.width / 2, source.size.height / 2, YES, YES);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), source.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
}

@end

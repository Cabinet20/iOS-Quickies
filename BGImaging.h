//
//  BGImaging.h
//
//  Created by Bren on 22/11/2012.
//  Copyright (c) 2012 Brengun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BGImaging : NSObject

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageCroppedToSquare:(UIImage *)image withSize:(CGFloat)squareSize;
+ (UIImage *)imageCroppedToSize:(UIImage *)image withSize:(CGSize)newSize;
+ (UIImage *)roundCornersOfImage:(UIImage *)source roundTop:(BOOL)top roundBottom:(BOOL)bottom;

+ (UIImage *)roundImage:(UIImage *)source;

@end

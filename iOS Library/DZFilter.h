//
//  DZFilter.h
//  Showcase
//
//  Created by Weinkauff Jan on 16.11.11.
//  Copyright (c) 2011 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 50000

@interface DZFilter : NSObject

// Effects
+ (UIImage *)embossImageFromImage:(UIImage *)image;

+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image radius:(int)radius;
+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image width:(int)width height:(int)height;
+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image radius:(int16_t)radius iterations:(int16_t)iterations;
+ (UIImage *)gaussianBlur3ImageFromImage:(UIImage *)image;
+ (UIImage *)gaussianBlur5ImageFromImage:(UIImage *)image;
+ (UIImage *)gaussianBlur7ImageFromImage:(UIImage *)image;
+ (UIImage *)gaussianBlur9ImageFromImage:(UIImage *)image;
+ (UIImage *)gaussianBlur11ImageFromImage:(UIImage *)image iterations:(int)iterations;

+ (UIImage *)edgeDetectionImageFromImage:(UIImage *)image;
+ (UIImage *)sharpenImageFromImage:(UIImage *)image;

@end

#endif
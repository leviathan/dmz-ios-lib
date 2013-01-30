//
//  DZFilter.m
//  Showcase
//
//  Created by Weinkauff Jan on 16.11.11.
//  Copyright (c) 2011 Dreimannzelt. All rights reserved.
//

#import "DZFilter.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 50000

#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>


CGContextRef __CreateARGBBitmapContext (CGImageRef inImage);


@interface DZFilter ()

// Processing
+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor;
+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor flags:(vImage_Flags)flags;
+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor iterations:(int)iterations;
+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor flags:(vImage_Flags)flags iterations:(int)iterations;

// Helper
+ (void)logTypeOfBitmapInfo:(CGBitmapInfo)info;
+ (void)logDescriptionForvImageError:(vImage_Error)err;
+ (UIImage *)imageFromPixelData:(void *)outData 
                          width:(size_t)w 
                         height:(size_t)h 
               bitsPerComponent:(size_t)bitsPerComponent 
                   bitsPerPixel:(size_t)bitsPerPixel 
                    bytesPerRow:(size_t)bytesPerRow 
                     colorSpace:(CGColorSpaceRef)colorSpace 
                     bitmapInfo:(CGBitmapInfo)info
           colorRenderingIntent:(CGColorRenderingIntent)intent;

@end


@implementation DZFilter

#pragma mark - Effects

+ (UIImage *)embossImageFromImage:(UIImage *)image {
    int16_t kernel[9] = { -2, -2, 0, 
                          -2,  6, 0, 
                           0,  0, 0 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:3 kernelHeight:3 divisor:1];
}

+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image radius:(int)radius {
    if (radius % 2 == 0)
        return [self gaussianBlurImageFromImage:image width:radius+1 height:radius+1];
    return [self gaussianBlurImageFromImage:image width:radius height:radius];
}

+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image width:(int)width height:(int)height {
    // Create buffers for Accelerate
    CGImageRef cRef = CGImageRetain(image.CGImage);
    size_t w = CGImageGetWidth(cRef);
    size_t h = CGImageGetHeight(cRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(cRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(cRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(cRef);
    size_t numberOfBytes = bytesPerRow * h;
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cRef);
    CGBitmapInfo info = CGImageGetBitmapInfo(cRef);
            
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(cRef));
    UInt8 *pixelData = (UInt8 *)CFDataGetBytePtr(imageData);
    
    void* inData = pixelData;
    void* outData = malloc(numberOfBytes * sizeof(UInt8));
    
    vImage_Buffer src = { (void *)inData, h, w, bytesPerRow };
    vImage_Buffer dest = { (void *)outData, h, w, bytesPerRow };
    unsigned char bgColor[4] = { 0, 0, 0, 0 };
    
    // Do convolve
    vImageTentConvolve_ARGB8888(&src, &dest, NULL, 0, 0, width, height, bgColor, kvImageBackgroundColorFill);
    
    // Create new UIImage
    UIImage *resultImage = [self imageFromPixelData:outData
                                              width:w 
                                             height:h 
                                   bitsPerComponent:bitsPerComponent 
                                       bitsPerPixel:bitsPerPixel 
                                        bytesPerRow:bytesPerRow 
                                         colorSpace:colorSpace 
                                         bitmapInfo:info
                               colorRenderingIntent:CGImageGetRenderingIntent(cRef)];
    // Cleanup
    CGImageRelease(cRef);
    free(outData);
    CFRelease(imageData);
    
    return resultImage;
}

+ (UIImage *)gaussianBlurImageFromImage:(UIImage *)image radius:(int16_t)radius iterations:(int16_t)iterations {
    int16_t *kernel = malloc(radius*radius*sizeof(int16_t));
    
    int index = 0;
    int limit = (radius / 2) + 1;
    int divisor = pow(2, radius-1) * 9;
    for (int y=0; y < radius; y++) {
        for (int x=0; x < radius; x++) {
            if (y < limit)
                if (x < limit)    
                    kernel[index++] = pow(2, y+x);
                else
                    kernel[index++] = pow(2, y+(radius-1-x));
            else
                if (x < limit)
                    kernel[index++] = pow(2, (radius-1-y)+x);
                else
                    kernel[index++] = pow(2, (radius-1-y)+(radius-1-x));
        }
    }
    
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:radius kernelHeight:radius divisor:divisor iterations:iterations];
}


+ (UIImage *)gaussianBlur3ImageFromImage:(UIImage *)image {
    int16_t kernel[9] = { 1, 2, 1, 
                          2, 4, 2, 
                          1, 2, 1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:3 kernelHeight:3 divisor:16];
}

+ (UIImage *)gaussianBlur5ImageFromImage:(UIImage *)image {
    int16_t kernel[25] = { 1, 2,  4, 2, 1, 
                           2, 4,  8, 4, 2, 
                           4, 8, 16, 8, 2, 
                           2, 4,  8, 4, 2, 
                           1, 2,  4, 2, 1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:5 kernelHeight:5 divisor:100]; 
}

+ (UIImage *)gaussianBlur7ImageFromImage:(UIImage *)image {
    int16_t kernel[49] = { 1,  2,  4,  8,  4,  2, 1, 
                           2,  4,  8, 16,  8,  4, 2, 
                           4,  8, 16, 32, 16,  8, 4, 
                           8, 16, 32, 64, 32, 16, 8, 
                           4,  8, 16, 32, 16,  8, 4, 
                           2,  4,  8, 16,  8,  4, 2, 
                           1,  2,  4,  8,  4,  2, 1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:7 kernelHeight:7 divisor:500];  
}

+ (UIImage *)gaussianBlur9ImageFromImage:(UIImage *)image {
    int16_t kernel[81] = {   1,  2,  4,   8,  16,   8,  4,  2,  1,
                             2,  4,  8,  16,  32,  16,  8,  4,  2,
                             4,  8, 16,  32,  64,  32, 16,  8,  4,
                             8, 16, 32,  64, 128,  64, 32, 16,  8,
                            16, 32, 64, 128, 256, 128, 64, 32, 16,
                             8, 16, 32,  64, 128,  64, 32, 16,  8,
                             4,  8, 16,  32,  64,  32, 16,  8,  4,
                             2,  4,  8,  16,  32,  16,  8,  4,  2,
                             1,  2,  4,   8,  16,   8,  4,  2,  1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:9 kernelHeight:9 divisor:2304]; 
}

+ (UIImage *)gaussianBlur11ImageFromImage:(UIImage *)image iterations:(int)iterations {
    int16_t kernel[121] = {   1,  2,   4,   8,  16,   32,  16,   8,  4,  2,  1,
                              2,  4,   8,  16,  32,   64,  32,  16,  8,  4,  2,
                              4,  8,  16,  32,  64,  128,  64,  32, 16,  8,  4,
                              8, 16,  32,  64, 128,  256, 128,  64, 32, 16,  8,
                             16, 32,  64, 128, 256,  512, 256, 128, 64, 32, 16,
                             32, 64, 128, 256, 512, 1024, 512, 256, 128, 64, 32,
                             16, 32,  64, 128, 256,  512, 256, 128, 64, 32, 16,
                              8, 16,  32,  64, 128,  256, 128,  64, 32, 16,  8,
                              4,  8,  16,  32,  64,  128,  64,  32, 16,  8,  4,
                              2,  4,   8,  16,  32,   64,  32,  16,  8,  4,  2,
                              1,  2,   4,   8,  16,   32,  16,   8,  4,  2,  1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:11 kernelHeight:11 divisor:9216 iterations:iterations];
}


+ (UIImage *)edgeDetectionImageFromImage:(UIImage *)image {
    int16_t kernel[9] = { -1, -1, -1, 
                           0,  0,  0, 
                           1,  1,  1 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:3 kernelHeight:3 divisor:1];
}

+ (UIImage *)sharpenImageFromImage:(UIImage *)image {
    int16_t kernel[9] = {  0, -1, 0, 
                          -1,  5, -1, 
                           0, -1, 0 };
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:3 kernelHeight:3 divisor:1];
}


#pragma mark - Processing

+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor {
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:kernelWidth kernelHeight:kernelHeight divisor:divisor flags:kvImageBackgroundColorFill iterations:0]; 
}

+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor flags:(vImage_Flags)flags {
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:kernelWidth kernelHeight:kernelHeight divisor:divisor flags:flags iterations:0]; 
}

+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor iterations:(int)iterations {
    return [self convolveImageFromImage:image kernel:kernel kernelWidth:kernelWidth kernelHeight:kernelHeight divisor:divisor flags:kvImageBackgroundColorFill iterations:iterations]; 
}

+ (UIImage *)convolveImageFromImage:(UIImage *)image kernel:(int16_t *)kernel kernelWidth:(uint32_t)kernelWidth kernelHeight:(uint32_t)kernelHeight divisor:(int)divisor flags:(vImage_Flags)flags iterations:(int)iterations {
    // Create buffers for Accelerate
    CGImageRef cRef = CGImageRetain(image.CGImage);
    size_t w = CGImageGetWidth(cRef);
    size_t h = CGImageGetHeight(cRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(cRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(cRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(cRef);
    size_t numberOfBytes = bytesPerRow * h;
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cRef);
    CGBitmapInfo info = CGImageGetBitmapInfo(cRef);
        
    [self logTypeOfBitmapInfo:info];
    
    /*
    CGContextRef cgctx = __CreateARGBBitmapContext(cRef);
    CGRect rect = {{0,0},{w,h}}; 
    CGContextDrawImage(cgctx, rect, cRef);     
    UInt8 *pixelData = CGBitmapContextGetData(cgctx);*/
    
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(cRef));
    UInt8 *pixelData = (UInt8 *)CFDataGetBytePtr(imageData);
    
    void* inData = pixelData;
    void* outData = malloc(numberOfBytes * sizeof(UInt8));
    
    vImage_Buffer src = { (void *)inData, h, w, bytesPerRow };
    vImage_Buffer dest = { (void *)outData, h, w, bytesPerRow };
    unsigned char bgColor[4] = { 0, 0, 0, 0 };
    
    // Do convolve
    vImage_Error err = vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, kernel, kernelWidth, kernelHeight, divisor, bgColor, flags);
    for (int i=0; i < iterations; i++)
        err = vImageConvolve_ARGB8888(&dest, &dest, NULL, 0, 0, kernel, kernelWidth, kernelHeight, divisor, bgColor, flags);        

    [self logDescriptionForvImageError:err];
    
    // Create new UIImage
    UIImage *resultImage = [self imageFromPixelData:outData
                                              width:w 
                                             height:h 
                                   bitsPerComponent:bitsPerComponent 
                                       bitsPerPixel:bitsPerPixel 
                                        bytesPerRow:bytesPerRow 
                                         colorSpace:colorSpace 
                                         bitmapInfo:info
                               colorRenderingIntent:CGImageGetRenderingIntent(cRef)];
    // Cleanup
    CGImageRelease(cRef);
    free(outData);
    CFRelease(imageData);
    
    return resultImage;
}

#pragma mark - Helper

+ (void)logTypeOfBitmapInfo:(CGBitmapInfo)info {
    if (info == kCGBitmapAlphaInfoMask)
        NSLog(@"kCGBitmapAlphaInfoMask");
    else if (info == kCGBitmapFloatComponents)
        NSLog(@"kCGBitmapFloatComponents");
    else if (info == kCGBitmapByteOrderMask)
        NSLog(@"kCGBitmapByteOrderMask");
    else if (info == kCGBitmapByteOrderDefault)
        NSLog(@"kCGBitmapByteOrderDefault");
    else if (info == kCGBitmapByteOrder16Little)
        NSLog(@"kCGBitmapByteOrder16Little");
    else if (info == kCGBitmapByteOrder32Little)
        NSLog(@"kCGBitmapByteOrder32Little");
    else if (info == kCGBitmapByteOrder16Big)
        NSLog(@"kCGBitmapByteOrder16Big");
    else if (info == kCGBitmapByteOrder32Big)
        NSLog(@"kCGBitmapByteOrder32Big");
    else
        NSLog(@"%d", info);
}


+ (void)logDescriptionForvImageError:(vImage_Error)err {
    if (err == kvImageRoiLargerThanInputBuffer)
        NSLog(@"kvImageRoiLargerThanInputBuffer");
    else if (err == kvImageInvalidKernelSize)
        NSLog(@"kvImageInvalidKernelSize");
    else if (err == kvImageInvalidEdgeStyle)
        NSLog(@"kvImageInvalidEdgeStyle");
    else if (err == kvImageInvalidOffset_X)
        NSLog(@"kvImageInvalidOffset_X");
    else if (err == kvImageInvalidOffset_Y)
        NSLog(@"kvImageInvalidOffset_Y");
    else if (err == kvImageMemoryAllocationError)
        NSLog(@"kvImageMemoryAllocationError");
    else if (err == kvImageNullPointerArgument)
        NSLog(@"kvImageNullPointerArgument");
    else if (err == kvImageInvalidParameter)
        NSLog(@"kvImageInvalidParameter");
    else if (err == kvImageBufferSizeMismatch)
        NSLog(@"kvImageBufferSizeMismatch");
    else if (err == kvImageUnknownFlagsBit)
        NSLog(@"kvImageUnknownFlagsBit");
}


+ (UIImage *)imageFromPixelData:(void *)outData 
                          width:(size_t)w 
                         height:(size_t)h 
               bitsPerComponent:(size_t)bitsPerComponent 
                   bitsPerPixel:(size_t)bitsPerPixel 
                    bytesPerRow:(size_t)bytesPerRow 
                     colorSpace:(CGColorSpaceRef)colorSpace 
                     bitmapInfo:(CGBitmapInfo)info
           colorRenderingIntent:(CGColorRenderingIntent)intent {
    CFDataRef imgData = (CFDataRef)[NSData dataWithBytes:outData length:bytesPerRow * h];
    CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData(imgData);
    
    CGImageRef throughCGImage = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, info, imgDataProvider, NULL, NO, intent);
    CGDataProviderRelease(imgDataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:throughCGImage];
    CGImageRelease(throughCGImage);
    
    return resultImage;
}

@end


CGContextRef __CreateARGBBitmapContext (CGImageRef inImage) {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) 
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits 
    // per component. Regardless of what the source image format is 
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );   
    return context;
}

#endif

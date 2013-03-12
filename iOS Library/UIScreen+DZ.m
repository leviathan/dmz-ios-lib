//
//  UIScreen+DZ.m
//  DMZ-iOS-Library
//
//  Created by Jörg Polakowski on 12/03/13.
//

#import <CoreGraphics/CoreGraphics.h>
#import "UIScreen+DZ.h"

@implementation UIScreen (DZ)

+ (CGSize)appFrameSize {
    return [UIScreen mainScreen].applicationFrame.size;
}

+ (CGFloat)screenWidth {
    return [UIScreen appFrameSize].width;
}

+ (CGFloat)screenHeight {
    return [UIScreen appFrameSize].height;
}

@end

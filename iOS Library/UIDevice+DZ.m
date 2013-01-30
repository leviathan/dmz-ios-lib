//
//  UIDevice+DZ.m
//  DMZ iOS Library
//
//  Created by Weinkauff Jan on 07.11.11.
//  Copyright (c) 2011 Dreimannzelt. All rights reserved.
//

#import "UIDevice+DZ.h"


@implementation UIDevice (DZ)

+ (BOOL)isPhone {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isPad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;    
}

+ (NSString *)typeName {
    if ([self isPad])
        return @"Pad";
    if ([self isPhone])
        return @"Phone";
    return nil;
}

@end

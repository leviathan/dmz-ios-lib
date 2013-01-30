//
//  UIBarButtonItem+DZ.m
//  DMZ iOS Library
//
//  Created by Weinkauff Jan on 27.06.12.
//  Copyright (c) 2012 Dreimannzelt. All rights reserved.
//

#import "UIBarButtonItem+DZ.h"


@implementation UIBarButtonItem (DZ)

+ (UIBarButtonItem *)flexible {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end

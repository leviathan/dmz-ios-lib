//
//  UIViewController+DZ.m
//
//  Created by Weinkauff Jan on 23.09.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import "UIViewController+DZ.h"

@implementation UIViewController (UIViewController_DZ)

+ (id)viewController {
    return [[[[self class] alloc] init] autorelease];
}

@end

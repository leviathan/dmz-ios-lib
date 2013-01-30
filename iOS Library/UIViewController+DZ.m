//
//  UIViewController+DZ.m
//  DMZ iOS Library
//
//  Created by Weinkauff Jan on 23.09.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import "UIViewController+DZ.h"


@implementation UIViewController (UIViewController_DZ)

#pragma mark - Factory

+ (id)viewController {
    return [[[[self class] alloc] init] autorelease];
}

#pragma mark - Storyboard

- (id)viewControllerFromStoryboardWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (id)viewControllerFromStoryboard:(NSString *)storyboardName withIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}


@end

//
//  UIViewController+DZ.h
//
//  Created by Weinkauff Jan on 23.09.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (UIViewController_DZ)

// Factory
+ (id)viewController;

// Storyboard
- (id)viewControllerFromStoryboardWithIdentifier:(NSString *)identifier;
- (id)viewControllerFromStoryboard:(NSString *)storyboardName withIdentifier:(NSString *)identifier;

@end

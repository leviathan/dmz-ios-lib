//
//  UIButton+DZ.h
//  DMZ-iOS-Library
//
//  Created by Jörg Polakowski on 21/03/13.
//  Copyright (c) 2013 Jörg Polakowski. All rights reserved.
//

#define kUIButtonBlockTouchUpInside @"TouchInside"

#import <UIKit/UIKit.h>

@interface UIButton (DZ)

@property(nonatomic, strong) NSMutableDictionary *actions;

- (void)setAction:(NSString *)action withBlock:(void (^)())block;

@end

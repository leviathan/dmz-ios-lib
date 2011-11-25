//
//  UIDevice+DZ.h
//  MAGAZIN
//
//  Created by Weinkauff Jan on 07.11.11.
//  Copyright (c) 2011 Dreimannzelt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIDevice (DZ)

+ (BOOL)isPhone;
+ (BOOL)isPad;
+ (NSString *)typeName;

@end

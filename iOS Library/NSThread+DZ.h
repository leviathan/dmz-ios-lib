//
//  NSThread+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 30.07.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSThread (DZ)
	- (void)performBlock:(void (^)())block;
	- (void)performBlock:(void (^)())block waitUntilDone:(BOOL)wait;
	+ (void)performBlockInBackground:(void (^)())block;
@end

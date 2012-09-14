//
//  NSObject+DZ.h
//  de.dreimannzelt.addition.ios
//
//  Created by Jan Weinkauff on 16.04.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface NSObject (DZ)
	/**
	 * Helper to check if a object responds to a message and performs this message on that object.
	 */
	- (id)ifRespondsPerformSelector:(SEL)selector;
	- (id)ifRespondsPerformSelector:(SEL)selector withObject:(id)firstObject;

    - (void)performBlockOnMainThread:(void (^)(void))block;
@end

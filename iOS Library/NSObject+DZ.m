//
//  NSObject+DZ.h
//  de.dreimannzelt.addition.ios
//
//  Created by Jan Weinkauff on 16.04.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import "NSObject+DZ.h"


@implementation NSObject (DZ)

#pragma mark -
#pragma mark Message dispatching

- (id)ifRespondsPerformSelector:(SEL)selector {
	if ([self respondsToSelector:selector])
		return [self performSelector:selector];
	return nil;
}

- (id)ifRespondsPerformSelector:(SEL)selector withObject:(id)firstObject {
	if ([self respondsToSelector:selector])
		return [self performSelector:selector withObject:firstObject];
	return nil;
}

@end

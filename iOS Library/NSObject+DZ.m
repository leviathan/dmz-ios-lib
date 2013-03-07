//
//  NSObject+DZ.h
//  DMZ iOS Library
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

- (void)performBlockOnMainThread:(void (^)(void))block {
    block = [[block copy] autorelease];
    [self performSelectorOnMainThread:@selector(fireBlock:) withObject:block waitUntilDone:NO];
}

- (void)fireBlock:(void (^)(void))block {
    block();
}

#pragma mark -
#pragma mark Class

- (NSString *)getClassName {
    return [NSString stringWithFormat:@"%s", class_getName([self class])];
}

@end

//
//  NSThread+DZ.m
//  de.dreimannzelt.addition.ios
//
//  Created by Jan Weinkauff on 30.07.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import "NSThread+DZ.h"


@implementation NSThread (DZ)

- (void)performBlock:(void (^)())block {
	if ([[NSThread currentThread] isEqual:self])
		block();
	else
		[self performBlock:block waitUntilDone:NO];
}

- (void)performBlock:(void (^)())block waitUntilDone:(BOOL)wait {
    [NSThread performSelector:@selector(ng_runBlock:)
                     onThread:self
                   withObject:[[block copy] autorelease]
                waitUntilDone:wait];
}

+ (void)ng_runBlock:(void (^)())block {
	block();
}

+ (void)performBlockInBackground:(void (^)())block {
	[NSThread performSelectorInBackground:@selector(ng_runBlock:)withObject:[[block copy] autorelease]];
}

@end
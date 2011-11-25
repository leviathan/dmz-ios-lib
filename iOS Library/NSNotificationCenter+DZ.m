//
//  NSNotificationCenter+DZ.m
//  de.dreimannzelt.additions.ios
//
//  Created by Jan Weinkauff on 21.05.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import "NSNotificationCenter+DZ.h"


@implementation NSNotificationCenter (DZ)

#pragma mark -
#pragma mark Main Thread

- (void)postNotificationOnMainThread:(NSNotification *)notification
{
	[self performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:YES];
}

- (void)postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject
{
	NSNotification *notification = [NSNotification notificationWithName:aName object:anObject];
	[self postNotificationOnMainThread:notification];
}

- (void)postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
	NSNotification *notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo];
	[self postNotificationOnMainThread:notification];
}

@end

//
//  NSNotificationCenter+DZ.h
//  de.dreimannzelt.additions.ios
//
//  Created by Jan Weinkauff on 21.05.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNotificationCenter (DZ)
	// Main Thread
	- (void)postNotificationOnMainThread:(NSNotification *)notification;
	- (void)postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject;
	- (void)postNotificationOnMainThreadName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;
@end

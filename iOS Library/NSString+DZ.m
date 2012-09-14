//
//  NSString+DZ.m
//  de.unique-holding.kapillaris.ipad
//
//  Created by Jan Weinkauff on 15.02.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import "NSString+DZ.h"


@implementation NSString (DZ)

#pragma mark - State

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return ![self isEmpty];
}

- (BOOL)isNumeric {
	NSNumberFormatter* numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	NSNumber *number = [numberFormatter numberFromString:self];
	return (number != nil);
}

#pragma mark - Searching

- (BOOL)containsSubstring:(NSString *)substring {
    NSRange textRange = [self rangeOfString:substring options:NSCaseInsensitiveSearch];
    return textRange.location != NSNotFound;
}

@end

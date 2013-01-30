//
//  NSArray+DZ.m
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 16.04.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import "NSArray+DZ.h"


NSInteger alphabeticSort(id string1, id string2, void *reverse);

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if ((NSInteger *)reverse == NO) {
        return [string2 localizedCaseInsensitiveCompare:string1];
    }
    return [string1 localizedCaseInsensitiveCompare:string2];
}


@implementation NSArray (DZ)

- (BOOL)isEmpty
{
	return [self count] <= 0;
}

- (BOOL)isNotEmpty
{
	return ![self isEmpty];
}

- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

- (NSArray *)alphabeticSortedArray:(BOOL)ascending
{
	return [self sortedArrayUsingFunction:alphabeticSort context:&ascending];
}

@end

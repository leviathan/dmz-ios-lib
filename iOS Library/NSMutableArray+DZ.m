//
//  NSMutableArray+DZ.m
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 17.02.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import "NSMutableArray+DZ.h"
#import "DZMacros.h"


@implementation NSMutableArray (DZ)

- (void)sortByKey:(NSString *)key ascending:(BOOL)ascending {
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key ascending:ascending] autorelease];
    [self sortUsingDescriptors:$A(sortDescriptor)];
}

@end

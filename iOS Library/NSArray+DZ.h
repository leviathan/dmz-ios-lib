//
//  NSArray+DZ.h
//  de.dreimannzelt.additions.ios
//
//  Created by Jan Weinkauff on 16.04.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (DZ)

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
	
- (NSArray *)reversedArray;
	
- (NSArray *)alphabeticSortedArray:(BOOL)ascending;

@end

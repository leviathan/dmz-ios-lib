//
//  NSString+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 15.02.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (DZ)

// State
- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
- (BOOL)isNumeric;

// Searching
- (BOOL)containsSubstring:(NSString *)substring;

@end

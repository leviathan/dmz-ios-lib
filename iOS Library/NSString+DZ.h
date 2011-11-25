//
//  NSString+DZ.h
//  de.unique-holding.kapillaris.ipad
//
//  Created by Jan Weinkauff on 15.02.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (DZ)

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
- (BOOL)containsSubstring:(NSString *)substring;

@end

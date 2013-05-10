//
// Created by Jörg Polakowski on 10/05/13.
//

#import <Foundation/Foundation.h>

@interface NSNull (DZ)

/**
* Returns the <id> casted return value of [NSNull null].
*
* The <id> can be used for comparing NSNull with other values, e.g.
* aString != [NSNull idNull]
*/
+ (id)idNull;

@end
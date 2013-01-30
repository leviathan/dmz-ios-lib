//
//  NSLocale+DZ.m
//  DMZ iOS Library
//
//  Created by Weinkauff Jan on 09.11.11.
//  Copyright (c) 2011 Dreimannzelt. All rights reserved.
//

#import "NSLocale+DZ.h"


@implementation NSLocale (DZ)

+ (NSString *)currentLanguage {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

+ (BOOL)isGerman {
    return [[self currentLanguage] isEqualToString:@"de"];
}

+ (BOOL)isEnglish {
    return [[self currentLanguage] isEqualToString:@"en"];
}

@end

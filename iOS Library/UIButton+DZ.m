//
//  UIButton+DZ.m
//  DMZ-iOS-Library
//
//  Created by Jörg Polakowski on 21/03/13.
//  Copyright (c) 2013 Jörg Polakowski. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+DZ.h"

@implementation UIButton (DZ)

static char overviewKey;

@dynamic actions;

- (void)setAction:(NSString *)action withBlock:(void (^)())block {

    if ([self actions] == nil) {
        [self setActions:[[[NSMutableDictionary alloc] init] autorelease]];
    }

    [[self actions] setObject:block forKey:action];

    if ([kUIButtonBlockTouchUpInside isEqualToString:action]) {
        [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setActions:(NSMutableDictionary *)actions {
    objc_setAssociatedObject(self, &overviewKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)actions {
    return objc_getAssociatedObject(self, &overviewKey);
}

- (void)doTouchUpInside:(id)sender {
    void(^block)();
    block = [[self actions] objectForKey:kUIButtonBlockTouchUpInside];
    block();
}

@end
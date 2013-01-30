//
//  NSURL+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 30.07.10.
//  Copyright (c) 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURL (DZ)

/**
 * Creates an URL based of protocol, host, path and a parameter string.
 */
+ (NSURL *)URLWithProtocol:(NSString *)protocol host:(NSString *)host path:(NSString *)path parameterString:(NSString *)parameterString;

/**
 * Creates an URL based of protocol, host, path and a parameters.
 */
+ (NSURL *)URLWithProtocol:(NSString *)protocol host:(NSString *)host path:(NSString *)path parameters:(NSDictionary *)parameters;

@end

//
//  NSURL+DZ.m
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 30.07.10.
//  Copyright (c) 2010 Dreimannzelt. All rights reserved.
//

#import "NSURL+DZ.h"


@implementation NSURL (DZ)

+ (NSURL *)URLWithProtocol:(NSString *)protocol host:(NSString *)host path:(NSString *)path parameterString:(NSString *)parameterString {
	NSString *str = nil;
	if (parameterString)
		str = [NSString stringWithFormat:@"%@://%@%@?%@", protocol, host, path, parameterString];
	else
		str = [NSString stringWithFormat:@"%@://%@%@", protocol, host, path];
	return [NSURL URLWithString:str];
}

+ (NSURL *)URLWithProtocol:(NSString *)protocol host:(NSString *)host path:(NSString *)path parameters:(NSDictionary *)parameters {
	NSMutableString *str = [NSMutableString string];
	for (id key in parameters)
		[str appendFormat:@"%@=%@", key, [parameters objectForKey:key]];
	return [NSURL URLWithProtocol:protocol host:host path:path parameterString:str];
}

@end

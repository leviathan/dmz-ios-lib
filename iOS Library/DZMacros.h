//
//  DZMacros.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 30.07.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

// Time constants

#define DZ_MINUTE   60
#define DZ_HOUR     (60 * DZ_MINUTE)
#define DZ_DAY      (24 * DZ_HOUR)
#define DZ_5_DAYS   (5 * DZ_DAY)
#define DZ_WEEK     (7 * DZ_DAY)
#define DZ_MONTH    (30 * DZ_DAY)
#define DZ_YEAR     (365 * DZ_DAY)

// Math

#define RADIANS(degrees) degrees / 57.2958f

// Cleanup
#define DZ_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define DZ_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }

// Shortcuts
#define $D(...) [NSDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define $MD(...) [NSMutableDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define $A(...) [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define $MA(...) [NSMutableArray arrayWithObjects: __VA_ARGS__, nil]
#define $S(format, ...) [NSString stringWithFormat:format, ## __VA_ARGS__]
#define $I(i) [NSNumber numberWithInt:i]
#define $F(f) [NSNumber numberWithFloat:f]
#define $B(b) ((b) ? (id)kCFBooleanTrue : (id)kCFBooleanFalse)
#define $URL(url) [NSURL URLWithString:url]
#define $LS(string) NSLocalizedString(string, nil)
#define $IMG(name) [UIImage imageNamed:name]

// Singleton

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)sharedInstance \
{ \
	@synchronized(self) { \
		if (shared##classname == nil) { \
			shared##classname = [[self alloc] init]; \
		} \
	} \
	\
	return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
	@synchronized(self) { \
		if (shared##classname == nil) { \
			shared##classname = [super allocWithZone:zone]; \
			return shared##classname; \
		} \
	} \
	\
	return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
	return self; \
} \
\
- (id)retain { \
	return self; \
} \
\
- (NSUInteger)retainCount { \
	return NSUIntegerMax; \
} \
\
- (void)release { \
} \
\
- (id)autorelease { \
	return self; \
}


#if defined(DEBUG) || defined(TEST) 
	#define DZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
	#define DZLog(fmt, ...)
#endif

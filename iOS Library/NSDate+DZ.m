//
//  NSDate+DZ.m
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 16.05.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import "NSDate+DZ.h"


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926


#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@implementation NSDate (DZ)

#pragma mark - Date components

- (NSInteger)nearestHour {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return [components hour];
}

- (NSInteger)hour {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components hour];
}

- (NSInteger)minute {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components minute];
}

- (NSInteger)seconds {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components second];
}

- (NSInteger)day {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components day];
}

- (NSInteger)month {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components month];
}

- (NSInteger)week {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components week];
}

- (NSInteger)weekday {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekday];
}

- (NSInteger)nthWeekday {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekdayOrdinal];
}

- (NSInteger)year {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components year];
}

#pragma mark - Formatting

- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:format];
	return [formatter stringFromDate:self];
}

#pragma mark - Compare

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    if ([date compare:endDate] == NSOrderedDescending) 
        return NO;
    return YES;
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

+ (NSDate *)today {
    return [NSDate date];
}

- (BOOL)isToday {
	return [self isEqualToDateIgnoringTime:[NSDate today]];
}

- (BOOL)isTomorrow {
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate: (NSDate *) aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if ([components1 week] != [components2 week]) return NO;
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)isThisWeek {
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameYearAsDate:newDate];
}

- (BOOL)isLastWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameYearAsDate:newDate];
}

- (BOOL)isSameYearAsDate: (NSDate *) aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return ([components1 year] == [components2 year]);
}

- (BOOL)isThisYear {
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)isLastYear {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate {
	return ([self earlierDate:aDate] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
	return ([self laterDate:aDate] == self);
}

#pragma mark - Create dates

+ (NSDate *)dateForDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year hour:(NSInteger)hour minute:(NSInteger)minute {
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setDay:day];
	[comps setMonth:month];
	[comps setYear:year];
	[comps setMinute:minute];
	[comps setHour:hour];
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateFromComponents:comps];
}

+ (NSDate *)timeForHour:(NSInteger)hour minute:(NSInteger)minute {
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setMinute:minute];
	[comps setHour:hour];
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateFromComponents:comps];
}

+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)dateTomorrow {
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSUInteger)dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *)dateAtBeginningOfMonth {
    return [NSDate dateWithDaysBeforeNow:[[NSDate today] day]-1];
}

+ (NSDate *)dateAtEndOfMonth {
    NSDate *today = [NSDate today];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange dateRange = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate today]];
    NSUInteger numberOfDaysInMonth = dateRange.length;
    
    return [NSDate dateForDay:numberOfDaysInMonth month:[today month] year:[today year] hour:0 minute:0];    
}

- (NSDate *)dateByAddingDays:(NSUInteger)dDays {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *)dateBySubtractingDays:(NSUInteger)dDays {
	return [self dateByAddingDays:(dDays * -1)];
}

- (NSDate *)dateByAddingHours:(NSUInteger)dHours {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *)dateBySubtractingHours:(NSUInteger)dHours {
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSUInteger)dMinutes {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *)dateBySubtractingMinutes:(NSUInteger)dMinutes {
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)dateAtStartOfDay {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate {
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark - Query

- (NSInteger)minutesAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger)(ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger)(ti / D_DAY);
}

- (NSInteger)differenceInDaysTo:(NSDate *)toDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                                fromDate:self
                                                  toDate:toDate
                                                 options:0];
    [gregorian release];
    return [components day];
}

#pragma mark - Rails


static NSDateFormatter *railsDateFormatter;

// parses rails server dates in the form of "2012-07-14T10:07:39Z"
// this is the standard DB format for rails dates - time zone is UTC / GMT
+ (NSDate *)dateFromRailsString:(NSString *)dateString {
    if (!railsDateFormatter) {
        // create a formatter for the rails time format : "2012-07-14T10:07:39Z"
        railsDateFormatter = [[NSDateFormatter alloc] init];
        
        // the locale needs to be set to prevent the formatter from doing something stupid in case the user has set their
        // calendar to be the Mayan Lunar calendar.
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [railsDateFormatter setLocale:locale];
        
        // set time zone to GMT
        [railsDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        // finally set the format
        // Note: Note that both the T and the Z are in quotes, meaning they'll be ignored - they're not part of the pattern
        [railsDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    }
    return [railsDateFormatter dateFromString:dateString];
}

- (NSString *)railsDate {
    // get the serverDateFormat in an initial transaction with the server
    // or, simpler and more brittle, hardcode something like the following ...
    NSString *serverDateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    
    // prepare a date formatter.  i allocate and hang onto this at init, but
    // you can just do this inline to get started...
    NSDateFormatter *_railsDateFormatter = [[NSDateFormatter alloc] init];
    [_railsDateFormatter setDateFormat:serverDateFormat];
    [_railsDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    // this is in a category method on NSDate called asHttpParam, but the code
    // here works fine to get started. the following gets the date ready to pass to server...
    return [_railsDateFormatter stringFromDate:self];
}

@end

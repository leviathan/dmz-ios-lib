//
//  NSDate+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 16.05.10.
//  Copyright 2010 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (DZ)
	// Date components
	@property (readonly) NSInteger nearestHour;
	@property (readonly) NSInteger hour;
	@property (readonly) NSInteger minute;
	@property (readonly) NSInteger seconds;
	@property (readonly) NSInteger day;
	@property (readonly) NSInteger month;
	@property (readonly) NSInteger week;
	@property (readonly) NSInteger weekday;
	@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
	@property (readonly) NSInteger year;

	// Formatting
	- (NSString *)stringWithFormat:(NSString *)format;

	// Compare
	+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endTime;
    
    + (NSDate *)today;

	- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
	- (BOOL)isToday;
	- (BOOL)isTomorrow;
	- (BOOL)isYesterday;
	- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
	- (BOOL)isThisWeek;
	- (BOOL)isNextWeek;
	- (BOOL)isLastWeek;
	- (BOOL)isSameYearAsDate:(NSDate *)aDate;
	- (BOOL)isThisYear;
	- (BOOL)isNextYear;
	- (BOOL)isLastYear;
	- (BOOL)isEarlierThanDate:(NSDate *)aDate;
	- (BOOL)isLaterThanDate:(NSDate *)aDate;

	// Create dates
	+ (NSDate *)dateForDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year hour:(NSInteger)hour minute:(NSInteger)minute;
	+ (NSDate *)timeForHour:(NSInteger)hour minute:(NSInteger)minute;

	+ (NSDate *)dateTomorrow;
	+ (NSDate *)dateYesterday;
	+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days;
	+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days;
	+ (NSDate *)dateWithHoursFromNow:(NSUInteger)dHours;
	+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)dHours;
	+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)dMinutes;
	+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)dMinutes;
    + (NSDate *)dateAtBeginningOfMonth;
    + (NSDate *)dateAtEndOfMonth;

	- (NSDate *)dateByAddingDays:(NSUInteger)dDays;
	- (NSDate *)dateBySubtractingDays:(NSUInteger)dDays;
	- (NSDate *)dateByAddingHours:(NSUInteger)dHours;
	- (NSDate *)dateBySubtractingHours:(NSUInteger)dHours;
	- (NSDate *)dateByAddingMinutes:(NSUInteger)dMinutes;
	- (NSDate *)dateBySubtractingMinutes:(NSUInteger)dMinutes;
	- (NSDate *)dateAtStartOfDay;

	// Query
	- (NSInteger)minutesAfterDate:(NSDate *)aDate;
	- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
	- (NSInteger)hoursAfterDate:(NSDate *)aDate;
	- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
	- (NSInteger)daysAfterDate:(NSDate *)aDate;
	- (NSInteger)daysBeforeDate:(NSDate *)aDate;
	- (NSInteger)differenceInDaysTo:(NSDate *)toDate;
@end

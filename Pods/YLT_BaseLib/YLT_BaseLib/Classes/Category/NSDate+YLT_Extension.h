//
//  NSDate+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by 项普华 on 2018/4/9.
//

#import <Foundation/Foundation.h>

@interface NSDate (YLT_Extension)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)ylt_day;
- (NSUInteger)ylt_month;
- (NSUInteger)ylt_year;
- (NSUInteger)ylt_hour;
- (NSUInteger)ylt_minute;
- (NSUInteger)ylt_second;
+ (NSUInteger)ylt_day:(NSDate *)date;
+ (NSUInteger)ylt_month:(NSDate *)date;
+ (NSUInteger)ylt_year:(NSDate *)date;
+ (NSUInteger)ylt_hour:(NSDate *)date;
+ (NSUInteger)ylt_minute:(NSDate *)date;
+ (NSUInteger)ylt_second:(NSDate *)date;

/**
 * 获取格式化为 YYYY年MM月dd日 格式的日期字符串
 */
- (NSString *)ylt_formatMDWEEK;
- (NSString *)ylt_formatYMDHM;
- (NSString *)ylt_formatYMD;
- (NSString *)ylt_formatYMDHMLine;
- (NSString *)ylt_formatYMDWith:(NSString *)c;

- (NSString *)ylt_formatMD;
- (NSString *)ylt_formatM:(NSString *)m D:(NSString *)d;
- (NSString *)ylt_formatMDHM;
/** 获取 xx日xx时xx分xx秒 */
- (NSString *)ylt_formatD:(NSString *)d H:(NSString *)h M:(NSString *)m S:(NSString *)s;

- (NSString *)ylt_formatHM;
- (NSString *)ylt_formatWeekDay;

/**
 *  获取星期几
 */
- (NSInteger)ylt_week;
+ (NSInteger)ylt_week:(NSDate *)date;
- (NSInteger)ylt_weekday;
+ (NSInteger)ylt_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 */
- (NSString *)ylt_dayFromWeekday;
+ (NSString *)ylt_dayFromWeekday:(NSDate *)date;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)ylt_dateByAddingDays:(NSUInteger)days;

/**
 * 获取月份
 */
+ (NSString *)ylt_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)ylt_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)ylt_stringWithFormat:(NSString *)format;
/**
 获取当前日期之后几天的日期
 
 @param day day
 @return date
 */
- (NSDate *)ylt_dayInTheFollowingDay:(int)day;
+ (NSDate *)ylt_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)ylt_daysInMonth:(NSUInteger)month;
+ (NSUInteger)ylt_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)ylt_daysInMonth;
+ (NSUInteger)ylt_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)ylt_timeDetail;
- (NSString *)ylt_timeInfo;
+ (NSString *)ylt_timeInfoWithDate:(NSDate *)date;
+ (NSString *)ylt_timeInfoWithDateString:(NSString *)dateString;

/** 获取像个日期相隔的天数 */
+ (NSInteger)ylt_getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;

/** 获取日期的年份 xxxx年 */
- (NSString *)ylt_yearTextBySendDate;
/** 日期逻辑：今天，昨天，具体日期（xx日xx月） */
- (NSString *)ylt_stringBySendDate;
/** 根据日前获取年龄 */
- (NSInteger)ylt_getAgeOfBirthDate:(NSDate *)toDay;

/** 日期逻辑：今天 xx:xx，昨天xx:xx，具体日期（xx日xx月） */
- (NSString *)ylt_stringByMessageDate;
- (NSString *)ylt_stringByTimeHM;



+ (NSCalendar *) ylt_currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) ylt_dateTomorrow;
+ (NSDate *) ylt_dateYesterday;
+ (NSDate *) ylt_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) ylt_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) ylt_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) ylt_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) ylt_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) ylt_dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Short string utilities
- (NSString *) ylt_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
@property (nonatomic, readonly) NSString *ylt_shortString;
@property (nonatomic, readonly) NSString *ylt_shortDateString;
@property (nonatomic, readonly) NSString *ylt_shortTimeString;
@property (nonatomic, readonly) NSString *ylt_mediumString;
@property (nonatomic, readonly) NSString *ylt_mediumDateString;
@property (nonatomic, readonly) NSString *ylt_mediumTimeString;
@property (nonatomic, readonly) NSString *ylt_longString;
@property (nonatomic, readonly) NSString *ylt_longDateString;
@property (nonatomic, readonly) NSString *ylt_longTimeString;


// Comparing dates
- (BOOL) ylt_isSameDay: (NSDate *) aDate;

- (BOOL) ylt_isToday;
- (BOOL) ylt_isTomorrow;
- (BOOL) ylt_isYesterday;

- (BOOL) ylt_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) ylt_isThisWeek;
- (BOOL) ylt_isNextWeek;
- (BOOL) ylt_isLastWeek;

- (BOOL) ylt_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) ylt_isThisMonth;
- (BOOL) ylt_isNextMonth;
- (BOOL) ylt_isLastMonth;

- (BOOL) ylt_isSameYearAsDate: (NSDate *) aDate;
- (BOOL) ylt_isThisYear;
- (BOOL) ylt_isNextYear;
- (BOOL) ylt_isLastYear;

- (BOOL) ylt_isEarlierThanDate: (NSDate *) aDate;
- (BOOL) ylt_isLaterThanDate: (NSDate *) aDate;
/** 比较两个时间是否相同 */
- (BOOL)ylt_isSameThanDate:(NSDate *)aDate;

- (BOOL) ylt_isInFuture;
- (BOOL) ylt_isInPast;

// Date roles
- (BOOL) ylt_isTypicallyWorkday;
- (BOOL) ylt_isTypicallyWeekend;

// Adjusting dates
- (NSDate *) ylt_dateByAddingYears: (NSInteger) dYears;
- (NSDate *) ylt_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) ylt_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) ylt_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) ylt_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) ylt_dateByAddingHours: (NSInteger) dHours;
- (NSDate *) ylt_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) ylt_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) ylt_dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) ylt_dateAtStartOfDay;
- (NSDate *) ylt_dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) ylt_minutesAfterDate: (NSDate *) aDate;
- (NSInteger) ylt_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) ylt_hoursAfterDate: (NSDate *) aDate;
- (NSInteger) ylt_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) ylt_daysAfterDate: (NSDate *) aDate;
- (NSInteger) ylt_daysBeforeDate: (NSDate *) aDate;
- (NSInteger) ylt_distanceInDaysToDate:(NSDate *)anotherDate;

@end

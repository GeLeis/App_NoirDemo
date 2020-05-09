//
//  NSDate+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by 项普华 on 2018/4/9.
//

#import "NSDate+YLT_Extension.h"

#define D_MINUTE    60
#define D_HOUR    3600
#define D_DAY    86400
#define D_WEEK    604800
#define D_YEAR    31556926

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (YLT_Extension)

- (NSUInteger)ylt_day {
    return [NSDate ylt_day:self];
}

- (NSUInteger)ylt_month {
    return [NSDate ylt_month:self];
}

- (NSUInteger)ylt_year {
    return [NSDate ylt_year:self];
}

- (NSUInteger)ylt_hour {
    return [NSDate ylt_hour:self];
}

- (NSUInteger)ylt_minute {
    return [NSDate ylt_minute:self];
}

- (NSUInteger)ylt_second {
    return [NSDate ylt_second:self];
}

+ (NSUInteger)ylt_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)ylt_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)ylt_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)ylt_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)ylt_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)ylt_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}


- (BOOL)ylt_isLeapYear {
    return [NSDate ylt_isLeapYear:self];
}

+ (BOOL)ylt_isLeapYear:(NSDate *)date {
    NSUInteger year = [date ylt_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)ylt_formatMDWEEK {
    return [NSString stringWithFormat:@"%02lu-%02lu %@", (unsigned long)[self ylt_month], (unsigned long)[self ylt_day],[self ylt_formatWeekDay]];
    
}

- (NSString *)ylt_formatYMDHM {
    return [NSString stringWithFormat:@"%lu年%02lu月%02lu日 %02lu:%02lu", (unsigned long)[self ylt_year],(unsigned long)[self ylt_month], (unsigned long)[self ylt_day],(unsigned long)[self ylt_hour],(unsigned long)[self ylt_minute]];
}

- (NSString *)ylt_formatYMDHMLine {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu %02lu:%02lu:%02lu", (unsigned long)[self ylt_year],(unsigned long)[self ylt_month], (unsigned long)[self ylt_day],(unsigned long)[self ylt_hour],(unsigned long)[self ylt_minute],(unsigned long)[self ylt_second]];
}

- (NSString *)ylt_formatYMD {
    return [NSString stringWithFormat:@"%lu年%02lu月%02lu日", (unsigned long)[self ylt_year],(unsigned long)[self ylt_month], (unsigned long)[self ylt_day]];
}

- (NSString *)ylt_formatYMDWith:(NSString *)c {
    return [NSString stringWithFormat:@"%lu%@%02lu%@%02lu", (unsigned long)[self ylt_year], c, (unsigned long)[self ylt_month], c, (unsigned long)[self ylt_day]];
}

- (NSString *)ylt_formatMD
{
    return [NSString stringWithFormat:@"%02lu月%02lu日", (unsigned long)[self ylt_month], (unsigned long)[self ylt_day]];
}
- (NSString *)ylt_formatMDHM
{
    return [NSString stringWithFormat:@"%02lu-%02lu %02lu:%02lu", (unsigned long)[self ylt_month], (unsigned long)[self ylt_day], (unsigned long)[self ylt_hour], (unsigned long)[self ylt_minute]];
}
- (NSString *)ylt_formatM:(NSString *)m D:(NSString *)d
{
    return [NSString stringWithFormat:@"%02lu%@%02lu%@", (unsigned long)[self ylt_month], m,(unsigned long)[self ylt_day],d];
}

- (NSString *)ylt_formatHM {
    return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)[self ylt_hour], (unsigned long)[self ylt_minute]];
}

- (NSString *)ylt_formatD:(NSString *)d H:(NSString *)h M:(NSString *)m S:(NSString *)s {
    return [NSString stringWithFormat:@"%02lu%@%02lu%@%02lu%@%02lu%@", (unsigned long)[self ylt_day], d,(unsigned long)[self ylt_hour],h,(unsigned long)[self ylt_minute], m,(unsigned long)[self ylt_second],s];
}

- (NSInteger)ylt_weekday {
    return [NSDate ylt_weekday:self];
}

- (NSInteger)ylt_week {
    return [NSDate ylt_week:self];
}

+ (NSInteger)ylt_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

+ (NSInteger)ylt_week:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekYear = [comps weekOfYear];
    
    return weekYear;
}

- (NSString *)ylt_dayFromWeekday {
    return [NSDate ylt_dayFromWeekday:self];
}

- (NSString *)ylt_formatWeekDay {
    switch([self ylt_weekday]) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ylt_dayFromWeekday:(NSDate *)date {
    switch([date ylt_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (NSDate *)ylt_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)ylt_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ylt_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date ylt_stringWithFormat:format];
}

- (NSString *)ylt_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *retStr = [outputFormatter stringFromDate:self];
    return retStr;
}

//获取当前日期之后的几个天
- (NSDate *)ylt_dayInTheFollowingDay:(int)day{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

+ (NSDate *)ylt_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

- (NSUInteger)ylt_daysInMonth:(NSUInteger)month {
    return [NSDate ylt_daysInMonth:self month:month];
}

+ (NSUInteger)ylt_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date ylt_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)ylt_daysInMonth {
    return [NSDate ylt_daysInMonth:self];
}

+ (NSUInteger)ylt_daysInMonth:(NSDate *)date {
    return [self ylt_daysInMonth:date month:[date ylt_month]];
}

- (NSString *)ylt_timeDetail {
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[self timeIntervalSinceDate:curDate];
    int month = (int)([curDate ylt_month] - [self ylt_month]);
    int year = (int)([curDate ylt_year] - [self ylt_year]);
    int day = (int)([curDate ylt_day] - [self ylt_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        if (retTime <  1.0) {
            return @"刚刚";
        }
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", floor(retTime)];
    }
    return [self ylt_stringWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)ylt_timeInfo {
    return [NSDate ylt_timeInfoWithDate:self];
}

+ (NSString *)ylt_timeInfoWithDate:(NSDate *)date {
    return [self ylt_timeInfoWithDateString:[self ylt_stringWithDate:date format:@"yyyy-MM-dd HH:mm:ss"]];
}

+ (NSString *)ylt_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self ylt_dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
    return date.ylt_timeDetail;
}

+ (NSInteger)ylt_getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

/** 获取日期的年份 今年：@"", 其他：xxxx年 */
- (NSString *)ylt_yearTextBySendDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *sendCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:self];
    NSString *str = [NSString stringWithFormat:@"%lu年",(unsigned long)sendCom.year];
    return str;
}

/** 日期逻辑：今天，昨天，具体日期（xx日xx月） */
- (NSString *)ylt_stringBySendDate {
    NSDate *toDay = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *sendCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:self];
    
    NSString *str_date = [NSString stringWithFormat:@"%02lu%ld月",(unsigned long)sendCom.day,(unsigned long)sendCom.month];
    NSDate *date1 = [toDay ylt_dateByAddingDays:-1];
    
    NSString *station_ymd = [self ylt_formatYMD];
    NSString *str_toDay = [toDay ylt_formatYMD];
    NSString *str_day1 = [date1 ylt_formatYMD];
    if ([station_ymd isEqualToString:str_toDay]) {
        str_date = @"今天";
    } else if ([station_ymd isEqualToString:str_day1]) {
        str_date = @"昨天";
    }
    return str_date;
}

- (NSString *)ylt_stringByMessageDate {
    NSDate *toDay = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *sendCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:self];
    
    NSString *str_date = [NSString stringWithFormat:@"%02lu/%02lu",(unsigned long)sendCom.month,(unsigned long)sendCom.day];
    NSDate *date1 = [toDay ylt_dateByAddingDays:-1];
    
    NSString *station_ymd = [self ylt_formatYMD];
    NSString *str_toDay = [toDay ylt_formatYMD];
    NSString *str_day1 = [date1 ylt_formatYMD];
    if ([station_ymd isEqualToString:str_toDay]) {
        str_date = [NSString stringWithFormat:@"今天 %@",[self ylt_formatHM]];
    } else if ([station_ymd isEqualToString:str_day1]) {
        str_date = [NSString stringWithFormat:@"昨天 %@",[self ylt_formatHM]];
    }
    return str_date;
}

- (NSString *)ylt_stringByTimeHM {
    NSDate *toDay = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *sendCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:self];
    
    NSString *str_date = [NSString stringWithFormat:@"%02lu/%02lu",(unsigned long)sendCom.month,(unsigned long)sendCom.day];
    NSDate *date1 = [toDay ylt_dateByAddingDays:-1];
    
    NSString *station_ymd = [self ylt_formatYMD];
    NSString *str_toDay = [toDay ylt_formatYMD];
    NSString *str_day1 = [date1 ylt_formatYMD];
    if ([station_ymd isEqualToString:str_toDay]) {
        str_date = [NSString stringWithFormat:@"%@",[self ylt_formatHM]];
    } else if ([station_ymd isEqualToString:str_day1]) {
        str_date = [NSString stringWithFormat:@"昨天"];
    }
    return str_date;
}

- (NSInteger)ylt_getAgeOfBirthDate:(NSDate *)toDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *sendCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:self];
    NSDateComponents *todayCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitSecond) fromDate:toDay];
    
    NSInteger brithDateYear  = [sendCom year];
    NSInteger brithDateMonth = [sendCom month];
    NSInteger brithDateDay   = [sendCom day];
    
    NSInteger currentDateYear  = [todayCom year];
    NSInteger currentDateMonth = [todayCom month];
    NSInteger currentDateDay   = [todayCom day];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return iAge;
}




+ (NSCalendar *) ylt_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark Relative Dates
+ (NSDate *) ylt_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] ylt_dateByAddingDays:days];
}
+ (NSDate *) ylt_dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] ylt_dateBySubtractingDays:days];
}
+ (NSDate *) ylt_dateTomorrow
{
    return [NSDate ylt_dateWithDaysFromNow:1];
}
+ (NSDate *) ylt_dateYesterday
{
    return [NSDate ylt_dateWithDaysBeforeNow:1];
}
+ (NSDate *) ylt_dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) ylt_dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) ylt_dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
+ (NSDate *) ylt_dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties

- (NSString *) ylt_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) ylt_shortString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) ylt_shortTimeString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) ylt_shortDateString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) ylt_mediumString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) ylt_mediumTimeString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) ylt_mediumDateString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) ylt_longString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) ylt_longTimeString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) ylt_longDateString
{
    return [self ylt_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}


#pragma mark Comparing Dates
- (BOOL) ylt_isSameDay: (NSDate *) aDate
{
    if (!aDate) {
        return NO;
    }
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}
- (BOOL) ylt_isToday
{
    return [self ylt_isSameDay:[NSDate date]];
}
- (BOOL) ylt_isTomorrow
{
    return [self ylt_isSameDay:[NSDate ylt_dateTomorrow]];
}
- (BOOL) ylt_isYesterday
{
    return [self ylt_isSameDay:[NSDate ylt_dateYesterday]];
}
// This hard codes the assumption that a week is 7 days
- (BOOL) ylt_isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}
- (BOOL) ylt_isThisWeek
{
    return [self ylt_isSameWeekAsDate:[NSDate date]];
}
- (BOOL) ylt_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ylt_isSameWeekAsDate:newDate];
}
- (BOOL) ylt_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ylt_isSameWeekAsDate:newDate];
}
// Thanks, mspasov
- (BOOL) ylt_isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) ylt_isThisMonth
{
    return [self ylt_isSameMonthAsDate:[NSDate date]];
}
- (BOOL) ylt_isLastMonth
{
    return [self ylt_isSameMonthAsDate:[[NSDate date] ylt_dateBySubtractingMonths:1]];
}

- (BOOL) ylt_isNextMonth
{
    return [self ylt_isSameMonthAsDate:[[NSDate date] ylt_dateByAddingMonths:1]];
}

- (BOOL) ylt_isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}
- (BOOL) ylt_isThisYear
{
    // Thanks, baspellis
    return [self ylt_isSameYearAsDate:[NSDate date]];
}
- (BOOL) ylt_isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
}
- (BOOL) ylt_isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}
- (BOOL) ylt_isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}
- (BOOL) ylt_isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}
/** 比较两个时间是否相同 */
- (BOOL)ylt_isSameThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedSame);
}
// Thanks, markrickert
- (BOOL) ylt_isInFuture
{
    return ([self ylt_isLaterThanDate:[NSDate date]]);
}
// Thanks, markrickert
- (BOOL) ylt_isInPast
{
    return ([self ylt_isEarlierThanDate:[NSDate date]]);
}
#pragma mark Roles
- (BOOL) ylt_isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}
- (BOOL) ylt_isTypicallyWorkday
{
    return ![self ylt_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) ylt_dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) ylt_dateBySubtractingYears: (NSInteger) dYears
{
    return [self ylt_dateByAddingYears:-dYears];
}

- (NSDate *) ylt_dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) ylt_dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self ylt_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings

- (NSDate *) ylt_dateBySubtractingDays: (NSInteger) dDays
{
    return [self ylt_dateByAddingDays: (dDays * -1)];
}
- (NSDate *) ylt_dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) ylt_dateBySubtractingHours: (NSInteger) dHours
{
    return [self ylt_dateByAddingHours: (dHours * -1)];
}
- (NSDate *) ylt_dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *) ylt_dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self ylt_dateByAddingMinutes: (dMinutes * -1)];
}
- (NSDate *) ylt_dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}
// Thanks gsempe & mteece
- (NSDate *) ylt_dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate ylt_currentCalendar] components:DATE_COMPONENTS fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate ylt_currentCalendar] dateFromComponents:components];
}
- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}
#pragma mark Retrieving Intervals
- (NSInteger) ylt_minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}
- (NSInteger) ylt_minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}
- (NSInteger) ylt_hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}
- (NSInteger) ylt_hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}
- (NSInteger) ylt_daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}
- (NSInteger) ylt_daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}
// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)ylt_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

@end

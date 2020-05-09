//
//  NSString+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "NSString+YLT_Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "sys/utsname.h"
#import "YLT_BaseMacro.h"
#import "NSObject+YLT_Extension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "NSObject+YLT_Router.h"

@implementation NSString (YLT_Extension)

@dynamic ylt_isValid;
@dynamic ylt_isChinese;
@dynamic ylt_isPureInt;
@dynamic ylt_isPureFloat;
@dynamic ylt_isPhone;
@dynamic ylt_isEmail;
@dynamic ylt_isIDCard;
@dynamic ylt_isIncludeSpecialChar;
@dynamic ylt_isEmoji;
@dynamic ylt_isURL;
@dynamic ylt_isLocalPath;
@dynamic ylt_isAllChinese;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"NSPlaceholderString") ylt_swizzleInstanceMethod:@selector(initWithData:encoding:) withMethod:@selector(initWithYLT_Data:encoding:)];
        [NSClassFromString(@"NSTaggedPointerString") ylt_swizzleInstanceMethod:@selector(initWithData:encoding:) withMethod:@selector(initWithYLT_Data:encoding:)];
        [NSClassFromString(@"__NSCFString") ylt_swizzleInstanceMethod:@selector(initWithData:encoding:) withMethod:@selector(initWithYLT_Data:encoding:)];
    });
}

- (instancetype)initWithYLT_Data:(NSData *)data encoding:(NSStringEncoding)encoding {
    if (data == nil || [data isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return [self initWithYLT_Data:data encoding:encoding];
}

#pragma mark - Public method 类方法
/**
 判断字符串是否为空
 
 @param sender 目标字符串
 @return YES:空 NO:非空
 */
+ (BOOL)ylt_isBlankString:(NSString *)sender {
    if (sender == nil) {
        return YES;
    } else if (sender == NULL) {
        return YES;
    } else if ([sender isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (![sender isKindOfClass:[NSString class]]) {
        return YES;
    } else if ([[sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    } else if ([sender isEqualToString:@"(null)"]) {
        return YES;
    } else if ([[sender ylt_trimWhitespace] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

/**
 字符串是否有效
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isValidString:(NSString *)sender {
    return ![NSString ylt_isBlankString:sender];
}

/**
 获取项目信息
 
 @return 项目名称/内部版本号（系统；ios版本；Scale）
 */
+ (NSString *)ylt_projectInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], deviceString, [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
}

/**
 拼接路径地址字符串 ref/path
 
 @param ref 前路径名
 @param path 文件名
 @return 路径地址
 */
+ (NSString *)ylt_handelRef:(NSString *)ref path:(NSString *)path {
    if (ref.length <= 0 && path.length <= 0) {
        return nil;
    }
    NSMutableString *result = [NSMutableString new];
    if (ref.length > 0) {
        [result appendString:ref];
    }
    if (path.length > 0) {
        [result appendFormat:@"%@%@", ref.length > 0? @"/": @"", path];
    }
    return [result ylt_urlEncoding];
}

/**
 求字节大小
 
 @param sizeOfByte 字节长度 byte
 @return 最大单位 内存
 */
+ (NSString *)ylt_sizeDisplayWithByte:(CGFloat)sizeOfByte {
    NSString *sizeDisplayStr;
    if (sizeOfByte < 1024) {
        sizeDisplayStr = [NSString stringWithFormat:@"%.0f bytes", sizeOfByte];
    } else {
        CGFloat sizeOfKB = sizeOfByte/1024;
        if (sizeOfKB < 1024) {
            sizeDisplayStr = [NSString stringWithFormat:@"%.0f KB", sizeOfKB];
        } else {
            CGFloat sizeOfM = sizeOfKB/1024;
            if (sizeOfM < 1024) {
                sizeDisplayStr = [NSString stringWithFormat:@"%.0f M", sizeOfM];
            } else {
                CGFloat sizeOfG = sizeOfKB/1024;
                sizeDisplayStr = [NSString stringWithFormat:@"%.0f G", sizeOfG];
            }
        }
    }
    return sizeDisplayStr;
}

/**
 字符串是否包含中文
 
 @param sender 目标字符串
 @return YES:包含 NO:否
 */
+ (BOOL)ylt_isChineseString:(NSString *)sender {
    NSString *pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numMatch = [regex numberOfMatchesInString:sender options:NSMatchingReportProgress range:NSMakeRange(0, sender.length)];
    return numMatch > 0 ? YES : NO;
}
/**
 字符串是否全部是中文
 
 @param sender 目标字符串
 @return  YES:全部是 NO:包含非中文字符串
 */
+ (BOOL)ylt_isAllChineseString:(NSString *)sender {
    NSString *pattern  = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if (([regextest evaluateWithObject:sender] == YES)) {
        return YES;
    }
    return NO;
}

/**
 字符串是否为整形
 
 @param sender 目标字符串
 @return YES:整形 NO:否
 */
+ (BOOL)ylt_isPureIntString:(NSString *)sender {
    NSScanner *scan = [NSScanner scannerWithString:sender];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 字符串是否为浮点形
 
 @param sender 目标字符串
 @return YES:浮点形 NO:否
 */
+ (BOOL)ylt_isPureFloatString:(NSString *)sender {
    NSScanner *scan = [NSScanner scannerWithString:sender];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 字符串是否为手机号码
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isPhoneString:(NSString *)sender {
    if (sender.length != 11) {
        return NO;
    }
    NSString *MOBILE = @"^1([3456789])\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:sender] == YES)) {
        return YES;
    }
    return NO;
}

/**
 字符串是否为邮箱
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isEmailString:(NSString *)sender {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:sender];
}

/**
 判断身份证号 18位
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isIDCardString:(NSString *)sender {
    NSString *emailRegex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([\\d|x|X]{1})$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![cardTest evaluateWithObject:sender]) {
        return NO;
    }
    if (sender.length < 18) {
        return NO;
    }
    //6位，地区代码
    NSString *address = [sender substringWithRange:NSMakeRange(0, 6)];
    NSArray *arrayProvince = @[@"11:北京",@"12:天津",@"13:河北",@"14:山西",@"15:内蒙古",@"21:辽宁",@"22:吉林",@"23:黑龙江",@"31:上海",@"32:江苏",@"33:浙江",@"34:安徽",@"35:福建",@"36:江西",@"37:山东",@"41:河南",@"42:湖北",@"43:湖南",@"44:广东",@"45:广西",@"46:海南",@"50:重庆",@"51:四川",@"52:贵州",@"53:云南",@"54:西藏",@"61:陕西",@"62:甘肃",@"63:青海",@"64:宁夏",@"65:新疆",@"71:台湾",@"81:香港",@"82:澳门",@"91:国外"];
    BOOL valideAddress = NO;
    NSString *address_has = [address substringWithRange:NSMakeRange(0, 2)];
    for (NSString *objStr in arrayProvince) {
        NSArray *keys = [objStr componentsSeparatedByString:@":"];
        if (keys.count > 0) {
            NSString *provinceKey = keys.firstObject;
            if ([provinceKey isEqualToString:address_has]) {
                valideAddress = YES;
                break;
            }
        }
    }
    if (!valideAddress) {
        return NO;
    }
    //加权因子
    NSArray *weightedFactors = @[ @7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2, @1];
    //身份证验证位值，其中10代表X
    NSArray *valideCode = @[ @1, @0, @10, @9, @8, @7, @6, @5, @4, @3, @2];
    int sum = 0;//声明加权求和变量
    NSMutableArray *arrayCertificate = [NSMutableArray array];
    for (int i=0; i<sender.length; i++) {
        NSRange rangeStr = NSMakeRange(i, 1);
        if (sender.length >= NSMaxRange(rangeStr)) {
            NSString *subStr = [sender substringWithRange:rangeStr];
            [arrayCertificate addObject:subStr];
        }
    }
    //将最后位为x的验证码替换为10
    if ([[arrayCertificate[17] lowercaseString] isEqualToString:@"x"]) {
        [arrayCertificate replaceObjectAtIndex:17 withObject:@"10"];
    }
    
    for (int i = 0; i < 17; i++) {
        int factor = [weightedFactors[i] intValue];
        int certificate = [arrayCertificate[i] intValue];
        sum += factor * certificate;//加权求和
    }
    
    int valCodePosition = sum%11; //得到验证码所在位置
    int certificateLast = [arrayCertificate[17] intValue];
    if (certificateLast == [valideCode[valCodePosition] intValue]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 是否含有特殊字符，一般用于姓名的判断，只可以是“拼音”和“汉字”
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isIncludeSpecialCharString:(NSString *)sender {
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:sender]) {
        return YES;
    }
    //需要过滤的特殊字符
    NSString *charString = @"~￥#&*<>《》()[]{}【】^@￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€?？。.";
    NSRange urgentRange = [sender rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:charString]];
    if (urgentRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 是否含有表情
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isEmojiString:(NSString *)sender {
    __block BOOL returnValue = NO;
    [sender enumerateSubstringsInRange:NSMakeRange(0, [sender length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

/**
 验证URL
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isURL:(NSString *)sender {
    return [sender hasPrefix:@"http://"] || [sender hasPrefix:@"https://"];
}

/**
 验证本地路径
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isLocalPath:(NSString *)sender {
    NSString *pattern = @"/var/mobile/Applications/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", pattern];
    return [pred evaluateWithObject:sender];
}

/**
 生成唯一字符串，一般用于文件命名
 */
+ (NSString *)ylt_generateUuidString {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    return uuidString;
}

#pragma mark - Instance methods 实例方法
/**
 是否包含中文字符
 */
- (BOOL)ylt_containsChinese {
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >0x4E00 && c <0x9FFF) {
            return YES;
        }
    }
    return NO;
}

/**
 去掉字符串 空格
 */
- (NSString *)ylt_trimWhitespace {
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}


/**
 URL Code 编码
 */
- (NSString *)ylt_urlEncoding {
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

/**
 URL Code 解码
 */
- (NSString *)ylt_urlDecoding {
    NSMutableString *string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByRemovingPercentEncoding];
}

/**
 获取字符串的 szie
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return （width， height）
 */
- (CGSize)ylt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

/**
 获取字符串的 szie，根据段落样式可以设定 ios7以上使用
 
 @param font 字体大小
 @param paragraphStyle 段落样式
 @param size 字符的矩形默认大小
 @return （width， height）
 */
- (CGSize)ylt_sizeWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle boundingRectWithSize:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName:font,
                                NSParagraphStyleAttributeName:paragraphStyle };
    //获取内容高度
    CGSize contentSize = [self boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
    //如果只有一行文字则去掉行高(纯英文不处理)
    if (contentSize.height - font.lineHeight <= paragraphStyle.lineSpacing) {
        if ([self ylt_containsChinese]) {
            contentSize = CGSizeMake(contentSize.width, contentSize.height - paragraphStyle.lineSpacing);
        }
    } else {
        //这里需要加上行间距
        contentSize = CGSizeMake(contentSize.width, contentSize.height + paragraphStyle.lineSpacing);
    }
    return contentSize;
}

/**
 获取字符串的高度
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return 高度
 */
- (CGFloat)ylt_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self ylt_sizeWithFont:font constrainedToSize:size].height+2.5;
}

/**
 获取字符串的宽度
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return 宽度
 */
- (CGFloat)ylt_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self ylt_sizeWithFont:font constrainedToSize:size].width+2.5;
}

/**
 修剪字符串左边的字符
 
 @param characterSet 字符串处理工具类
 @return 修剪好的字符串
 */
- (NSString *)ylt_stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self ylt_rangeByTrimmingLeftCharactersInSet:characterSet]];
}

/**
 获取字符串左边需要处理字符的range
 
 @param characterSet 字符串处理工具类
 @return NSRange 对象
 */
- (NSRange)ylt_rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}

/**
 修剪字符串右边的字符
 
 @param characterSet 字符串处理工具类
 @return 修剪好的字符串
 */
- (NSString *)ylt_stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self ylt_rangeByTrimmingRightCharactersInSet:characterSet]];
}

/**
 获取字符串右边需要处理字符的range
 
 @param characterSet 字符串处理工具类
 @return NSRange 对象
 */
- (NSRange)ylt_rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}

/**
 字符串转换为拼音（主要是汉字，个别多音字会转换错误）
 */
- (NSString *)ylt_transformToPinyin {
    if (self.length <= 0) {
        return self;
    }
    NSString *tempString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [tempString uppercaseString];
}

/**
 是否包含某些字符
 
 @param sender 查询的字符
 @return YES:包含 NO:否
 */
- (BOOL)ylt_containsString:(NSString *)sender {
    return ([self rangeOfString:sender].location == NSNotFound) ? NO : YES;
}

/**
 修剪字符串的首尾空格
 */
- (NSString *)ylt_stringToTrimWhiteSpace {
    NSString *resultString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (resultString && resultString.length > 0) {
        return resultString;
    }
    return nil;
}

/**
 是否只包含数字，小数点，负号
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
- (BOOL)ylt_isOnlyhasNumberAndpointWithString:(NSString *)sender {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789"] invertedSet];
    NSString *filter = [[sender componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [sender isEqualToString:filter];
}

#pragma mark - setter getter

/**
 字符串是否有效
 
 @return YES:有效 NO:无效
 */
- (BOOL)ylt_isValid {
    return [NSString ylt_isValidString:self];
}

/**
 字符串是否包含中文
 */
- (BOOL)ylt_isChinese {
    return [NSString ylt_isChineseString:self];
}

/**
 字符串是否全部是中文
 */
- (BOOL)ylt_isAllChinese {
    return [NSString ylt_isAllChineseString:self];
}

/**
 字符串是否为整形
 */
- (BOOL)ylt_isPureInt {
    return [NSString ylt_isPureIntString:self];
}

/**
 字符串是否为浮点形
 */
- (BOOL)ylt_isPureFloat {
    return [NSString ylt_isPureFloatString:self];
}

/**
 字符串是否为手机号码
 */
- (BOOL)ylt_isPhone {
    return [NSString ylt_isPhoneString:self];
}

/**
 字符串是否为邮箱
 */
- (BOOL)ylt_isEmail {
    return [NSString ylt_isEmailString:self];
}

/**
 判断身份证号 18位
 */
- (BOOL)ylt_isIDCard {
    return [NSString ylt_isIDCardString:self];
}

/**
 是否含有特殊字符，一般用于姓名的判断，只可以是“拼音”和“汉字”
 */
- (BOOL)ylt_isIncludeSpecialChar {
    return [NSString ylt_isIncludeSpecialCharString:self];
}

/**
 是否含有表情字符
 */
- (BOOL)ylt_isEmoji {
    return [NSString ylt_isEmojiString:self];
}

/**
 验证URL的有效性
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)ylt_isURL {
    return [NSString ylt_isURL:self];
}

/**
 验证iOS目录结果的本地路径
 
 @return 有效性 YES:本地路径 NO:非本地路径
 */
- (BOOL)ylt_isLocalPath {
    return [NSString ylt_isLocalPath:self];
}

/**
 将当前字符串转化为颜色值
 
 @return 颜色值
 */
- (UIColor *)ylt_colorFromHexString {
    NSString *resultString = self;
    //删除字符串中的空格
    resultString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([resultString rangeOfString:@"clear"].location != NSNotFound) {
        return UIColor.clearColor;
    }
    if ([resultString hasPrefix:@"0X"]) {
        resultString = [resultString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([resultString hasPrefix:@"#"]) {
        resultString = [resultString substringFromIndex:1];
    }
    
    if (resultString.length != 3 && resultString.length != 4 && resultString.length != 6 && resultString.length != 8) {
        return [UIColor clearColor];
    }
    
    if (resultString.length == 3 || resultString.length == 4) {
        NSRange range;
        range.location = 0;
        range.length = 1;
        NSString *r = [resultString substringWithRange:range];
        range.location = 1;
        NSString *g = [resultString substringWithRange:range];
        range.location = 2;
        NSString *b = [resultString substringWithRange:range];
        NSString *a = @"FF";
        if (resultString.length == 4) {
            range.location = 3;
            a = [resultString substringWithRange:range];
        }
        
        resultString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", r, r, g, g, b, b, a, a];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [resultString substringWithRange:range];
    range.location = 2;
    NSString *gString = [resultString substringWithRange:range];
    range.location = 4;
    NSString *bString = [resultString substringWithRange:range];
    
    NSString *aString = @"FF";
    if ([resultString length] == 8) {
        range.location = 6;
        aString = [resultString substringWithRange:range];
    }
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
}

/**
 将当前字符串转化为颜色值 argb 形式
 
 @return 颜色值
 */
- (UIColor *)ylt_androidColorFromHexString {
    NSString *resultString = self;
    //删除字符串中的空格
    resultString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([resultString rangeOfString:@"clear"].location != NSNotFound) {
        return UIColor.clearColor;
    }
    if ([resultString hasPrefix:@"0X"]) {
        resultString = [resultString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([resultString hasPrefix:@"#"]) {
        resultString = [resultString substringFromIndex:1];
    }
    
    if (resultString.length != 3 && resultString.length != 4 && resultString.length != 6 && resultString.length != 8) {
        return [UIColor clearColor];
    }
    
    if (resultString.length == 3) {
        NSRange range;
        range.location = 0;
        range.length = 1;
        NSString *r = [resultString substringWithRange:range];
        range.location = 1;
        NSString *g = [resultString substringWithRange:range];
        range.location = 2;
        NSString *b = [resultString substringWithRange:range];
        resultString = [NSString stringWithFormat:@"FF%@%@%@%@%@%@", r, r, g, g, b, b];
    }
    
    if (resultString.length == 4) {
        NSRange range;
        range.location = 0;
        range.length = 1;
        NSString *a = [resultString substringWithRange:range];
        range.location = 1;
        NSString *r = [resultString substringWithRange:range];
        range.location = 2;
        NSString *g = [resultString substringWithRange:range];
        range.location = 3;
        NSString *b = [resultString substringWithRange:range];
        
        resultString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", a, a, r, r, g, g, b, b];
    }

    if (resultString.length == 8) {
        resultString = [NSString stringWithFormat:@"%@%@", [resultString substringFromIndex:2], [resultString substringToIndex:2]];
    }
    
    return resultString.ylt_colorFromHexString;
}

/**
 字符串是否包含特殊字符
 
 @return YES:包含 NO:不包含
 */
-(BOOL)ylt_isIncludeSpecialCharact {
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€?？。."]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

/**
 是否包含emoji表情
 
 @return YES:包含 NO:不包含
 */
- (BOOL)ylt_stringContainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

/**
 去除掉首尾的空白字符和换行字符
 
 @return 替换后的字符串
 */
- (NSString *)ylt_removeLinefeedAndSpace {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return content;
}

/**
 去除掉首尾的空白字符和换行字符
 
 @return 替换后的字符串
 */
- (NSString *)ylt_removeRiskBlankAndLinefeed {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    return content;
}

/**
 格式化金额，金额三位一个逗号
 
 @param amount 需要给格式化的数字
 @return 格式化结果
 */
+ (NSString *)ylt_amountFormatWithAmount:(CGFloat)amount {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:@(amount)];
}

/**
 去掉浮点型小数点，取绝对值
 
 @param temp 浮点数
 @return 格式化结果
 */
+ (NSString *)ylt_stringByRMBFloat:(CGFloat)temp {
    NSString *str_float = [NSString stringWithFormat:@"%.2f",temp];
    NSRange range_float = [str_float rangeOfString:@"."];
    if (range_float.location != NSNotFound) {
        NSString *str_1 = [str_float substringFromIndex:range_float.location+range_float.length];
        if ([str_1 floatValue] == 0) {
            str_float = [str_float substringToIndex:range_float.location];
        }
    }
    return str_float;
}

/**
 手机号码4-7位隐藏为星
 
 @param phoneNum 手机号
 @return 隐藏后的结果
 */
+ (NSString *)ylt_phoneNumToAsterisk:(NSString *)phoneNum {
    if (phoneNum.ylt_isPhone) {
        return [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return phoneNum;
}

/**
 获取到所有子字符串的位置
 
 @param searchString 子串
 @param str 目标字串
 @return 位置结果
 */
+ (NSArray *)ylt_rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
}

/// 路由事件
- (id(^)(id params))ylt_router {
    @weakify(self);
    return ^id(id params) {
        @strongify(self);
        return YLT_Router(self.ylt_currentVC, self, params, nil);
    };
}

/// 路由事件
- (id(^)(id params, void(^completion)(NSError *error, id response)))ylt_routerCallback {
    @weakify(self);
    return ^id(id params, void(^completion)(NSError *error, id response)) {
        @strongify(self);
        return YLT_Router(self.ylt_currentVC, self, params, completion);
    };
}

@end

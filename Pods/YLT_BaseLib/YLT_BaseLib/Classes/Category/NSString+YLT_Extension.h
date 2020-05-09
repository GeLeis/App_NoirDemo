//
//  NSString+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YLT_Extension)

/**
 字符串是否有效
 */
@property (nonatomic, assign) BOOL ylt_isValid;

/**
 字符串是否包含中文
 */
@property (nonatomic, assign) BOOL ylt_isChinese;

/**
 字符串全部是中文
 */
@property (nonatomic, assign) BOOL ylt_isAllChinese;

/**
 字符串是否为整形
 */
@property (nonatomic, assign) BOOL ylt_isPureInt;

/**
 字符串是否为浮点形
 */
@property (nonatomic, assign) BOOL ylt_isPureFloat;

/**
 字符串是否为手机号码
 */
@property (nonatomic, assign) BOOL ylt_isPhone;

/**
 字符串是否为邮箱
 */
@property (nonatomic, assign) BOOL ylt_isEmail;

/**
 判断身份证号 18位
 */
@property (nonatomic, assign) BOOL ylt_isIDCard;

/**
 是否含有特殊字符，一般用于姓名的判断，只可以是“拼音”和“汉字”
 */
@property (nonatomic, assign) BOOL ylt_isIncludeSpecialChar;

/**
 是否含有表情字符
 */
@property (nonatomic, assign) BOOL ylt_isEmoji;

/**
 是否是有效的URL路径
 */
@property (nonatomic, assign) BOOL ylt_isURL;

/**
 是否是本地路径
 */
@property (nonatomic, assign) BOOL ylt_isLocalPath;

/**
 判断字符串是否为空
 
 @param sender 目标字符串
 @return YES:空 NO:非空
 */
+ (BOOL)ylt_isBlankString:(NSString *)sender;

/**
 字符串是否有效
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isValidString:(NSString *)sender;

/**
 字符串是否包含中文
 
 @param sender 目标字符串
 @return YES:包含 NO:否
 */
+ (BOOL)ylt_isChineseString:(NSString *)sender;

/**
 字符串是否全部是中文

 @param sender 目标字符串
 @return  YES:全部是 NO:包含非中文字符串
 */
+ (BOOL)ylt_isAllChineseString:(NSString *)sender;

/**
 字符串是否为整形
 
 @param sender 目标字符串
 @return YES:整形 NO:否
 */
+ (BOOL)ylt_isPureIntString:(NSString *)sender;

/**
 字符串是否为浮点形
 
 @param sender 目标字符串
 @return YES:浮点形 NO:否
 */
+ (BOOL)ylt_isPureFloatString:(NSString *)sender;

/**
 字符串是否为手机号码
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isPhoneString:(NSString *)sender;

/**
 字符串是否为邮箱
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isEmailString:(NSString *)sender;

/**
 判断身份证号 18位
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isIDCardString:(NSString *)sender;

/**
 是否含有特殊字符，一般用于姓名的判断，只可以是“拼音”和“汉字”
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isIncludeSpecialCharString:(NSString *)sender;

/**
 是否含有表情
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
+ (BOOL)ylt_isEmojiString:(NSString *)sender;

/**
 验证URL
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isURL:(NSString *)sender;

/**
 验证本地路径
 
 @param sender 目标字符串
 @return YES:有效 NO:无效
 */
+ (BOOL)ylt_isLocalPath:(NSString *)sender;

/**
 生成唯一字符串，一般用于文件命名
 */
+ (NSString *)ylt_generateUuidString;

/**
 获取项目信息
 
 @return 项目名称/内部版本号（系统；ios版本；Scale）
 */
+ (NSString *)ylt_projectInfo;

/**
 拼接路径地址字符串 ref/path
 
 @param ref 前路径名
 @param path 文件名
 @return 路径地址
 */
+ (NSString *)ylt_handelRef:(NSString *)ref path:(NSString *)path;

/**
 求字节大小
 
 @param sizeOfByte 字节长度 byte
 @return 最大单位 内存
 */
+ (NSString *)ylt_sizeDisplayWithByte:(CGFloat)sizeOfByte;

/**
 URL Code 编码
 */
- (NSString *)ylt_urlEncoding;

/**
 URL Code 解码
 */
- (NSString *)ylt_urlDecoding;

/**
 字符串转换为拼音（主要是汉字，个别多音字会转换错误）
 */
- (NSString *)ylt_transformToPinyin;

/**
 是否包含某些字符
 
 @param subString 查询的字符
 @return YES:包含 NO:否
 */
- (BOOL)ylt_containsString:(NSString *)subString;

/**
 修剪字符串的首尾空格
 */
- (NSString *)ylt_stringToTrimWhiteSpace;

/**
 是否只包含数字，小数点，负号
 
 @param sender 目标字符串
 @return YES:是 NO:否
 */
- (BOOL)ylt_isOnlyhasNumberAndpointWithString:(NSString *)sender;

/**
 获取字符串的 szie 宽高
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return （width， height）
 */
- (CGSize)ylt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 获取字符串的 szie，根据段落样式可以设定 ios7以上使用
 
 @param font 字体大小
 @param paragraphStyle 段落样式
 @param size 字符的矩形默认大小
 @return （width， height）
 */
- (CGSize)ylt_sizeWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle boundingRectWithSize:(CGSize)size ;

/**
 获取字符串的高度
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return 高度
 */
- (CGFloat)ylt_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 获取字符串的宽度
 
 @param font 字体大小
 @param size 字符的矩形默认大小
 @return 宽度
 */
- (CGFloat)ylt_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 修剪字符串左边的字符
 
 @param characterSet 字符串处理工具类
 @return 修剪好的字符串
 */
- (NSString *)ylt_stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;

/**
 获取字符串左边需要处理字符的range
 
 @param characterSet 字符串处理工具类
 @return NSRange 对象
 */
- (NSRange)ylt_rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;

/**
 修剪字符串右边的字符
 
 @param characterSet 字符串处理工具类
 @return 修剪好的字符串
 */
- (NSString *)ylt_stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
/**
 获取字符串右边需要处理字符的range
 
 @param characterSet 字符串处理工具类
 @return NSRange 对象
 */
- (NSRange)ylt_rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

/**
 将当前字符串转化为颜色值
 
 @return 颜色值
 */
- (UIColor *)ylt_colorFromHexString;

/**
 将当前字符串转化为颜色值 argb 形式
 
 @return 颜色值
 */
- (UIColor *)ylt_androidColorFromHexString;

/**
 字符串是否包含特殊字符
 
 @return YES:包含 NO:不包含
 */
-(BOOL)ylt_isIncludeSpecialCharact;

/**
 是否包含emoji表情
 
 @return YES:包含 NO:不包含
 */
- (BOOL)ylt_stringContainsEmoji;

/**
 去除掉首尾的空白字符和换行字符
 
 @return 替换后的字符串
 */
- (NSString *)ylt_removeLinefeedAndSpace;
/**
 去除掉首尾的空白字符和换行字符
 
 @return 替换后的字符串
 */
- (NSString *)ylt_removeRiskBlankAndLinefeed;

/**
 格式化金额，金额三位一个逗号
 
 @param amount 需要给格式化的数字
 @return 格式化结果
 */
+ (NSString *)ylt_amountFormatWithAmount:(CGFloat)amount;

/**
 去掉浮点型小数点，取绝对值
 
 @param temp 浮点数
 @return 格式化结果
 */
+ (NSString *)ylt_stringByRMBFloat:(CGFloat)temp;

/**
 手机号码4-7位隐藏为星
 
 @param phoneNum 手机号
 @return 隐藏后的结果
 */
+ (NSString *)ylt_phoneNumToAsterisk:(NSString *)phoneNum;

/**
 获取到所有子字符串的位置
 
 @param searchString 子串
 @param str 目标字串
 @return 位置结果
 */
+ (NSArray *)ylt_rangesOfString:(NSString *)searchString inString:(NSString *)str;

/// 路由事件
- (id(^)(id params))ylt_router;

/// 路由事件
- (id(^)(id params, void(^completion)(NSError *error, id response)))ylt_routerCallback;

@end

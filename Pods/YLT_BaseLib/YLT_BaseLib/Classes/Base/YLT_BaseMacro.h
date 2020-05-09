//
//  YLT_BaseMacro.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/25.
//

#ifndef YLT_BaseMacro_h
#define YLT_BaseMacro_h

#import "NSObject+YLT_ThreadSafe.h"

/// iOS设备信息
#define iPad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define iPhone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

//屏幕信息
#define iPhone4 (([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480) || ([UIScreen mainScreen].bounds.size.width==480&&[UIScreen mainScreen].bounds.size.height==320))
#define iPhone5 (([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==568) || ([UIScreen mainScreen].bounds.size.width==568&&[UIScreen mainScreen].bounds.size.height==320))
#define iPhone6 (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==667) || ([UIScreen mainScreen].bounds.size.width==667&&[UIScreen mainScreen].bounds.size.height==375))
#define iPhone6P (([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==736) || ([UIScreen mainScreen].bounds.size.width==736&&[UIScreen mainScreen].bounds.size.height==414))
#define iPhoneX (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==812) || ([UIScreen mainScreen].bounds.size.width==812&&[UIScreen mainScreen].bounds.size.height==375))
#define iPhoneXS iPhoneX
#define iPhoneXR (([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==896) || ([UIScreen mainScreen].bounds.size.width==896&&[UIScreen mainScreen].bounds.size.height==414))
#define iPhoneXSMAX iPhoneXR

#define iPhoneXLater (iPhoneX || iPhoneXR )

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneXLater ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneXLater ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneXLater ? (49.f + 34.f) : 49.f)
// 导航栏不带statusbar
#define NAVIGATION_BAR_WITHOUTSTATUS_HEIGHT 44
// home indicator hone按钮高度
#define HOME_INDICATOR_HEIGHT (iPhoneXLater ? 34.f : 0.f)

// iOS系统信息
#define YLT_iOS_VERSION [[UIDevice currentDevice] systemVersion]

#define iOS7 ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 8.0)
#define iOS7Later ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0)

#define iOS8 ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 9.0)
#define iOS8Later ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)

#define iOS9 ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 10.0)
#define iOS9Later ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)

#define iOS10 ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 11.0)
#define iOS10Later ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0)

#define iOS11 ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 12.0)
#define iOS11Later ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0)

#define iOS12  ([[UIDevice currentDevice] systemVersion].floatValue >= 12.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 13.0)
#define iOS12Later  ([[UIDevice currentDevice] systemVersion].floatValue >= 12.0)

#define iOS13  ([[UIDevice currentDevice] systemVersion].floatValue >= 13.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 14.0)
#define iOS13Later  ([[UIDevice currentDevice] systemVersion].floatValue >= 13.0)

#define iOSNew ([[UIDevice currentDevice] systemVersion].floatValue >= 14.0)

#define YLT_IsDark (iOS12Later ? (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) : NO)

/// 获取系统对象
#define YLT_Application        [UIApplication sharedApplication]
#define YLT_AppWindow          [UIApplication sharedApplication].keyWindow
#define YLT_AppDelegate        [UIApplication sharedApplication].delegate
#define YLT_RootViewController [UIApplication sharedApplication].delegate.window.rootViewController
// NSString To NSURL
#define YLT_URL(urlString)    [NSURL URLWithString:urlString]
#define YLT_NotificationCenter [NSNotificationCenter defaultCenter]
#define YLT_FileManager        [NSFileManager defaultManager]
//获取图片资源
#define YLT_GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//获取屏幕宽高
#define YLT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define YLT_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define YLT_SCREEN_BOUNDS [UIScreen mainScreen].bounds
//宽度比例
#define YLT_Scale_Width(width) (((CGFloat)width)*YLT_SCREEN_WIDTH/375.0)

// iOS沙盒目录
#define YLT_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define YLT_CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define YLT_TipAlert(_S_, ...) [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];

#if DEBUG
//输出日志信息
#define YLT_LogAll(type,format,...) NSLog(@"%@ %s %s+%d " format,type,__FILE__,__func__,__LINE__,##__VA_ARGS__)
#define YLT_Log(format,...) YLT_LogAll(@"",format,##__VA_ARGS__)
#define YLT_LogInfo(format,...) YLT_LogAll(@"",format,##__VA_ARGS__)
#define YLT_LogWarn(format,...) YLT_LogAll(@"‼️",format,##__VA_ARGS__)
#define YLT_LogError(format,...) YLT_LogAll(@"❌❌",format,##__VA_ARGS__)
#else
#define YLT_Log(format,...)
#define YLT_LogInfo(format,...)
#define YLT_LogWarn(format,...)
#define YLT_LogError(format,...)
#define YLT_Log(format,...)
#define NSLog(format,...)
#endif

//当前语言
#define YLT_CurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]
//info.plist 文件信息
#define YLT_InfoDictionary [[NSBundle mainBundle] infoDictionary]
//当前应用程序的 bundle ID

// app名称
#define YLT_AppName [YLT_InfoDictionary objectForKey:@"CFBundleDisplayName"]
//将URLTypes 中的第一个当做当前的回调参数
#define YLT_URL_SCHEME [[YLT_InfoDictionary[@"CFBundleURLTypes"] firstObject][@"CFBundleURLSchemes"] firstObject]
// app版本
#define YLT_AppVersion [YLT_InfoDictionary objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define YLT_BuildVersion [YLT_InfoDictionary objectForKey:@"CFBundleVersion"]
// device Model
#define YLT_DeviceType  [[UIDevice currentDevice] model]
// app bundle id
#define YLT_BundleIdentifier [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
// iPhone 别名
#define YLT_PhoneName [[UIDevice currentDevice] name]
//当前Bundle
#define YLT_CurrentBundle [NSBundle bundleForClass:[self class]]
//主bundle
#define YLT_MainBundle [NSBundle mainBundle]

#define YLT_WEAKSELF __weak typeof(self) weakSelf = self;

//颜色宏定义
#define YLT_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define YLT_RGB(r,g,b) YLT_RGBA(r,g,b,1.0f)
#define YLT_HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define YLT_HEXCOLORA(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:a]
#define YLT_StringColor(color) [color ylt_colorFromHexString]
#define YLT_StringValue(str) [str ylt_isValid]?str:@""

// 路由
#define YLT_Router(target, routerStr, attributeData, callback) [target ylt_routerHandler:routerStr params:attributeData completion:callback]
// 快速路由
#define YLT_RouterQuick(routerStr, attributeData) YLT_Router(self, routerStr, attributeData, nil)

///  通知处理
// 增加一个通知监听
#define YLT_AddNotification(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])
// 删除一个通知
#define YLT_RemoveNotificationWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
// 删除所有通知
#define YLT_RemoveNotificationObserver() ([[NSNotificationCenter defaultCenter] removeObserver:self])
// 发送通知
#define YLT_PostNotification(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])
// 发送通知 带object
#define YLT_PostNotificationWithObj(_name,_obj)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])
// 发送通知 带object，info
#define YLT_PostNotificationWithInfos(_name,_obj,_infos)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])

//快速生成单例对象
#define YLT_ShareInstanceHeader(cls)    + (cls *)shareInstance;\
                                        + (void)resetInstance;
#define YLT_ShareInstance(cls)          static cls *share_cls = nil;\
                                        static dispatch_once_t share_onceToken;\
                                        static dispatch_once_t ylt_init_onceToken;\
                                        + (cls *)shareInstance {\
                                                share_cls = [[cls alloc] init];\
                                                dispatch_once(&ylt_init_onceToken, ^{\
                                                    if ([share_cls respondsToSelector:@selector(ylt_init)]) {\
                                                        [share_cls performSelector:@selector(ylt_init) withObject:nil];\
                                                    }\
                                                });\
                                                return share_cls;\
                                            }\
                                            + (instancetype)allocWithZone:(struct _NSZone *)zone {\
                                                if (share_cls == nil) {\
                                                    dispatch_once(&share_onceToken, ^{\
                                                        share_cls = [super allocWithZone:zone];\
                                                    });\
                                                }\
                                                return share_cls;\
                                            }\
                                            + (void)resetInstance {\
                                                share_onceToken = 0;\
                                                ylt_init_onceToken = 0;\
                                                share_cls = nil;\
                                            }\
                                            YLT_THREAD_SAFE
//懒加载宏定义

#define YLT_Lazy(cls, sel, _sel) \
                                    - (cls *)sel {\
                                        if (!_sel) {\
                                            _sel = [[cls alloc] init];\
                                        }\
                                        return _sel;\
                                    }

#define YLT_LazyCategory(cls, fun) - (cls *)fun {\
                                        cls *result = objc_getAssociatedObject(self, @selector(fun));\
                                        if (result == nil) {\
                                            result = [[cls alloc] init];\
                                            objc_setAssociatedObject(self, @selector(fun), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
                                        }\
                                        return result;\
                                    }

/// main / background thead
#define YLT_MAIN(block)  if ([NSThread isMainThread]) {\
                            block();\
                         } else {\
                            dispatch_async(dispatch_get_main_queue(),block);\
                         }
#define YLT_MAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define YLT_BACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define YLT_BACKDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

/// 警告消除宏
#define YLT_ArgumentToString(macro) #macro
#define YLT_ClangWarningConcat(warning_name) YLT_ArgumentToString(clang diagnostic ignored warning_name)
// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
#define YLT_BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(YLT_ClangWarningConcat(#warningName))
#define YLT_EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define YLT_BeginIgnorePerformSelectorLeaksWarning YLT_BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define YLT_EndIgnorePerformSelectorLeaksWarning YLT_EndIgnoreClangWarning

#define YLT_BeginIgnoreAvailabilityWarning YLT_BeginIgnoreClangWarning(-Wpartial-availability)
#define YLT_EndIgnoreAvailabilityWarning YLT_EndIgnoreClangWarning

#define YLT_BeginIgnoreDeprecatedWarning YLT_BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define YLT_EndIgnoreDeprecatedWarning YLT_EndIgnoreClangWarning

#define YLT_BeginIgnoreUndeclaredSelecror YLT_BeginIgnoreClangWarning(-Wundeclared-selector)
#define YLT_EndIgnoreUndeclaredSelecror YLT_EndIgnoreClangWarning

#define YLT_BeginIgnoreUnusedVariable YLT_BeginIgnoreClangWarning(-Wunused-variable)
#define YLT_EndIgnoreUnusedVariable YLT_EndIgnoreClangWarning

#endif /* YLT_BaseMacro_h */

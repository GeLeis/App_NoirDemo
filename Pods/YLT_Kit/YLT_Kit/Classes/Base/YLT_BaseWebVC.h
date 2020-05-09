//
//  YLT_BaseWebVC.h
//  YLT_Kit
//
//  Created by 项普华 on 2018/5/22.
//

#import <YLT_Kit/YLT_Kit.h>
#import <WebKit/WebKit.h>

@protocol YLT_WebProtocl

@optional
/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)ylt_addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback;

/**
 移除观察的名称
 
 @param names 名称列表
 */
- (void)ylt_removeObserverMessageHandlersForNames:(NSArray<NSString *> *)names;

/**
 移除所有的观察名称
 */
- (void)ylt_removeAllObserMessageHandlers;

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param jsMedhodName 方法名
 @param param 数据
 */
- (void)ylt_sendMethodName:(NSString *)jsMedhodName param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION;

/**
 OC给JS发送JS数据 （OC调用JS的方法）
 
 @param function js方法名
 @param param 参数
 */
- (void)ylt_sendFunction:(NSString *)function param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION;

/**
 刷新页面
 */
- (void)ylt_reload;

/**
 设置标题 配置页面信息
 
 @param useWebTitle 是否使用web的标题
 @param pullRefresh 是否可以下拉刷新
 @param title 标题
 */
- (void)ylt_useWebTitle:(BOOL)useWebTitle pullRefresh:(BOOL)pullRefresh title:(NSString *)title;

/**
 清理缓存
 */
+ (void)ylt_cleanCache;

@end


@interface YLT_BaseWebView : YLT_BaseView<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, YLT_WebProtocl>

/**
 网页视图
 */
@property (nonatomic, strong, readonly) WKWebView *webView;
/**
 进度条的颜色
 */
@property (nonatomic, strong) UIColor *progressColor;
/**
 加载失败的占位图
 */
@property (nonatomic, strong) UIView *loadingFailedView;
/**
 网络视图参数配置
 */
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

/**
 请求开始前，会先调用此代理方法(类型，在请求先判断能不能跳转（请求）)
 */
@property (nonatomic, copy) void(^ylt_webViewDecidePolicyForNavigationAction)(WKWebView *webView, WKNavigationAction *navigationAction);

/**
 在响应完成时，会回调此方法(如果设置为不允许响应，web内容就不会传过来)
 */
@property (nonatomic, copy) void(^ylt_webViewDecidePolicyForNavigationResponse)(WKWebView *webView, WKNavigationResponse *navigationResponse);

/**
 开始导航跳转时会回调
 */
@property (nonatomic, copy) void(^ylt_webViewDidStart)(WKWebView *webView, WKNavigation *navigation);

/**
 接收到重定向时会回调
 */
@property (nonatomic, copy) void(^ylt_webViewDidReceiveServerRedirect)(WKWebView *webView, WKNavigation *navigation);

/**
 导航失败时会回调
 */
@property (nonatomic, copy) void(^ylt_webViewDidFail)(WKWebView *webView, WKNavigation *navigation, NSError *error);

/**
 页面内容到达main frame时回调
 */
@property (nonatomic, copy) void(^ylt_webViewDidCommit)(WKWebView *webView, WKNavigation *navigation);

/**
 导航完成时，会回调（也就是页面载入完成了）
 */
@property (nonatomic, copy) void(^ylt_webViewDidFinish)(WKWebView *webView, WKNavigation *navigation);

/**
 导航失败时会回调
 */
@property (nonatomic, copy) void(^ylt_webViewDidError)(WKWebView *webView, WKNavigation *navigation, NSError *error);

/**
 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行, 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
 */
@property (nonatomic, copy) void(^ylt_webViewDidReceiveAuthenticationChallenge)(WKWebView *webView, NSURLAuthenticationChallenge *challenge);

/**
 9.0才能使用，web内容处理中断时会触发
 */
@property (nonatomic, copy) void(^ylt_webViewContentProcessDidTerminate)(WKWebView *webView);

/**
 js 出现警告框时候调
 */
@property (nonatomic, copy) void(^ylt_webViewJSAlertMessage)(WKWebView *webView, NSString *message, WKFrameInfo *frame);

/**
 js 出现确认框时候调用
 */
@property (nonatomic, copy) void(^ylt_webViewJSConfirmMessage)(WKWebView *webView, NSString *message, WKFrameInfo *frame);

/**
 根据地址生成网页视图
 
 @param frame frame
 @param urlString 网页地址
 @return 网页视图
 */
+ (instancetype)ylt_webViewFrame:(CGRect)frame URLString:(NSString *)urlString;

/**
 根据地址生成网页视图
 
 @param frame frame
 @param filePath 本地路径
 @return 网页视图
 */
+ (instancetype)ylt_webViewFrame:(CGRect)frame filePath:(NSString *)filePath;

@end

@interface YLT_BaseWebVC : YLT_BaseVC<YLT_WebProtocl>

/**
 网页视图
 */
@property (nonatomic, strong, readonly) YLT_BaseWebView *webView;

/**
 返回按钮
 */
@property (nonatomic, strong, readonly) UIButton *backBtn;

/**
 关闭按钮
 */
@property (nonatomic, strong, readonly) UIButton *closeBtn;

/**
 根据地址生成网页视图
 
 @param urlString 路径
 @return 控制器
 */
+ (instancetype)ylt_webVCFromURLString:(NSString *)urlString;

/**
 根据地址生成网页视图
 
 @param filePath 路径
 @return 控制器
 */
+ (instancetype)ylt_webVCFromFilePath:(NSString *)filePath;

- (void)registerBackBtn:(BOOL)hasBackBtn closeBtn:(BOOL)hasCloseBtn;

@end

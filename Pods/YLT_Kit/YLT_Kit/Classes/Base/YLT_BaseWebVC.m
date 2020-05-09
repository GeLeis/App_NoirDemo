//
//  YLT_BaseWebVC.m
//  YLT_Kit
//
//  Created by 项普华 on 2018/5/22.
//

#import "YLT_BaseWebVC.h"
#import "UIView+YLT_Create.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface YLT_WKProcessPool : WKProcessPool
YLT_ShareInstanceHeader(YLT_WKProcessPool);
@end

@implementation YLT_WKProcessPool
YLT_ShareInstance(YLT_WKProcessPool);

- (void)ylt_init {
}

@end


@interface YLT_BaseWebView ()
/**
 加载路径
 */
@property (nonatomic, strong) NSURL *url;
/**
 观察的对象名称列表
 */
@property (nonatomic, strong) NSMutableArray *observers;
/**
 进度条
 */
@property (nonatomic, strong) CALayer *progressLayer;
/**
 使用web的标题
 */
@property (nonatomic, assign) BOOL notUseWebTitle;

@property (nonatomic, copy) void(^callback)(WKScriptMessage *message);

@end

@implementation YLT_BaseWebView

@synthesize webView = _webView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:self.configuration];
        [self addSubview:self.webView];
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self);
        _progressLayer = [CALayer layer];
        self.progressLayer.frame = CGRectMake(0, 0, 0, 2);
        self.progressLayer.backgroundColor = self.progressColor?self.progressColor.CGColor:UIColor.blueColor.CGColor;
        [self.layer addSublayer:self.progressLayer];
        [[self.webView rac_valuesForKeyPath:@"estimatedProgress" observer:self] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.progressLayer.frame = CGRectMake(0, 0, YLT_SCREEN_WIDTH*[x floatValue], 2);
            // 进度条完成则隐藏
            if ([x floatValue] == 1.0f) {
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 2);
            }
        }];
        
        self.ylt_tap(self, @selector(tapAction:));
    }
    return self;
}

/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)ylt_addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback {
    for (NSString *name in names) {
        if (name.ylt_isValid) {
            [_configuration.userContentController removeScriptMessageHandlerForName:name];
            [_configuration.userContentController addScriptMessageHandler:self name:name];
            [self.observers addObject:name];
        }
    }
    self.callback = callback;
}

/**
 移除观察的名称
 
 @param names 名称列表
 */
- (void)ylt_removeObserverMessageHandlersForNames:(NSArray<NSString *> *)names {
    [names enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_configuration.userContentController removeScriptMessageHandlerForName:obj];
    }];
}

/**
 移除所有的message handler
 */
- (void)ylt_removeAllObserMessageHandlers {
    [self ylt_removeObserverMessageHandlersForNames:_observers];
}

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param jsMedhodName 方法名
 @param param 数据
 */
- (void)ylt_sendMethodName:(NSString *)jsMedhodName param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION {
    NSMutableString *sender = [NSMutableString new];
    if (param.ylt_isValid) {
        va_list args;
        NSString *arg;
        va_start(args, param);
        [sender appendFormat:@"%@('%@'", jsMedhodName, param];
        arg = va_arg(args, NSString *);
        while(arg) {
            [sender appendFormat:@", '%@'", arg];
            arg = va_arg(args, NSString *);
        }
        [sender appendFormat:@")"];
        va_end(args);
    } else {
        [sender appendFormat:@"%@(null)", jsMedhodName];
    }
    
    [self sendParams:sender];
}

/**
 OC给JS发送JS数据 （OC调用JS的方法）
 
 @param function js方法名
 @param param 参数
 */
- (void)ylt_sendFunction:(NSString *)function param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION {
    NSMutableString *sender = [NSMutableString new];
    if (param.ylt_isValid) {
        va_list args;
        NSString *arg;
        va_start(args, param);
        [sender appendFormat:@"(%@)('%@'", function, param];
        arg = va_arg(args, NSString *);
        while(arg) {
            [sender appendFormat:@", '%@'", arg];
            arg = va_arg(args, NSString *);
        }
        [sender appendFormat:@")"];
        va_end(args);
    }  else {
        [sender appendFormat:@"(%@)()", function];
    }
    [self sendParams:sender];
}

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param params 数据
 */
- (void)sendParams:(NSString *)params {
    [self.webView evaluateJavaScript:params completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            YLT_LogError(@"%@", error);
        } else {
            YLT_Log(@"%@", result);
        }
    }];
}

/**
 根据地址生成网页视图
 
 @param frame frame
 @param urlString 网页地址
 @return 网页视图
 */
+ (instancetype)ylt_webViewFrame:(CGRect)frame URLString:(NSString *)urlString {
    YLT_BaseWebView *webView = [[self alloc] initWithFrame:frame];
    webView.url = [NSURL URLWithString:urlString];
    return webView;
}

/**
 根据地址生成网页视图
 
 @param frame frame
 @param filePath 本地路径
 @return 网页视图
 */
+ (instancetype)ylt_webViewFrame:(CGRect)frame filePath:(NSString *)filePath {
    YLT_BaseWebView *webView = [[self alloc] initWithFrame:frame];
    webView.url = [NSURL fileURLWithPath:filePath];
    return webView;
}

- (void)dealloc {
    [self.webView stopLoading];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    [self.webView.configuration.userContentController removeAllUserScripts];
}

#pragma mark - WKScriptMessageHandler
/**
 收到 JavaScript 方法调用
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.callback) {
        self.callback(message);
    }
}

#pragma mark - WKNavigationDelegate
// 请求开始前，会先调用此代理方法
// 类型，在请求先判断能不能跳转（请求）
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    //    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![hostname containsString:@".baidu.com"]) {
    //        // 对于跨域，需要手动跳转
    //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    //        // 不允许web内跳转
    //        decisionHandler(WKNavigationActionPolicyCancel);
    //    } else {
    //        decisionHandler(WKNavigationActionPolicyAllow);
    //    }
    if (self.ylt_webViewDecidePolicyForNavigationAction) {
        self.ylt_webViewDecidePolicyForNavigationAction(webView, navigationAction);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    YLT_LogInfo(@"%@", hostname);
}

// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString *hostname = navigationResponse.response.URL.host.lowercaseString;
    if (self.ylt_webViewDecidePolicyForNavigationResponse) {
        self.ylt_webViewDecidePolicyForNavigationResponse(webView, navigationResponse);
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
    YLT_LogInfo(@"%@", hostname);
}

// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
    [_loadingFailedView removeFromSuperview];
    if (self.ylt_webViewDidStart) {
        self.ylt_webViewDidStart(webView, navigation);
    }
}

// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
    if (self.ylt_webViewDidReceiveServerRedirect) {
        self.ylt_webViewDidReceiveServerRedirect(webView, navigation);
    }
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    YLT_LogInfo(@"%@", webView);
    if (!webView.URL) {
        [self addSubview:self.loadingFailedView];
    }
    if (self.ylt_webViewDidFail) {
        self.ylt_webViewDidFail(webView, navigation, error);
    }
}

// 页面内容到达main frame时回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
    [_loadingFailedView removeFromSuperview];
    if (self.ylt_webViewDidCommit) {
        self.ylt_webViewDidCommit(webView, navigation);
    }
}

// 导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
    if (!self.notUseWebTitle) {
        @weakify(self);
        [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            @strongify(self);
            if ([result isKindOfClass:[NSString class]] && ((NSString *) result).ylt_isValid && self.ylt_responderVC) {
                self.ylt_responderVC.title = result;
            }
        }];
    }
    [_loadingFailedView removeFromSuperview];
    if (self.ylt_webViewDidFinish) {
        self.ylt_webViewDidFinish(webView, navigation);
    }
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    YLT_LogInfo(@"%@", webView);
    if (!webView.URL) {
        [self addSubview:self.loadingFailedView];
    }
    if (self.ylt_webViewDidError) {
        self.ylt_webViewDidError(webView, navigation, error);
    }
}

// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    YLT_LogInfo(@"%@", webView);
    if (self.ylt_webViewDidReceiveAuthenticationChallenge) {
        self.ylt_webViewDidReceiveAuthenticationChallenge(webView, challenge);
    }
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    YLT_LogInfo(@"%@", webView);
    [self ylt_reload];
    if (self.ylt_webViewContentProcessDidTerminate) {
        self.ylt_webViewContentProcessDidTerminate(webView);
    }
}

/// js 出现警告框时候调用
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    if (message.ylt_isValid) {
        YLT_TipAlert(message);
    }
    if (self.ylt_webViewJSAlertMessage) {
        self.ylt_webViewJSAlertMessage(webView, message, frame);
    }
    completionHandler();
}

/// js 出现确认框时候调用
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    if (message.ylt_isValid) {
        YLT_TipAlert(message);
    }
    if (self.ylt_webViewJSConfirmMessage) {
        self.ylt_webViewJSConfirmMessage(webView, message, frame);
    }
    completionHandler(YES);
}

//出现new tab的时候是否响应的问题
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - WKUIDelegate


#pragma mark - action

- (void)tapAction:(UIGestureRecognizer *)sender {
    if (_loadingFailedView && _loadingFailedView.superview) {
        [self ylt_reload];
    }
}

/**
 刷新页面
 */
- (void)ylt_reload {
    if (self.webView.URL) {
        [self.webView reload];
    } else if(self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}

/**
 设置标题 配置页面信息
 
 @param useWebTitle 是否使用web的标题
 @param pullRefresh 是否可以下拉刷新
 @param title 标题
 */
- (void)ylt_useWebTitle:(BOOL)useWebTitle pullRefresh:(BOOL)pullRefresh title:(NSString *)title {
    self.notUseWebTitle = !useWebTitle;
    self.ylt_responderVC.title = @"";
    if (self.notUseWebTitle && title.ylt_isValid) {
        self.ylt_responderVC.title = title;
    }
    if (pullRefresh) {
        @weakify(self);
        self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.webView.scrollView.mj_header endRefreshing];
            [self ylt_reload];
        }];
    }
}

/**
 清理缓存
 */
+ (void)ylt_cleanCache {
    if (@available(iOS 9.0, *)) {
        NSArray *types = @[WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeDiskCache];
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:date completionHandler:^{
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask,YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

#pragma mark - getter

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.backgroundColor = progressColor.CGColor;
}

- (UIView *)loadingFailedView {
    if (!_loadingFailedView) {
        _loadingFailedView =
        UIView.ylt_create()
        .ylt_frame(CGRectMake(YLT_SCREEN_WIDTH/4., (YLT_SCREEN_HEIGHT-YLT_SCREEN_WIDTH/2.)/2., YLT_SCREEN_WIDTH/2., YLT_SCREEN_WIDTH/2.))
        .ylt_backgroundColor([UIColor clearColor]);
        
        UILabel.ylt_createFrame(_loadingFailedView, _loadingFailedView.bounds)
        .ylt_convertToLabel()
        .ylt_lineNum(2)
        .ylt_text(@"加载失败\n点击重试")
        .ylt_textColor(YLT_HEXCOLOR(0x666666))
        .ylt_textAlignment(NSTextAlignmentCenter);
    }
    return _loadingFailedView;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (WKWebViewConfiguration *)configuration {
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        _configuration.userContentController = [[WKUserContentController alloc] init];
        WKPreferences *preferences = [WKPreferences new];
        //在iOS上默认为NO，表示不能自动通过窗口打开
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 0.0;
        preferences.javaScriptEnabled = YES;
        _configuration.preferences = preferences;
        // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
        _configuration.processPool = [WKProcessPool new];//[YLT_WKProcessPool shareInstance];
    }
    return _configuration;
}

- (NSMutableArray *)observers {
    if (!_observers) {
        _observers = [[NSMutableArray alloc] init];
    }
    return _observers;
}

@end


@interface YLT_BaseWebVC ()
/**
 url
 */
@property (nonatomic, strong) NSURL *url;
@end

@implementation YLT_BaseWebVC

@synthesize backBtn = _backBtn;
@synthesize closeBtn = _closeBtn;
@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.url = self.url;
}

- (void)registerBackBtn:(BOOL)hasBackBtn closeBtn:(BOOL)hasCloseBtn {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (hasBackBtn) {
        [list addObject:[[UIBarButtonItem alloc] initWithCustomView:self.backBtn]];
    }
    if (hasCloseBtn) {
        [list addObject:[[UIBarButtonItem alloc] initWithCustomView:self.closeBtn]];
    }
    if (list.count > 0) {
        self.navigationItem.leftBarButtonItems = list;
    }
}

/**
 根据地址生成网页视图
 
 @param urlString 路径
 @return 控制器
 */
+ (instancetype)ylt_webVCFromURLString:(NSString *)urlString {
    YLT_BaseWebVC *vc = [[self alloc] init];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    vc.url = [NSURL URLWithString:urlString];
    [vc prepareLoading:urlString];
    return vc;
}

/**
 根据地址生成网页视图
 
 @param filePath 路径
 @return 控制器
 */
+ (instancetype)ylt_webVCFromFilePath:(NSString *)filePath {
    YLT_BaseWebVC *vc = [[self alloc] init];
    vc.url = [NSURL fileURLWithPath:filePath];
    [vc prepareLoading:filePath];
    return vc;
}

- (void)prepareLoading:(NSString *)urlString {
    NSDictionary *params = [self analysisURL:urlString];
    if (params && [params.allKeys containsObject:@"navigationBarHidden"]) {
        @weakify(self);
        if ([[params objectForKey:@"navigationBarHidden"] boolValue]) {
            [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                [self.navigationController setNavigationBarHidden:YES animated:YES];
            }];
            [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                [self.navigationController setNavigationBarHidden:NO animated:YES];
            }];
        } else {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
}

/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)ylt_addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback {
    [self.webView ylt_addObserverNames:names callback:callback];
}

/**
 移除观察的名称
 
 @param names 名称列表
 */
- (void)ylt_removeObserverMessageHandlersForNames:(NSArray<NSString *> *)names {
    [self.webView ylt_removeObserverMessageHandlersForNames:names];
}

/**
 移除所有的观察名称
 */
- (void)ylt_removeAllObserMessageHandlers {
    [_webView ylt_removeAllObserMessageHandlers];
}

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param jsMedhodName 方法名
 @param param 数据
 */
- (void)ylt_sendMethodName:(NSString *)jsMedhodName param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION {
    NSMutableString *sender = [NSMutableString new];
    if (param.ylt_isValid) {
        va_list args;
        NSString *arg;
        va_start(args, param);
        [sender appendFormat:@"%@('%@'", jsMedhodName, param];
        arg = va_arg(args, NSString *);
        while(arg) {
            [sender appendFormat:@", '%@'", arg];
            arg = va_arg(args, NSString *);
        }
        [sender appendFormat:@")"];
        va_end(args);
    } else {
        [sender appendFormat:@"%@('null')", jsMedhodName];
    }
    [self.webView sendParams:sender];
}

/**
 OC给JS发送JS数据 （OC调用JS的方法）
 
 @param function js方法名
 @param param 参数
 */
- (void)ylt_sendFunction:(NSString *)function param:(NSString *)param, ...NS_REQUIRES_NIL_TERMINATION {
    NSMutableString *sender = [NSMutableString new];
    if (param.ylt_isValid) {
        va_list args;
        NSString *arg;
        va_start(args, param);
        [sender appendFormat:@"(%@)('%@'", function, param];
        arg = va_arg(args, NSString *);
        while(arg) {
            [sender appendFormat:@", '%@'", arg];
            arg = va_arg(args, NSString *);
        }
        [sender appendFormat:@")"];
        va_end(args);
    }  else {
        [sender appendFormat:@"(%@)()", function];
    }
    [self.webView sendParams:sender];
}

/**
 刷新页面
 */
- (void)ylt_reload {
    [self.webView ylt_reload];
}

/**
 设置标题 配置页面信息
 
 @param useWebTitle 是否使用web的标题
 @param pullRefresh 是否可以下拉刷新
 @param title 标题
 */
- (void)ylt_useWebTitle:(BOOL)useWebTitle pullRefresh:(BOOL)pullRefresh title:(NSString *)title {
    [self.webView ylt_useWebTitle:useWebTitle pullRefresh:pullRefresh title:title];
}

/**
 清理缓存
 */
+ (void)ylt_cleanCache {
    [YLT_BaseWebView ylt_cleanCache];
}

- (void)dealloc {
    [self ylt_removeAllObserMessageHandlers];
}

- (NSDictionary *)analysisURL:(NSString *)url {
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSArray *components = [url componentsSeparatedByString:@"?"];
    if (components.count >= 2) {
        NSString *tempName = components.lastObject;
        NSArray *components = [tempName componentsSeparatedByString:@"&"];
        for (NSString *tmpStr in components) {
            if (!tmpStr.ylt_isValid) {
                continue;
            }
            NSArray *tmpArray = [tmpStr componentsSeparatedByString:@"="];
            if (tmpArray.count == 2) {
                [result setObject:tmpArray[1] forKey:tmpArray[0]];
            } else {
                YLT_LogError(@"参数不合法 : %@",tmpStr);
            }
        }
    }
    return result;
}

#pragma mark - getter

- (UIButton *)backBtn {
    if (!_backBtn) {
        @weakify(self);
        _backBtn = UIButton
        .ylt_create()
        .ylt_convertToButton()
        .ylt_normalTitle(@"返回")
        .ylt_buttonClickBlock(^(UIButton *sender) {
            @strongify(self);
            if (self.webView.webView.canGoBack) {
                [self.webView.webView goBack];
            } else {
                if (self.navigationController.viewControllers.firstObject == self) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        });
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:16.];
        [_backBtn setTitleColor:[[UINavigationBar appearance] tintColor] forState:UIControlStateNormal];
        [_backBtn sizeToFit];
    }
    return _backBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        @weakify(self);
        _closeBtn = UIButton
        .ylt_create()
        .ylt_convertToButton()
        .ylt_normalTitle(@"关闭")
        .ylt_buttonClickBlock(^(UIButton *sender) {
            @strongify(self);
            if (self.navigationController.viewControllers.firstObject == self) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:16.];
        [_closeBtn setTitleColor:[[UINavigationBar appearance] tintColor] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        RAC(_closeBtn, hidden) = [RACObserve(self.webView.webView, canGoBack) map:^id _Nullable(NSNumber *canGoBackNum) {
            @strongify(self);
//            if (canGoBackNum.boolValue) {
//                [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
//            } else {
//                [self.backBtn setTitle:@"" forState:UIControlStateNormal];
//            }
//            [self.backBtn sizeToFit];
            return @(!canGoBackNum.boolValue);
        }];
    }
    return _closeBtn;
}

- (YLT_BaseWebView *)webView {
    if (!_webView) {
        _webView = [[YLT_BaseWebView alloc] init];
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _webView;
}

@end

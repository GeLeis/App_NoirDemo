//
//  YLT_BaseVC.m
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "YLT_BaseVC.h"

@interface YLT_BaseVC ()

@end

@implementation YLT_BaseVC
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

- (void)dealloc {
    YLT_LogInfo(@"Dealloc %@", NSStringFromClass([self class]));
}

#pragma mark - ViewDidLoad 中调用
/**
 Setup
 主要负责页面变量的初始化、页面元素的颜色等
 */
- (void)ylt_setup {
}

/**
 视图的页面配置
 主要负责视图的添加工作 以及约束的设置
 */
- (void)ylt_addSubViews {
}

/**
 网络请求
 主要负责当前页面的初始网络请求
 */
- (void)ylt_request {
}

#pragma mark - viewWillAppear 中调用
/**
 数据与视图的绑定
 主要负责数据与页面的绑定操作
 */
- (void)ylt_bindData {
}

#pragma mark - viewWillLayoutSubviews 中调用
/**
 页面的布局
 视图加载完成需要更新布局的操作
 */
- (void)ylt_layout {
}

#pragma mark - viewWillDisappear 中调用
/**
 页面消失的调用
 当页面消失的时候的回调
 */
- (void)ylt_dismiss {
}

- (void)ylt_back {
    if (self.ylt_callback) {
        self.ylt_callback(self.ylt_params);
    }
}

#pragma mark - setter/getter

#pragma clang diagnostic pop

@end

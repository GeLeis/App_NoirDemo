//
//  YLT_BaseTableVC.m
//  AFNetworking
//
//  Created by 项普华 on 2018/4/20.
//

#import "YLT_BaseTableVC.h"

@interface YLT_BaseTableVC ()

@end

@implementation YLT_BaseTableVC

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "ViewController.h"
#import "TableViewListCell.h"
#import "DetailViewController.h"
#import <MJExtension.h>
#import "UIColor+Common.h"
#import <FLEX.h>
#import "GLRunloopTaskTool.h"
#import "NSArray+GLSafe.h"
static NSPointerArray *testArr = nil;
@interface ViewController ()
@property (nonatomic, copy) NSArray *dataLists;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"TableViewVC";
    //tableView注册重用cell
    [self.tableView registerClass:TableViewListCell.class forCellReuseIdentifier:NSStringFromClass(TableViewListCell.class)];
//    [[FLEXManager sharedManager] showExplorer];
//    [self pointerArrayTest_didLoad];
}

- (void)dealloc {
    
}

- (void)pointerArrayTest_didLoad {
    testArr = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
    NSObject *obj1 = [NSObject new];
    [testArr addPointer:(__bridge void * _Nullable)(@1)];
    [testArr addPointer:(__bridge void * _Nullable)(obj1)];
    [testArr addPointer:(__bridge void * _Nullable)(self)];
    obj1 = nil;
    NSLog(@"self%@ p=%p",self,self);
    for (int i = 0; i < testArr.count; i++) {
        if ([testArr pointerAtIndex:i] == (__bridge void * _Nullable)(self)) {
            NSLog(@"equal=========");
        }
        NSLog(@"ViewController=%p",[testArr pointerAtIndex:i]);
    }
    [testArr addPointer:NULL];
    [testArr compact];
    NSLog(@"testarr = %@",[testArr allObjects]);
}

- (void)pointerArrayTest_dealloc {
        [testArr addPointer:NULL];
        [testArr compact];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        NSLog(@"====================%d",testArr.count);
    //    });
    //    for (int i = 0; i < testArr.count; i++) {
    //        NSLog(@"ViewControllerDealloc=%p",[testArr pointerAtIndex:i]);
    //    }
    //    __weak id weakself = self;
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    id obj = [testArr[1] nonretainedObjectValue];
    //    NSObject *obj22 = [NSObject new];
    //       NSLog(@"self = %@  ViewControllerDealloc===%@",self,obj);
    //    [obj performSelector:@selector(timeTest)];
            NSLog(@"testarr = %@",[testArr allObjects]);
            for (int i = 0; i < testArr.count; i++) {
                if (i == 2) {
                    id obj = [testArr pointerAtIndex:i];
                    [obj performSelector:@selector(timeTest)];
                }
                NSLog(@"ViewControllerDealloc=%p",[testArr pointerAtIndex:i]);
            }
    //    });
}
- (void)timeTest {
//    for (int i = 0; i < 20000; i++) {
//        NSLog(@"%d",i);
//    }
//    [NSThread sleepForTimeInterval:2];
    NSLog(@"timeTest");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataLists.count;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//获取cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewListCell.class) forIndexPath:indexPath];
    cell.data = self.dataLists[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.backgroundColor = [UIColor blackColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor darkGrayColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor lightGrayColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor whiteColor];
            break;
        case 4:
            cell.backgroundColor = [UIColor grayColor];
            break;
        case 5:
            cell.backgroundColor = [UIColor redColor];
            break;
        case 6:
            cell.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            cell.backgroundColor = [UIColor blueColor];
            break;
        case 8:
            cell.backgroundColor = [UIColor cyanColor];
            break;
        case 9:
            cell.backgroundColor = [UIColor yellowColor];
            break;
        case 10:
            cell.backgroundColor = [UIColor magentaColor];
            break;
        case 11:
            cell.backgroundColor = [UIColor orangeColor];
            break;
        case 12:
            cell.backgroundColor = [UIColor purpleColor];
            break;
        case 13:
            cell.backgroundColor = [UIColor brownColor];
            break;
        case 14:
            cell.backgroundColor = [UIColor clearColor];
            break;
        default:
            cell.backgroundColor = [UIColor whiteColor];
            break;
    }
    return cell;
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.data = self.dataLists[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSArray *)dataLists {
    if (!_dataLists) {
        NSString *dataStr = @"[{\"icon\":\"tubiaozhizuomoban--_1\",\"title\":\"手机\",\"argu1_title_color\":\"acded2\",\"argu2_bg_color\":\"223344\",\"id\":\"1\"},{\"icon\":\"tubiaozhizuomoban--_2\",\"title\":\"杯子\",\"argu1_title_color\":\"111111\",\"argu2_bg_color\":\"22222\",\"id\":\"2\"},{\"icon\":\"tubiaozhizuomoban--_3\",\"title\":\"相机\",\"argu1_title_color\":\"712374\",\"argu2_bg_color\":\"34bd5f\",\"id\":\"3\"},{\"icon\":\"tubiaozhizuomoban--_4\",\"title\":\"日历\",\"argu1_title_color\":\"78bcda\",\"argu2_bg_color\":\"abc123\",\"id\":\"4\"},{\"icon\":\"tubiaozhizuomoban--_5\",\"title\":\"礼物\",\"argu1_title_color\":\"bcd23a\",\"argu2_bg_color\":\"ba2345\",\"id\":\"5\"},{\"icon\":\"tubiaozhizuomoban--_6\",\"title\":\"笔记\",\"argu1_title_color\":\"876543\",\"argu2_bg_color\":\"34532a\",\"id\":\"6\"},{\"icon\":\"tubiaozhizuomoban--_7\",\"title\":\"篮子\",\"argu1_title_color\":\"bbbaaa\",\"argu2_bg_color\":\"cacaca\",\"id\":\"7\"},{\"icon\":\"tubiaozhizuomoban--_8\",\"title\":\"铃铛\",\"argu1_title_color\":\"a8a8a8\",\"argu2_bg_color\":\"9d9d9d\",\"id\":\"8\"},{\"icon\":\"tubiaozhizuomoban--_9\",\"title\":\"书本\",\"argu1_title_color\":\"766aaa\",\"argu2_bg_color\":\"cacdab\",\"id\":\"9\"},{\"icon\":\"tubiaozhizuomoban--_10\",\"title\":\"日历\",\"argu1_title_color\":\"78bcda\",\"argu2_bg_color\":\"abc123\",\"id\":\"10\"},{\"icon\":\"tubiaozhizuomoban--_11\",\"title\":\"礼物\",\"argu1_title_color\":\"bcd23a\",\"argu2_bg_color\":\"ba2345\",\"id\":\"11\"},{\"icon\":\"tubiaozhizuomoban--_12\",\"title\":\"笔记\",\"argu1_title_color\":\"876543\",\"argu2_bg_color\":\"34532a\",\"id\":\"12\"},{\"icon\":\"tubiaozhizuomoban--_13\",\"title\":\"篮子\",\"argu1_title_color\":\"bbbaaa\",\"argu2_bg_color\":\"cacaca\",\"id\":\"13\"},{\"icon\":\"tubiaozhizuomoban--_14\",\"title\":\"铃铛\",\"argu1_title_color\":\"a8a8a8\",\"argu2_bg_color\":\"9d9d9d\",\"id\":\"14\"},{\"icon\":\"tubiaozhizuomoban--_15\",\"title\":\"书本\",\"argu1_title_color\":\"766aaa\",\"argu2_bg_color\":\"cacdab\",\"id\":\"15\"}]";
        _dataLists = [dataStr mj_JSONObject];
    }
    return _dataLists;
}

@end

//
//  HomeViewController.m
//  TableViewDemo
//
//  Created by gelei on 2020/4/3.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "GLRunloopTaskTool.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home VC";
    
    [GLRunloopTaskTool shareInstance];
    for (int i =0 ; i < 10; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 100 * i, 100, 20)];
        label.text = [NSString stringWithFormat:@"label_%d",i];
        [self.scrollView addSubview:label];
        [[GLRunloopTaskTool shareInstance] addTask:^{
            NSLog(@"========%d",i);
        } withKey:@(i)];
    }
    self.scrollView.contentSize = CGSizeMake(0, 100 * 10 + 10);
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [NSThread sleepForTimeInterval:2];
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (IBAction)enterAction:(id)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

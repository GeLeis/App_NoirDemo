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
#import "NSArray+GLSafe.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void(^clickHandle)(int index);
@property (nonatomic, assign) BOOL taskAdded;
@end

@implementation HomeViewController

//运算符重载
//- (id)objectAtIndexedSubscript:(NSUInteger)idx {
//    return @"objectAtIndexedSubscript";
//}
//
//- (id)objectForKeyedSubscript:(id)key {
//    return @"objectForKeyedSubscript";
//}

- (void)blockTest:(void(^)(void))block {
    block();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home VC";
    [self safeArrTest];
    [self safeDictionTest];
    [self blockTest:^() {
        NSLog(@"xxxBlock");
    }];
    [self safeStringTst];
    
    for (int i =0 ; i < 10; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 100 * i, 100, 20)];
        label.text = [NSString stringWithFormat:@"label_%d",i];
        [self.scrollView addSubview:label];
    }
    self.scrollView.contentSize = CGSizeMake(0, 100 * 10 + 10);
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"==");
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)safeArrTest {
    //@[@1]和[NSArray arrayWithObjects:@1, nil]不一样
    id arr = @[];
    [self logArr:arr];
    
    id obj = nil;
    arr = @[@1,obj];
    [self logArr:arr];
    
    arr = @[@1,@2,@3];
    [self logArr:arr];
    
    arr = [NSArray arrayWithObjects:@1,@2,@3, nil];
    [self logArr:arr];
    
    arr = [NSMutableArray arrayWithObjects:@1,@2,@3, nil];
    [arr insertObject:@4 atIndex:4];
    [arr removeObjectAtIndex:4];
    [arr replaceObjectAtIndex:4 withObject:@4];
    [self logArr:arr];
}

- (void)safeDictionTest {
    id dict = @{};
    id key = nil;
    id obj = nil;
    dict = @{@"a":@"A",key:@1,@"b":obj};
    dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"a",@1,@"b",@2, nil];
    
    [dict setObject:obj forKey:@"c"];
    dict[@"d"] = obj;
    [self logDic:dict];
}

- (void)safeStringTst{
    //长度为9或以下时,类型为NSTaggedPointerString
    NSString *stt = [NSString stringWithFormat:@"%@",@"123"];
    stt = [stt substringFromIndex:5];
    stt = [stt substringWithRange:NSMakeRange(0, 5)];
    NSLog(@"\nclass =%@   string =%@ ",stt.class,stt);
    NSLog(@"%d",[stt characterAtIndex:5]);
    
    NSMutableString *stt2 = [NSMutableString stringWithString:@"abcd"];
    id str = nil;
    [stt2 appendString:str];
    [stt2 appendFormat:str,1];
    [stt2 setString:str];
    [stt2 deleteCharactersInRange:NSMakeRange(1, 4)];
    NSLog(@"\nclass =%@   string =%@ ",stt2.class,stt2);
}

- (void)logArr:(NSArray *)arr {
    NSLog(@"arr= %@ ,object=%@",arr.class,[arr objectAtIndex:3]);
    NSLog(@"arr= %@ ,object=%@",arr.class,arr[3]);
    NSLog(@"\n----------------");
}

- (void)logDic:(NSDictionary *)dic {
    NSLog(@"\ndict_class=%@,dic=%@\n-----------",dic.class,dic);
}

- (IBAction)enterAction:(id)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)taskToolTest {
    //证明tasks执行过程中,同样可以执行主线程操作
    if (!self.taskAdded) {
        for (int i = 0; i < 20000; i++) {
            [GLRunloopTaskTool addTarget:self task:^{
                NSLog(@"excuteTask i=%d",i);
            }];
        }
        self.taskAdded = YES;
    } else {
        NSLog(@"touchesBegantouchesBegantouchesBegantouchesBegan");
    }
}
//判断是否为4的n次幂
- (BOOL)is4multiple:(int)n {
////      100  4
////    11000 16
//    if (n == 1) {
//        return YES;
//    }
//    return n < 8 ? !(n^4) : [self is4multiple:n>>2];
////    if (n < 8) {
////        return !(n^4);
////    }
////    return [self is4multiple:n>>2];
    /*
     1.n>0
     2.1只出现在奇数位
     3.只有1个1
     */
    //4个字节
    return (n&0xAAAAAAAA) == 0 && (n&(n-1)) == 0 && n > 0;
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

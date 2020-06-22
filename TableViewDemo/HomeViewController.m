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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home VC";
    
    [self safeArrTest];
    [self safeDictionTest];
    
    [self safeStringTst];
    
    [GLRunloopTaskTool shareInstance];
    for (int i =0 ; i < 10; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 100 * i, 100, 20)];
        label.text = [NSString stringWithFormat:@"label_%d",i];
        [self.scrollView addSubview:label];
    }
    self.scrollView.contentSize = CGSizeMake(0, 100 * 10 + 10);
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [NSThread sleepForTimeInterval:2];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

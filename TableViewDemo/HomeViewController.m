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
#import <libkern/OSAtomic.h>
#import "CALayer+GLSDImage.h"
#import <ReplayKit/ReplayKit.h>
#import <os/signpost.h>

#define SP_BEGIN_LOG(subsystem, category, name) \
os_log_t m_log_##name = os_log_create((#subsystem), (#category));\
os_signpost_id_t m_spid_##name = os_signpost_id_generate(m_log_##name);\
os_signpost_interval_begin(m_log_##name, m_spid_##name, (#name));

#define SP_END_LOG(name) \
os_signpost_interval_end(m_log_##name, m_spid_##name, (#name));

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void(^clickHandle)(int index);
@property (nonatomic, assign) BOOL taskAdded;
@property (atomic, assign) NSInteger num;
@property (nonatomic, strong) NSLock *lock;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (nonatomic, strong) CALayer *testLayer;
@property (nonatomic, assign) BOOL recording;
- (void)hometest;
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

- (void)checkPick1 {
    
}

- (void)checkPick2 {
    
}

- (void)viewDidLoad {
    SP_BEGIN_LOG(custome, gl_log, init);
    [super viewDidLoad];
    self.navigationItem.title = @"Home VC";
//    [self safeArrTest];
//    [self safeDictionTest];
//    [self blockTest:^() {
//        NSLog(@"xxxBlock");
//    }];
//    [self safeStringTst];
//    for (int i =0 ; i < 10; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 100 * i, 100, 20)];
//        label.text = [NSString stringWithFormat:@"label_%d",i];
//        [self.scrollView addSubview:label];
//    }
    self.scrollView.contentSize = CGSizeMake(0, 100 * 10 + 10);
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"==");
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self atomicTest];
    SP_END_LOG(init);
    [self layerTest];
}

- (void)layerTest {
    SP_BEGIN_LOG(custome, gl_log, layerTest);
    self.testLayer = [CALayer layer];
    //填充方式
    self.testLayer.contentsGravity = kCAGravityResizeAspectFill;
    //当前屏幕的缩放比例
    self.testLayer.contentsScale = [UIScreen mainScreen].scale;
    self.testLayer.backgroundColor = [UIColor redColor].CGColor;
    self.testLayer.frame = CGRectMake(50, 100, 50, 50);
    [self.view.layer addSublayer:self.testLayer];
    [self.testLayer glsd_setImageWithURL:[NSURL URLWithString:@"http://img2.ultimavip.cn/97c69f92b8e5d3a3"] placeholderImage:[UIImage imageNamed:@"tubiaozhizuomoban--_10"]];
    [self.testLayer glsd_setImageWithURL:[NSURL URLWithString:@"http://img2.ultimavip.cn/97c69f92b8e5d3a3"] placeholderImage:[UIImage imageNamed:@"tubiaozhizuomoban--_10"]];
    /*
     统计这段区间的执行次数,耗时,等等,更加直观
    SP_BEGIN_LOG(sysname, category, name);
     sysname:自定义,可以用bundleId
     category:在timeprofile中统计分类时使用,相同的扼categroy在同一个分类下
     name:具体统计名称
     */
    SP_END_LOG(layerTest);
}

- (NSArray<UIKeyCommand *> *)keyCommands {
    return @[[UIKeyCommand commandWithTitle:@"测试" image:nil action:@selector(keyTest) input:@" " modifierFlags:UIKeyModifierCommand propertyList:nil]];
}

- (void)keyTest {
    NSLog(@"keyTEst");
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [NSThread sleepForTimeInterval:2];
    NSLog(@"viewWillAppear");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    [NSThread sleepForTimeInterval:2];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    SP_BEGIN_LOG(custome, gl_log, viewDidLayoutSubviews);
    [super viewDidLayoutSubviews];
//    [NSThread sleepForTimeInterval:2];
   NSLog(@"viewDidLayoutSubviews");
    SP_END_LOG(viewDidLayoutSubviews);
}

- (void)viewDidAppear:(BOOL)animated {
    SP_BEGIN_LOG(custome, gl_log, viewDidAppear);
    [super viewDidAppear:animated];
//    [NSThread sleepForTimeInterval:2];
    [self.view bringSubviewToFront:self.enterBtn];
    NSLog(@"viewDidAppear");
    SP_END_LOG(viewDidAppear);
    
    
    os_log_t m_log = os_log_create("custome", "gl_log");\
    for(int i = 0; i < 10; i++) {
        os_signpost_id_t signid_1 = os_signpost_id_generate(m_log);
        os_signpost_interval_begin(m_log, signid_1, "asynctest");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"打印的第%d遍",i);
            os_signpost_interval_end(m_log, signid_1, "asynctest", "index%d",i);
        });
    }
}

- (void)atomicTest {
    self.lock = [[NSLock alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i=0; i<1000; i++) {
//            [self.lock lock];
            self.num = self.num + 1;
//            [self.lock unlock];
        }
    });
    dispatch_async(queue, ^{
        for (int i=0; i<1000; i++) {
//            [self.lock lock];
            self.num = self.num + 1;
//            [self.lock unlock];
        }
    });
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
    CGRect frame = self.testLayer.frame;
    
    self.testLayer.frame = CGRectMake(frame.origin.x, frame.origin.y + 50, frame.size.width, frame.size.height);
//    self.enterBtn.layer.frame = CGRectMake(frame.origin.x, frame.origin.y + 50, frame.size.width, frame.size.height);
    [self replaykitTest];
    SP_BEGIN_LOG(fourpage, init, layerTest);
    SP_END_LOG(layerTest);
}

- (void)replaykitTest {
    if (self.recording) {
        self.recording = YES;
        [[RPScreenRecorder sharedRecorder] startCaptureWithHandler:^(CMSampleBufferRef  _Nonnull sampleBuffer, RPSampleBufferType bufferType, NSError * _Nullable error) {
            NSLog(@"xxx");
        } completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"error = %@",error);
            }
        }];
    } else {
        [[RPScreenRecorder sharedRecorder] stopCaptureWithHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"error = %@",error);
            }
        }];
        self.recording = NO;
    }
}

int maxProfit(int* prices, int pricesSize){
    if (pricesSize <= 1) {
        return 0;
    }
    int val = 0;
    int lastval = 0;
    int lowp = prices[0];
    int highp = prices[0];
    for (int i = 1; i < pricesSize; i++) {
        if (lowp == highp) {
            if (prices[i] <= lowp) {
                lowp = prices[i];
                highp = lowp;
            } else {
                highp = prices[i];
                if (i < pricesSize - 1) {
                    continue;
                }
            }
        } else if(prices[i] > highp) {
            highp = prices[i];
            if (i < pricesSize - 1) {
                continue;
            }
        }
        if (highp - lowp >  val / 2) {
            val = fmax(lastval,val - lastval) + highp - lowp;
            lastval = highp - lowp;
            lowp = prices[i];
            highp = lowp;
        }
    }
    return val;
}


//自定义x的n次幂
double myPow(double x, int n){
    if (x == 0 ) {
        return 0;
    }
    if (n == 0) {
        return 1;
    }
    //正数
    bool positive = n > 0;
    int fabn = fabs(n);
    double val = 1;
    //1 11 111,
    double tmp[32] = {x};

    //10进制转2进制,111111111
    //             1010101001
    int i = 0;
    while (fabn > 0) {
        if (fabn % 2 == 1) {
            val = val * tmp[i];
        }
        fabn = fabn / 2;
        tmp[++i] = tmp[i] * tmp[i];
    }
    return positive ? val : 1 / val;
}

//跳跃游戏
int jump(int* nums, int numsSize){
    int end = 0;
    int maxP = 0;
    int step = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        maxP = fmaxf(maxP, nums[i] + i);
        if (i == end) {
            step++;
            end = maxP;
        }
    }
    return step;
}

//链表反转
struct ListNode* reverseList(struct ListNode* head){
    if (head == NULL) {
        return NULL;
    }
    struct ListNode *node = head;
    struct ListNode *next = NULL;
    while (node->next) {
        struct ListNode *tmp = node->next;
        node->next = next;
        next = node;
        node = tmp;
    }
    node->next = next;
    return node;
}

//删除链表倒数第二个元素
struct ListNode* removeNthFromEnd(struct ListNode* head, int n){
    //新增一个头节点方便处理删除头部的情况
    struct ListNode *pre = (struct ListNode *)malloc(sizeof(struct ListNode) * 1);
    pre->next = head;
    struct ListNode *first = pre;
    struct ListNode *second = pre;
    //0,1,2,   3,4,5,6
    //s   f    f
    while (first->next) {
        first = first->next;
        if (n > 0) {
            n--;
        } else {
            second = second->next;
        }
    }
    second->next = second->next->next;
    return pre->next;
}

struct ListNode {
    int val;
    struct ListNode *next;
};
//合并两个有序链表
struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2){
    if (l1 == NULL) {
        return l2;
    }
    if (l2 == NULL) {
        return l1;
    }
    struct ListNode *head = (struct ListNode *)malloc(sizeof(struct ListNode) * 1);
    struct ListNode *tmp = head;
    while(l1 && l2) {
        if (l1->val <= l2->val) {
            tmp->next = l1;
            l1 = l1->next;
    
        } else {
            tmp->next = l2;
            l2 = l2->next;
        }
        tmp = tmp->next;
    }
    if (l1) tmp->next = l1;
    if (l2) tmp->next = l2;
    return head->next;
}

//最长有效括号,通过栈去保存栈顶数据
int longestValidParentheses(char * s){
    int max= 0 ;
    int top= -1 ;
    int sLen = strlen(s);
    int st[sLen+1];
    st[++top] = -1;
    for (int i = 0; i < sLen; i++) {
        if (s[i] == '(') {
            st[++top] = i;
        } else {
            --top;
            if (top == -1) {
                st[++top] = i;
            } else {
                max = fmax(max, i - st[top]);
            }
        }
    }
    return max;
    
}

int* divingBoard(int shorter, int longer, int k, int* returnSize){
    //i块短板,k-i块长板,i从k到0,短板越多,值越小
    if (k == 0) {
        int *result = (int *)malloc(sizeof(int) * (1));
        result[0] = 0;
        return result;
    }
    if (shorter == longer) {
        int *result = (int *)malloc(sizeof(int) * (1));
        result[0] = k*shorter;
        return result;
    };
    int *result = (int *)malloc(sizeof(int) * (k+1));
    for (int i = k;i >=0;i--) {
        result[k - i] = i * shorter + (k - i) * longer;
    }
    return result;
}
//不同路径问题
int uniquePaths(int m, int n){
    //定一个一个二维数组
    int **board = (int **)malloc(sizeof(int *) * n);
    for (int i = 0; i < n; i++) {
        board[i] = (int *)malloc(sizeof(int) * m);
    }
    for (int i = 0 ; i < n; i++) {
        for (int j = 0 ; j < m; j++) {
            if (i == 0 &&  j== 0) {
                board[i][j]= 1;
            } else if (i > 0 && j == 0) {
                board[i][j] = board[i - 1][j];
            } else if (i == 0 && j > 0) {
                board[i][j] = board[i][j - 1];
            } else {
                board[i][j] = board[i - 1][j] + board[i][j - 1];
            }
        }
    }
    return board[n - 1][m - 1];
}

- (void)osspinLockThreadTest {
    for (int i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
            OSSpinLockLock(&aspect_lock);
            NSLog(@"osspinLockThreadTest i = %d",i);
            OSSpinLockUnlock(&aspect_lock);
        });
    }
}

bool isMatch(char* s, char* p){
    int slenght = (int)strlen(s);
    int plenght = (int)strlen(p);
    //首先判断非空
    if (slenght == 0 || plenght == 0) {
        return slenght+plenght == 0;
    }
    //长度为1
    if (slenght == 1 && plenght == 1) {
        return s[0] == p[0] || p[0] == '.';
    }
    //*存在0和多个,两种情况
    int pIndex = 0;
    int sIndex = 0;
    while (sIndex < slenght && pIndex < plenght) {
        //第一个元素必须匹配
        if (p[pIndex] == '.' && (pIndex < plenght - 1 ? p[pIndex + 1] != '*' : true)) {
            p[pIndex] = s[sIndex];
        }
        bool firstMatch = s[sIndex] == p[pIndex] || p[pIndex] == '.';
        if (firstMatch) {
            if (p[pIndex + 1] != '*') {
                pIndex++;
            }
            sIndex++;
        } else {
            pIndex+=2;
        }
    }
    return true;
}

int fib(int n){
    if (n < 3) {
        return 1;
    }
    int a = 1,b=1,c = 0;
    for (int i = 3; i <=n; i++) {
        c=a+b;
        a=b;
        b=c;
    }
    return c;
}

int numDecodings(char * s) {
    int i     = 0;
    int size  = 0;
    int res   = 0;
    int n_1   = 0;
    int n_2   = 0;
    size      = strlen(s);
    
    /***********************************************************
    1、s[i] = 0时，若s[i-1]是1或2，则dp[i] = dp[i-2]，否则解码出错
    2、else if s[i-1]是1，dp[i] = dp[i-1] + dp[i-2]
    3、else if s[i-1]是2，且s[i]小于7，dp[i] = dp[i-1] + dp[i-2]
    4、else dp[i] = dp[i-1]
    ***********************************************************/
    if('0' == s[0])
    {
        return 0;
    }

    n_2 = 1;
    n_1 = 1;
    res = 1;

    for(i = 1;i<size;i++)
    {
        if('0' == s[i])
        {
            if(('1' == s[i-1])||('2' == s[i-1]))
            {
                res = n_2;
            }
            else
            {
                return 0;
            }
        }
        else if('1' == s[i-1])
        {
            res = n_2 + n_1;
        }
        else if(('2' == s[i-1])&&(s[i] < '7'))
        {
            res = n_2 + n_1;
        }
        else
        {
            res = n_1;
        }
        
        n_2 = n_1;
        n_1 = res;
    }
    return res;
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

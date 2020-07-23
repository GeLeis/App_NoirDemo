//
//  DetailViewController.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "DetailViewController.h"
#import <YLT_Kit/YLT_Kit.h>
#import "DataManager.h"
#import "FavoriteViewController.h"

@interface DetailViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIButton *shoucBtn;
@property (nonatomic, strong) UIButton *shoucListBtn;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情";
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

//UI配置
- (void)setup {
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    [self.view addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgView);
        make.top.equalTo(self.imgView.mas_bottom).offset(15);
    }];
    
    UIBarButtonItem *shouCBar = [[UIBarButtonItem alloc] initWithCustomView:self.shoucBtn];
    UIBarButtonItem *shouCListBar = [[UIBarButtonItem alloc] initWithCustomView:self.shoucListBtn];
    self.navigationItem.rightBarButtonItems = @[shouCListBar,shouCBar];
    
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollview.backgroundColor = [UIColor greenColor];
    scrollview.contentSize = CGSizeMake(300, 600);
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
        make.centerX.equalTo(self.titleLbl);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
    
    
    for (int i = 0; i < 10; i++) {
        UILabel *subview = [[UILabel alloc] init];
        subview.frame = CGRectMake(0, 60 * i, 20, 20);
        subview.text = [NSString stringWithFormat:@"%d",i];
        [scrollview addSubview:subview];
    }
}
//数据配置
- (void)loadData {
    self.view.backgroundColor = [UIColor ylt_colorWithHexString:self.data[@"argu2_bg_color"]];
    self.imgView.image = [UIImage imageNamed:self.data[@"icon"]];
    self.titleLbl.text = self.data[@"title"];
    self.titleLbl.textColor = [UIColor ylt_colorWithHexString:self.data[@"argu1_title_color"]];
    self.shoucBtn.selected = NO;
    for (NSDictionary *data in [DataManager dataManager].favorites) {
        if ([data[@"id"] isEqualToString:self.data[@"id"]]) {
            self.shoucBtn.selected = YES;
            break;
        }
    }
}

- (void)shouCBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    DataManager *manager = [DataManager dataManager];
    if (sender.selected) {
        [manager addFavorites:self.data];
    } else {
        [manager removeFavorites:self.data];
        
    }
}

- (void)shouCListBtnClick:(UIButton *)sender {
    FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] init];
    [self.navigationController pushViewController:favoriteVC animated:YES];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:16];
    }
    return _titleLbl;
}

- (UIButton *)shoucBtn {
    if (!_shoucBtn) {
        _shoucBtn = [[UIButton alloc] init];
        [_shoucBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_shoucBtn setImage:[UIImage imageNamed:@"shoucangchenggong"] forState:UIControlStateSelected];
        [_shoucBtn addTarget:self action:@selector(shouCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoucBtn;
}

- (UIButton *)shoucListBtn {
    if (!_shoucListBtn) {
        _shoucListBtn = [[UIButton alloc] init];
        _shoucListBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_shoucListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_shoucListBtn setTitle:@"列表" forState:UIControlStateNormal];
        [_shoucListBtn addTarget:self action:@selector(shouCListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoucListBtn;
}


@end

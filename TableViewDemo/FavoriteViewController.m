//
//  FavoriteViewController.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "FavoriteViewController.h"
#import <YLT_Kit.h>
#import "DataManager.h"
#import "TableViewListCell.h"

@interface FavoriteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *clearBtn;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *clearCBar = [[UIBarButtonItem alloc] initWithCustomView:self.clearBtn];
    self.navigationItem.rightBarButtonItem = clearCBar;
}

- (void)clearClick:(UIButton *)sender {
    [[DataManager dataManager] removeAll];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataManager dataManager].favorites.count;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//获取cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewListCell.class) forIndexPath:indexPath];
    cell.data = [DataManager dataManager].favorites[indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor ylt_randomColor];
        [_tableView registerClass:TableViewListCell.class forCellReuseIdentifier:NSStringFromClass(TableViewListCell.class)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc] init];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearBtn setTitle:@"清空" forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}

@end

//
//  TableViewListCell.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "TableViewListCell.h"
#import <YLT_Kit.h>

@interface TableViewListCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLbl;
@end

@implementation TableViewListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    [self addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgView);
        make.left.equalTo(self.imgView.mas_right).offset(16);
    }];
}

- (void)setData:(NSDictionary *)data {
//    self.backgroundColor = [UIColor ylt_colorWithHexString:data[@"argu2_bg_color"]];
    NSArray *imgs = @[
        @"http://img2.ultimavip.cn/97c69f92b8e5d3a3",
        @"http://img2.ultimavip.cn/28202b68fe391619",
        @"http://img2.ultimavip.cn/b6ff86ccee4d3bf8",
        @"http://img2.ultimavip.cn/b646d7ec96eaa81b",
        @"http://img2.ultimavip.cn/315954bddabf3c22"
    ];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgs[arc4random_uniform(5)]]];
//    self.imgView.image = [UIImage imageNamed:data[@"icon"]];
    self.titleLbl.text = data[@"title"];
    self.titleLbl.textColor = [UIColor ylt_colorWithHexString:data[@"argu1_title_color"]];
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

@end

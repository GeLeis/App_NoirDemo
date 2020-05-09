//
//  YLT_CollectionReusableView.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/28.
//

#import "YLT_CollectionReusableView.h"
#import "UILabel+YLT_Create.h"
#import "UIView+YLT_Create.h"
#import "UICollectionReusableView+YLT_Create.h"

@interface YLT_CollectionReusableView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YLT_CollectionReusableView

- (void)ylt_configUI {
    self.titleLabel = UILabel.ylt_createLayout(self, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self).inset(8);
    }).ylt_convertToLabel().ylt_textColor(UIColor.blackColor).ylt_font([UIFont systemFontOfSize:12]);
}

- (void)ylt_indexPath:(NSIndexPath *)indexPath bindData:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        self.titleLabel.text = data;
    }
}

@end

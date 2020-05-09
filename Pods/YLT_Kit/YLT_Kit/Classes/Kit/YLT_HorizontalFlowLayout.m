//
//  YLT_CollectionViewFlowLayout.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import "YLT_HorizontalFlowLayout.h"

@implementation YLT_HorizontalFlowLayoutModel

+ (YLT_HorizontalFlowLayoutModel *)ylt_modelWithPreRow:(NSUInteger)countPreRow row:(NSInteger)row {
    YLT_HorizontalFlowLayoutModel *model = [[YLT_HorizontalFlowLayoutModel alloc] init];
    model.ylt_countPreRow = countPreRow;
    model.ylt_row = row;
    return model;
}

@end

@implementation YLT_HorizontalFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    _ylt_sectionDic = [NSMutableDictionary dictionary];
    self.ylt_allAttributes = [NSMutableArray array];
    //获取section的数量
    NSUInteger section = [self.collectionView numberOfSections];
    for (int sec = 0; sec < section; sec++) {
        //获取每个section的cell个数
        NSUInteger count = [self.collectionView numberOfItemsInSection:sec];
        for (NSUInteger item = 0; item<count; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:sec];
            //重新排列
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.ylt_allAttributes addObject:attributes];
        }
    }
}

- (CGSize)collectionViewContentSize {
    //每个section的页码的总数
    NSInteger actualLo = 0;
    for (NSString *key in [_ylt_sectionDic allKeys]) {
        actualLo += [_ylt_sectionDic[key] integerValue];
    }
    return CGSizeMake(actualLo*self.collectionView.frame.size.width, self.collectionView.contentSize.height);
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if(attributes.representedElementKind != nil) {
        return;
    }
    //    if (attributes.indexPath.row==20) {
    //        self.itemSize = CGSizeMake(200, 200);
    //    }
    
    //collectionView 的宽度
    CGFloat width = self.collectionView.frame.size.width;
    //collectionView 的高度
    CGFloat height = self.collectionView.frame.size.height;
    //每个attributes的下标值 从0开始
    NSInteger itemIndex = attributes.indexPath.item;
    
    CGFloat stride = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) ? width : height;
    
    //获取现在的attributes是第几组
    NSInteger section = attributes.indexPath.section;
    //获取每个section的item的个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
    
    CGFloat offset = section * stride;
    
    CGFloat cellwidth = self.itemSize.width;
    CGFloat cellheight = self.itemSize.height;
    
    if (_ylt_sectionConfigs.count != 0 && _ylt_sectionConfigs.count > attributes.indexPath.section) {
        cellwidth = width/((CGFloat)_ylt_sectionConfigs[attributes.indexPath.section].ylt_countPreRow);
        cellheight = height/((CGFloat)_ylt_sectionConfigs[attributes.indexPath.section].ylt_row);
    }
    //计算x方向item个数
    NSInteger xCount = (width / cellwidth);
    //计算y方向item个数
    NSInteger yCount = (height / cellheight);
    //计算一页总个数
    NSInteger allCount = (xCount * yCount);
    //获取每个section的页数，从0开始
    NSInteger page = itemIndex / allCount;
    
    //余数，用来计算item的x的偏移量
    NSInteger remain = (itemIndex % xCount);
    
    //取商，用来计算item的y的偏移量
    NSInteger merchant = (itemIndex-page*allCount)/xCount;
    
    //x方向每个item的偏移量
    CGFloat xCellOffset = remain * cellwidth + self.minimumInteritemSpacing * remain;
    //y方向每个item的偏移量
    CGFloat yCellOffset = merchant * cellheight + self.minimumLineSpacing * merchant;
    
    //获取每个section中item占了几页
    NSInteger pageRe = (itemCount % allCount == 0)? (itemCount / allCount) : (itemCount / allCount) + 1;
    //将每个section与pageRe对应，计算下面的位置
    [_ylt_sectionDic setValue:@(pageRe) forKey:[NSString stringWithFormat:@"%ld", section]];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        NSInteger actualLo = 0;
        //将每个section中的页数相加
        for (NSString *key in [_ylt_sectionDic allKeys]) {
            actualLo += [_ylt_sectionDic[key] integerValue];
        }
        //获取到的最后的数减去最后一组的页码数
        actualLo -= [_ylt_sectionDic[[NSString stringWithFormat:@"%ld", [_ylt_sectionDic allKeys].count-1]] integerValue];
        xCellOffset += page*width + actualLo*width;
    } else {
        yCellOffset += offset;
    }
    attributes.frame = CGRectMake(xCellOffset, yCellOffset, cellwidth, cellheight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    [self applyLayoutAttributes:attr];
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.ylt_allAttributes;
}

@end


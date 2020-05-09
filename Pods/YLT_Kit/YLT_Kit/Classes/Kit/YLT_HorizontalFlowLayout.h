//
//  YLT_CollectionViewFlowLayout.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import <UIKit/UIKit.h>

@interface YLT_HorizontalFlowLayoutModel : NSObject

/**
 每行多少个
 */
@property (nonatomic, assign) NSUInteger ylt_countPreRow;

/**
 多少行
 */
@property (nonatomic, assign) NSUInteger ylt_row;

+ (YLT_HorizontalFlowLayoutModel *)ylt_modelWithPreRow:(NSUInteger)countPreRow row:(NSInteger)row;

@end

@interface YLT_HorizontalFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) NSMutableDictionary *ylt_sectionDic;

@property (strong, nonatomic) NSMutableArray *ylt_allAttributes;

/**
 块配置信息
 */
@property (nonatomic, strong) NSArray<YLT_HorizontalFlowLayoutModel *> *ylt_sectionConfigs;

@end


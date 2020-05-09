//
//  YLT_ImageFilter.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YLT_ImageFilterType) {
    YLT_ImageFilterTypeTemperatureAndTint,//色温
    YLT_ImageFilterTypeCount
};

@interface YLT_ImageFilter : NSObject
/**
 原图
 */
@property (nonatomic, strong) UIImage *originImage;
/**
 输出图
 */
@property (nonatomic, strong) UIImage *outputImage;
/**
 滤镜类型
 */
@property (nonatomic, assign) YLT_ImageFilterType filterType;
/**
 滤镜强度 -100 ~ 100
 */
@property (nonatomic, assign) CGFloat filterValue;
/**
 滤镜强度2 -100 ~ 100
 */
@property (nonatomic, assign) CGFloat filterValue2;

/**
 图片增加滤镜

 @param originImage 原图
 @param filterType 滤镜类型
 @param value 滤镜强度
 @param value2 滤镜强度2
 @param completion 回调
 @return 实例
 */
+ (YLT_ImageFilter *)filterImage:(UIImage *)originImage
              filterType:(YLT_ImageFilterType)filterType
                   value:(CGFloat)value
                          value2:(CGFloat)value2
                      completion:(void(^)(UIImage *outputImage))completion;

@end

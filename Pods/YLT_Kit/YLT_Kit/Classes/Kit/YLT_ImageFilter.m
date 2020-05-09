//
//  YLT_ImageFilter.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/12.
//

#import "YLT_ImageFilter.h"
#import <CoreImage/CoreImage.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface YLT_ImageFilter () {
}
/**
 滤镜数据
 */
@property (nonatomic, strong) NSDictionary *filterDatas;
/**
 滤镜
 */
@property (nonatomic, strong) CIFilter *filter;

@property (nonatomic, copy) void(^completion)(UIImage *outputImage);

@end

@implementation YLT_ImageFilter

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
                      completion:(void(^)(UIImage *outputImage))completion {
    YLT_ImageFilter *imageFilter = [[YLT_ImageFilter alloc] init];
    imageFilter.completion = completion;
    imageFilter.originImage = originImage;
    imageFilter.filterType = filterType;
    imageFilter.filterValue = value;
    imageFilter.filterValue2 = value2;
    @weakify(imageFilter);
    [[RACObserve(imageFilter, outputImage) takeUntil:imageFilter.rac_willDeallocSignal] subscribeNext:^(UIImage *x) {
        @strongify(imageFilter);
        if (imageFilter.completion) {
            imageFilter.completion(x);
        }
    }];
    
    return imageFilter;
}

- (NSString *)filternameFromType:(YLT_ImageFilterType)type {
    switch (type) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
            return @"CITemperatureAndTint";
        }
            break;
            
        default:
            break;
    }
    return @"";
}

- (void)setFilterValue:(CGFloat)filterValue {
    _filterValue = filterValue;
    CGFloat value = (filterValue+100.)/200.;
    switch (self.filterType) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
            [self.filter setValue:[[CIVector alloc] initWithX:6200 Y:0] forKey:@"inputNeutral"];
            [self.filter setValue:[[CIVector alloc] initWithX:6200 Y:value*4.0*100] forKey:@"inputTargetNeutral"];
        }
            break;
            
        default:
            break;
    }
    CIImage *outputImage = [self.filter outputImage];
    self.outputImage = [UIImage imageWithCIImage:outputImage];
}

- (void)setFilterValue2:(CGFloat)filterValue2 {
    _filterValue2 = filterValue2;
    CGFloat value = (filterValue2+100.)/200.;
    switch (self.filterType) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
        }
            break;
            
        default:
            break;
    }
    CIImage *outputImage = [self.filter outputImage];
    self.outputImage = [UIImage imageWithCIImage:outputImage];
}

- (void)setFilterType:(YLT_ImageFilterType)filterType {
    _filterType = filterType;
    NSString *filtername = [self filternameFromType:filterType];
    if (!(self.filter && [self.filter.name isEqualToString:filtername])) {
        self.filter = [CIFilter filterWithName:filtername];
        [self.filter setDefaults];
        [self.filter setValue:[[CIImage alloc] initWithImage:self.originImage] forKey:kCIInputImageKey];
    }
}

@end

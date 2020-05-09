//
//  UIImage+YLT_Extension.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIImage+YLT_Extension.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <YLT_BaseLib/YLT_BaseLib.h>

NS_INLINE CGRect TC_CGRectFloorIntegral(CGRect rect)
{
    return CGRectMake((size_t)rect.origin.x, (size_t)rect.origin.y, (size_t)rect.size.width, (size_t)rect.size.height);
}

static CGBitmapInfo const kTCDefaultBitMapOrder = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst;

@implementation UIImage (YLT_Extension)

/**
 通过颜色获取纯色的图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)ylt_imageWithColor:(UIColor *)color {
    return [UIImage ylt_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)ylt_imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame {
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)ylt_renderColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ylt_imageNamed:(NSString *)imageName {
    if (!imageName.ylt_isValid) {
        return nil;
    }
    UIImage *result = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    if (result == nil) {
        NSArray *array = [imageName componentsSeparatedByString:@"/"];
        NSString *bundleName = nil;
        NSString *type = @"png";
        NSString *name = imageName;
        NSMutableString *dir = nil;
        if (array.count == 1) {
            result = [UIImage imageNamed:imageName];
        } else if (array.count > 1) {
            for (NSString *path in array) {
                if ([path hasPrefix:@".bundle"]) {
                    bundleName = path;
                } else if ([path rangeOfString:@"."].location != NSNotFound) {
                    NSArray *nameList = [path componentsSeparatedByString:@"."];
                    name = nameList[0];
                    if ([name hasSuffix:@"@2x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
                    }
                    if ([name hasSuffix:@"@3x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
                    }
                    type = nameList[1];
                } else {
                    if (dir == nil) {
                        dir = [[NSMutableString alloc] init];
                    }
                    [dir appendFormat:@"%@/", path];
                }
            }
            
            result = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForAuxiliaryExecutable:[NSString stringWithFormat:@"%@.bundle", bundleName]]]?:[NSBundle bundleForClass:[self class]] pathForResource:name ofType:type?:@"png" inDirectory:dir]];
        }
    }
    
    return result;
}

/**
 绘制圆角图片
 
 @return 圆角图片
 */
- (UIImage *)ylt_drawCircleImage {
    CGFloat x = (self.size.width>self.size.height)?(self.size.width-self.size.height)/2.:0;
    CGFloat y = (self.size.width>self.size.height)?0:(self.size.height-self.size.width)/2.;
    CGFloat width = (self.size.width>self.size.height)?self.size.height:self.size.width;
    CGRect bounds = CGRectMake(0, 0, width, width);
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2., width/2.) radius:width/2. startAngle:0 endAngle:M_PI*2. clockwise:YES] addClip];
    [self drawInRect:CGRectMake(-x, -y, self.size.width, self.size.height)];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

/**
 绘制圆角
 
 @param radius 圆角
 @return 圆角图
 */
- (UIImage *)ylt_drawRectImage:(CGFloat)radius {
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius] addClip];
    [self drawInRect:bounds];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

//对图片尺寸进行压缩--
- (UIImage*)ylt_scaledToSize:(CGSize)size {
    return [self ylt_scaledToSize:size highQuality:NO];
}

/**
 压缩最大边框为 maxLength 的图片
 
 @param maxLength 最大的边长
 @return 压缩图
 */
- (UIImage *)ylt_scaledToMaxLength:(CGFloat)maxLength {
    if (self.size.width <= maxLength && self.size.height <= maxLength) {
        return self;
    }
    CGSize size = self.size;
    if (self.size.width > self.size.height) {
        size.width = maxLength;
        size.height = size.width*self.size.height/self.size.width;
    } else {
        size.height = maxLength;
        size.width = size.height*self.size.width/self.size.height;
    }
    return [self ylt_scaledToSize:size];
}

- (UIImage*)ylt_scaledToSize:(CGSize)size highQuality:(BOOL)highQuality {
    UIImage *sourceImage = self;
    UIImage *newImage = self;
    @try {
        CGSize imageSize = sourceImage.size;
        CGFloat scaleFactor = 0.0;
        if (CGSizeEqualToSize(imageSize, size) == NO) {
            CGFloat widthFactor = size.width / imageSize.width;
            CGFloat heightFactor = size.height / imageSize.height;
            if (widthFactor < heightFactor)
                scaleFactor = heightFactor; // scale to fit height
            else
                scaleFactor = widthFactor; // scale to fit width
        }
        CGFloat targetWidth = imageSize.width* scaleFactor;
        CGFloat targetHeight = imageSize.height* scaleFactor;
        
        size = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
        if (highQuality) {
            UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        }else{
            UIGraphicsBeginImageContext(size); // this will crop
        }
        [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage == nil){
            newImage = sourceImage;
        }
        UIGraphicsEndImageContext();
    } @catch (NSException *e) {
    } @finally {
        return newImage;
    }
}

+ (UIImage *)ylt_fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage*) ylt_thumbnailImageForVideo:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    NSError *thumbnailImageGenerationError = nil;
    //CMTimeMake(a,b),a为第几帧开始，b为每秒多少帧，copyCGImageAtTime获取该时间点的帧图片
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(0, 10)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef) {
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    }
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (UIImage *)ylt_fullResolutionImageFromALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

+ (UIImage *)ylt_fullScreenImageALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullScreenImage];//fullScreenImage已经调整过方向了
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    return img;
}

//截取当前屏幕
+ (UIImage *)ylt_screenshotImage {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
    }
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ylt_convertViewToImage:(UIView *)view {
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)ylt_colorAtPixel:(CGPoint)point {
    
    // Cancel if point is outside image coordinates
    
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        
        return nil;
        
    }
    NSInteger pointX = trunc(point.x);
    
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = self.CGImage;
    
    NSUInteger width = self.size.width;
    
    NSUInteger height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    int bytesPerPixel = 4;
    
    int bytesPerRow = bytesPerPixel * 1;
    
    NSUInteger bitsPerComponent = 8;
    
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 
                                                 1,
                                                 
                                                 1,
                                                 
                                                 bitsPerComponent,
                                                 
                                                 bytesPerRow,
                                                 
                                                 colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    
    // Draw the pixel we are interested in onto the bitmap context
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    
    CGFloat red = (CGFloat)pixelData[0] / 255.0f;
    
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    
    CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
    
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//交换
static inline void SwapRGB(int *a, int *b) {
    *a+=*b;
    *b=*a-*b;
    *a-=*b;
}
//范围
static inline void CheckRGB(int *Value) {
    if (*Value < 0) *Value = 0;
    else if (*Value > 255) *Value = 255;
}
//赋值
static inline void AssignRGB(int *R, int *G, int *B, int intR, int intG, int intB) {
    *R = intR;
    *G = intG;
    *B = intB;
}
//设置明亮
static void SetBright(int *R, int *G, int *B, int bValue) {
    int intR = *R;
    int intG = *G;
    int intB = *B;
    if (bValue > 0)
    {
        intR = intR + (255 - intR) * bValue / 255;
        intG = intG + (255 - intG) * bValue / 255;
        intB = intB + (255 - intB) * bValue / 255;
    }
    else if (bValue < 0)
    {
        intR = intR + intR * bValue / 255;
        intG = intG + intG * bValue / 255;
        intB = intB + intB * bValue / 255;
    }
    CheckRGB(&intR);
    CheckRGB(&intG);
    CheckRGB(&intB);
    AssignRGB(R, G, B, intR, intG, intB);
}
//设置色相和饱和度
static void SetHueAndSaturation(int *R, int *G, int *B, int hValue, int sValue) {
    int intR = *R;
    int intG = *G;
    int intB = *B;
    
    if (intR < intG)
        SwapRGB(&intR, &intG);
    if (intR < intB)
        SwapRGB(&intR, &intB);
    if (intB > intG)
        SwapRGB(&intB, &intG);
    
    int delta = intR - intB;
    if (!delta) return;
    
    int entire = intR + intB;
    int H, S, L = entire >> 1;  //右移一位其实就是除以2（很巧妙）
    if (L < 128)
        S = delta * 255 / entire;
    else
        S = delta * 255 / (510 - entire);
    
    if (hValue) {
        if (intR == *R)
            H = (*G - *B) * 60 / delta;
        else if (intR == *G)
            H = (*B - *R) * 60 / delta + 120;
        else
            H = (*R - *G) * 60 / delta + 240;
        H += hValue;
        if (H < 0) H += 360;
        else if (H > 360) H -= 360;
        int index = H / 60;
        int extra = H % 60;
        if (index & 1) extra = 60 - extra;
        extra = (extra * 255 + 30) / 60;
        intG = extra - (extra - 128) * (255 - S) / 255;
        int Lum = L - 128;
        if (Lum > 0)
            intG += (((255 - intG) * Lum + 64) / 128);
        else if (Lum < 0)
            intG += (intG * Lum / 128);
        CheckRGB(&intG);
        switch (index) {
            case 1:
                SwapRGB(&intR, &intG);
                break;
            case 2:
                SwapRGB(&intR, &intB);
                SwapRGB(&intG, &intB);
                break;
            case 3:
                SwapRGB(&intR, &intB);
                break;
            case 4:
                SwapRGB(&intR, &intG);
                SwapRGB(&intG, &intB);
                break;
            case 5:
                SwapRGB(&intG, &intB);
                break;
        }
    } else {
        intR = *R;
        intG = *G;
        intB = *B;
    }
    if (sValue) {
        if (sValue > 0) {
            sValue = sValue + S >= 255? S: 255 - sValue;
            sValue = 65025 / sValue - 255;
        }
        intR += ((intR - L) * sValue / 255);
        intG += ((intG - L) * sValue / 255);
        intB += ((intB - L) * sValue / 255);
        CheckRGB(&intR);
        CheckRGB(&intG);
        CheckRGB(&intB);
    }
    AssignRGB(R, G, B, intR, intG, intB);
}

static CGContextRef RequestImagePixelData(CGImageRef inImage) {
    CGContextRef context = NULL;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    size_t bitmapBytesPerRow    = (pixelsWide * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //size_t bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh);
    //bitmapData = malloc( bitmapByteCount );   //当年背时的用到了它，就悲剧了(申请的内存没有初使化)
    void *bitmapData = calloc( pixelsWide*pixelsHigh,4);
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    
    CGRect rect = {{0,0},{pixelsWide, pixelsHigh}};
    CGContextDrawImage(context, rect, inImage);
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

/**
 改变图片的显示色调、明暗等
 
 @param hue 色调
 @param saturation 饱和度
 @param bright 透明度
 @return 改变后的图片
 */
- (UIImage *)ylt_imageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright {
    if (hue==0&&saturation==0&&bright==0) {
        UIImage *my_Image=nil;
        if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            my_Image=[UIImage imageWithCGImage:[self CGImage] scale:self.scale orientation:self.imageOrientation];
        }else {
            my_Image = [UIImage imageWithCGImage:[self CGImage]];
        }
        return my_Image;
    }
    saturation = (saturation>1)?saturation:(saturation*255.);
    bright = (bright>1)?bright:(bright*255.);
    
    CGImageRef inImageRef = [self CGImage];
    CGContextRef cgctx = RequestImagePixelData(inImageRef);
    if (cgctx==NULL) {
        fprintf (stderr, "Create PixelData error!");
        return nil;
    }
    NSUInteger w = CGBitmapContextGetWidth(cgctx);
    NSUInteger h = CGBitmapContextGetHeight(cgctx);
    unsigned char *imgPixel = CGBitmapContextGetData(cgctx);
    
    int pixOff = 0;  //每一个像素结束
    
    for(NSUInteger y = 0;y< h;y++){
        for (NSUInteger x = 0; x<w; x++){
            //int alpha = (unsigned char)imgPixel[pixOff];
            int red = (unsigned char)imgPixel[pixOff];
            int green = (unsigned char)imgPixel[pixOff+1];
            int blue = (unsigned char)imgPixel[pixOff+2];
            
            if ((red|green|blue)!=0) {
                //根据条件的不同，对图片的处理顺序不一样
                if (saturation > 0 && bright)
                    SetBright(&red, &green, &blue, bright);
                
                SetHueAndSaturation(&red, &green, &blue, hue, saturation);
                
                if (bright && saturation <= 0)
                    SetBright(&red, &green, &blue, bright);
            }
            
            imgPixel[pixOff] = red;
            imgPixel[pixOff+1] = green;
            imgPixel[pixOff+2] = blue;
            
            pixOff += 4;
        }
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(cgctx);
    
    UIImage *my_Image=nil;
    if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        my_Image=[UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    }else {
        my_Image = [UIImage imageWithCGImage:imageRef];
    }
    
    CFRelease(imageRef);
    CGContextRelease(cgctx);
    free(imgPixel);
    return my_Image;
}


//- (UIImage *)ylt_pngImageDataWithKB:(NSUInteger)KB {
//    int scale=1;
//    //   等比例缩放
//    NSData *imageAfterProcessing = UIImagePNGRepresentation(self);
//    while ((imageAfterProcessing.length/1024)>KB) {
//        scale++;
//        imageAfterProcessing=UIImagePNGRepresentation([self ylt_scaledToSize:CGSizeMake(self.size.width/scale, self.size.height/scale)]);
//    }
//    return [[UIImage alloc] initWithData:imageAfterProcessing];
//}
/**
 图片的默认优化算法
 
 @return 优化后的图片，返回的一定是JPEG格式的
 */
- (UIImage *)ylt_representation {
    return [UIImage imageWithData:[UIImage ylt_representationImageSizeAndQualityWithImage:self maxLength:1024 maxKB:1024]];
}

/**
 获取图片的类型
 
 @param imageData 图片数据
 @return 类型名称 PNG、JPEG等
 */
+ (NSString *)ylt_imageTypeFromData:(NSData *)imageData {
    if (imageData.length < 1) {
        return nil;
    }
    uint8_t c;
    [imageData getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"JPEG";
        case 0x89:
            return @"PNG";
        case 0x47:
            return @"GIF";
        case 0x49:
        case 0x4D:
            return @"TIFF";
        case 0x52:
            if ([imageData length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[imageData subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

/**
 图片压缩算法处理
 
 @param imageData 图片压缩前的数据 PNG的使用 UIImagePNGRepresentation JPEG使用 UIImageJPEGRepresentation
 @param kb 大小
 @return 压缩后的Data
 */
+ (NSData *)ylt_representationData:(NSData *)imageData kb:(NSUInteger)kb {
    UIImage *image = [UIImage imageWithData:imageData];
    return [self ylt_representationImage:image kb:kb];
}

/**
 图片压缩算法处理
 
 @param image 图片压缩前的数据
 @param kb 大小
 @return 压缩后的Data
 */
+ (NSData *)ylt_representationImage:(UIImage *)image kb:(NSUInteger)kb {
    if (!image) {
        return nil;
    }
    kb *= 1024;
    CGFloat compression = 1;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    if (compressedData.length < kb) {
        return compressedData;
    }
    
    CGFloat scale = ((CGFloat)kb)/((CGFloat)compressedData.length)*4.;
    scale = (scale>0.9) ? 0.9 : scale;
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, scale)];
    CGFloat max = 1.;
    CGFloat min = 0;
    NSInteger count = 0;
    do {
        @autoreleasepool {
            compression = (max + min) / 2;
            compressedData = UIImageJPEGRepresentation(image, compression);
            if (compressedData.length < kb * 0.8) {
                min = compression;
            } else if (compressedData.length > kb) {
                max = compression;
            } else {
                break;
            }
            count++;
        }
    } while ((compressedData.length < kb*0.8 || compressedData.length > kb) && count <= 6);
    
    return compressedData;
}

/**
 *  压图片大小
 *
 *  @param originImage  原图
 *  @param maxLength 最长边
 *
 *  @return image
 */
+ (UIImage *)ylt_representationImageSizeWithImage:(UIImage *)originImage maxLength:(CGFloat)maxLength {
    if (!originImage) return nil;
    UIImage *image = originImage;
    CGSize scaleSize = CGSizeMake(originImage.size.width, originImage.size.height);
    CGSize resultSize = [self getCompressSize:scaleSize maxLength:maxLength];
    
    if (!CGSizeEqualToSize(scaleSize, resultSize)) {
        UIGraphicsBeginImageContext(CGSizeMake(resultSize.width, resultSize.height));
        [originImage drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return image;
}

/**
 *  压图片大小和质量
 *
 *  @param originImage 图片源
 *  @param maxLength 最大宽高限制
 *  @param maxKB 最大质量限制
 *
 *  @return data
 */
+ (NSData *)ylt_representationImageSizeAndQualityWithImage:(UIImage *)originImage maxLength:(NSInteger)maxLength maxKB:(NSInteger)maxKB {
    UIImage *image = [self ylt_representationImageSizeWithImage:originImage maxLength:maxLength];
    NSData *data = [self ylt_representationData:UIImageJPEGRepresentation(image, 0.95) kb:maxKB];
    
    return data;
}

+ (CGSize)getCompressSize:(CGSize)originSize maxLength:(NSInteger)maxLength {
    CGSize result = originSize;
    NSInteger width  = originSize.width;
    NSInteger height = originSize.height;
    float wTohRatio = ((float) width) / height;
    
    float scale = 0.0;
    if (wTohRatio > 4.0) {
        scale = ((float) width) / 2484;
    } else if (wTohRatio < 0.25) {
        scale = ((float) height) / 2484;
    } else {
        scale = ((float) MAX(width, height)) / maxLength;
    }
    
    if (scale >= 1.5) {
        scale = [self getCompressScale:scale];
        NSInteger width  = originSize.width / scale;
        NSInteger height = originSize.height / scale;
        
        result = CGSizeMake(width, height);
        //        YLT_Log(@"输出图片尺寸压缩比为 %f", scale);
    } else {
        //        YLT_Log(@"按照原图尺寸输出，质量压缩'可能'达不到要求，请注意修改目标尺寸！！！");
    }
    
    return result;
}

+ (float)getCompressScale:(float)originScale {
    float f = log2f(originScale);               // 计算以以2为底originScale的对数
    float ceilF  = ceilf(f);                    // 向上取整
    float floorF = floorf(f);                   // 向下取整
    
    float ceilScale  = powf(2, ceilF);          // 2的ceilF次幂
    float floorScale = powf(2, floorF);         // 2的floorF次幂
    
    float dDuration1 = ceilScale - originScale;
    float dDuration2 = originScale - floorScale;
    
    return dDuration1 <= dDuration2 ? ceilScale: floorScale; // 取最近的2次幂，小数四舍五入
}

// 根据 orientation 映射到 CGImage的 pixel rect
- (CGRect)calibrateRect:(CGRect)rect inImage:(UIImage *)image
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    // 左下角为旋转原点
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationUp:
            
            break;
            
        case UIImageOrientationDown:
            
            transform = CGAffineTransformTranslate(transform, width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft: // rotate right
            
            transform = CGAffineTransformTranslate(transform, width, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight: // rotate left
            
            transform = CGAffineTransformTranslate(transform, 0.0, height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUpMirrored: // flip H
            
            transform = CGAffineTransformTranslate(transform, width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDownMirrored: // flip V
            
            transform = CGAffineTransformTranslate(transform, 0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: // flip V, rotate right
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationRightMirrored: // flip H, rotate right
            
            transform = CGAffineTransformTranslate(transform, width, height);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    return TC_CGRectFloorIntegral(CGRectApplyAffineTransform(rect, transform));
}

+ (CGContextRef)createImageContext:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, (size_t)size.width, (size_t)size.height, 8, ((size_t)size.width) * 4, colorSpace, kTCDefaultBitMapOrder);
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

/**
 裁剪图片
 
 @param rect 裁剪区域
 @return 裁剪后图片
 */
- (UIImage *)ylt_cropImageWithRect:(CGRect)rect {
    CGRect pixelRect = rect;
    CGFloat scale = self.scale;
    pixelRect.origin.x *= scale;
    pixelRect.origin.y *= scale;
    pixelRect.size.width *= scale;
    pixelRect.size.height *= scale;
    
    CGRect fixRect = [self calibrateRect:pixelRect inImage:self];
    CGSize size = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
    CGContextRef ctx = [UIImage createImageContext:fixRect.size];
    if (fixRect.size.width * fixRect.size.height <= 256 * 256) {
        CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
    } else {
        CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    }
    CGContextDrawImage(ctx, CGRectMake(-fixRect.origin.x, fixRect.origin.y+fixRect.size.height-size.height, size.width, size.height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    
    UIImage *output = self;
    if (NULL != imgRef && imgRef != self.CGImage) {
        output = [UIImage imageWithCGImage:imgRef scale:output.scale orientation:output.imageOrientation];
    }
    CGImageRelease(imgRef);
    
    return output;
}

/**
 Gif资源，转换为图片数组

 @param data nsdata
 @return 转换后的数组
 */
+ (NSArray <UIImage *>*)imgArrFromGif:(NSData *)data {
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray <UIImage *>*images = [NSMutableArray array];
    [images removeAllObjects];
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
        [images addObject:animatedImage];
    } else {
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
    }
    CFRelease(source);
    return images;
}

/** 交换宽和高 */
static CGRect swapWidthAndHeight(CGRect rect) {
    CGFloat swap = rect.size.width;
    rect.size.width = rect.size.height;
    rect.size.height = swap;
    return rect;
}

/// 旋转图片
/// @param orient 方向
- (UIImage *)ylt_rotate:(UIImageOrientation)orient {
    CGRect bnds = CGRectZero;
    UIImage* copy = nil;
    CGContextRef ctxt = nil;
    CGImageRef imag = self.CGImage;
    CGRect rect = CGRectZero;
    CGAffineTransform tran = CGAffineTransformIdentity;
    
    rect.size.width = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    switch (orient) {
        case UIImageOrientationUp:
            return self;
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
        default:
            return self;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

/**
 旋转自定义角度
 
 @param angle 角度
 @return 图片
 */
- (UIImage *)ylt_imageAngle:(CGFloat)angle {
    CGSize imgSize = {self.size.width, self.size.height};
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.size.width/2, self.size.height/2);
    CGContextScaleCTM(context, 1.0, -1.0);
    float radian = angle;
    CGContextRotateCTM(context, radian);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height), self.CGImage);
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rotatedImage;
}

@end

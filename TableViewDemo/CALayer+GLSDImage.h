//
//  CALayer+GLSDImage.h
//  TableViewDemo
//
//  Created by gelei on 2020/7/16.
//  Copyright © 2020 gelei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
@class UIImage;
@interface CALayer (GLSDImage)
- (void)glsd_setImageWithURL:(nullable NSURL *)url;

- (void)glsd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_END

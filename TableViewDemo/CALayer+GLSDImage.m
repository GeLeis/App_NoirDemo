//
//  CALayer+GLSDImage.m
//  TableViewDemo
//
//  Created by gelei on 2020/7/16.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "CALayer+GLSDImage.h"
#import <SDWebImageDownloader.h>
#import <objc/runtime.h>

@implementation CALayer (GLSDImage)

- (SDWebImageDownloadToken *)gl_downToken {
    return objc_getAssociatedObject(self, @selector(gl_downToken));
}

- (void)setGl_downToken:(SDWebImageDownloadToken *)gl_downToken {
    objc_setAssociatedObject(self, @selector(gl_downToken), gl_downToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)glsd_setImageWithURL:(nullable NSURL *)url {
    [self glsd_setImageWithURL:url placeholderImage:nil];
}

- (void)glsd_setImageWithURL:(nullable NSURL *)url
            placeholderImage:(nullable UIImage *)placeholder {
    //存在旧任务,则取消
    SDWebImageDownloadToken *task = [self gl_downToken];
    if (task) {
        [task cancel];
        [self setGl_downToken:nil];
    }
    if (placeholder) {
        self.contents = (__bridge id _Nullable)(placeholder.CGImage);
    }
    task = [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (finished && image) {
            self.contents = (__bridge id _Nullable)(image.CGImage);
        }
        [self setGl_downToken:nil];
    }];
    [self setGl_downToken:task];
}

@end

//
//  JKZooInfoTableViewCellHelper.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "JKZooInfoTableViewCellHelper.h"
#import "JKZooInfo.h"
#import "JKApiManager.h"

@interface JKZooInfoTableViewCellHelper()
@property (strong, nonatomic) JKZooInfo *info;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURLSessionDataTask *imageFetchTask;
@end
@implementation JKZooInfoTableViewCellHelper

- (instancetype)initWithInfo:(JKZooInfo *)info {
    if (self = [super init]) {
        _info = info;
        [self fetchImage];
    }
    
    return self;
}

- (void)fetchImage {
    if (self.image == nil && self.imageFetchTask == nil) {
        __weak typeof(self) wSelf = self;
        self.imageFetchTask = [[JKApiManager shareInstance] fetchImageFromUrl:[NSURL URLWithString:self.info.urlString] completion:^(NSError *error, UIImage *image) {
            if (!error) {
                wSelf.image = image;
            }
        }];
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.view) {
            self.view.iconImage = image;
        }
    });
}

- (void)setView:(JKZooInfoTableViewCell *)view {
    _view = view;
    
    if (_view) {
        _view.title = self.info.name;
        _view.subTitle = self.info.location;
        _view.detail = self.info.feature;
        if (self.image) {
            _view.iconImage = self.image;
            
        } else {
            [self fetchImage];
        }
    }
}

@end

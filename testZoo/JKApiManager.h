//
//  JKApiManager.h
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JKZooInfo;

@interface JKApiManager : NSObject
+ (instancetype)shareInstance;

- (NSURLSessionDataTask *)fetchZooItemWithCount:(NSUInteger)count offset:(NSNumber *)offset completion:(void(^)(NSError *error, NSNumber *newOffset, NSArray<JKZooInfo *> *infos))completion;

- (NSURLSessionDataTask *)fetchImageFromUrl:(NSURL *)URL completion:(void(^)(NSError *error, UIImage *image))completion;
@end

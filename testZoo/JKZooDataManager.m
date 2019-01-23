//
//  JKZooDataManager.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "JKZooDataManager.h"
#import "JKApiManager.h"
#import "JKZooInfo.h"

static NSUInteger const kFetchCount = 20;

@interface JKZooDataManager ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSArray<JKZooInfo *> *infos;
@end

@implementation JKZooDataManager

- (instancetype)init {
    if (self = [super init]) {
        _offset = @(0);
        _infos = @[];
    }
    
    return self;
}

- (void)fetchWithCompletion:(void (^)(BOOL))completion {
    if (self.isFetching) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    self.task = [[JKApiManager shareInstance] fetchZooItemWithCount:kFetchCount offset:self.offset completion:^(NSError *error, NSNumber *newOffset, NSArray<JKZooInfo *> *infos) {
        weakSelf.task = nil;
        if (error == nil) {
            weakSelf.offset = newOffset;
            weakSelf.infos = [weakSelf.infos arrayByAddingObjectsFromArray:infos];
        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error == nil);
            });
        }
    }];
}

- (JKZooInfo *)infoForIndex:(NSUInteger)index {
    if (self.infos.count > index) {
        return self.infos[index];
        
    } else {
        return nil;
    }
}

- (BOOL)isFetching {
    return self.task != nil;
}

- (NSUInteger)count {
    return self.infos.count;
}

@end

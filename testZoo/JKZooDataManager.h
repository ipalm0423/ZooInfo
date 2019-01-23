//
//  JKZooDataManager.h
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JKZooInfo;

@interface JKZooDataManager : NSObject
@property (assign, nonatomic, readonly) BOOL isFetching;
@property (assign, nonatomic, readonly) NSUInteger count;
- (void)fetchWithCompletion:(void(^)(BOOL success))completion;
- (JKZooInfo *)infoForIndex:(NSUInteger)index;
@end

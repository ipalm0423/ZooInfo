//
//  JKZooInfo.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "JKZooInfo.h"

@implementation JKZooInfo

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if (self = [super init]) {
        _name = dict[@"F_Name_Ch"];
        _location = dict[@"F_Location"];
        _feature = dict[@"F_Feature"];
        _urlString = dict[@"F_Pic01_URL"];
    }
    
    return self;
}

+ (NSArray<JKZooInfo *> *)infosWithJSONArray:(NSArray<NSDictionary *> *)jsonArray {
    if (jsonArray == nil) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dict in jsonArray) {
        JKZooInfo *info = [[JKZooInfo alloc] initWithDict:dict];
        
        if (info) {
            [arr addObject:info];
        }
    }
    
    return arr;
}

@end

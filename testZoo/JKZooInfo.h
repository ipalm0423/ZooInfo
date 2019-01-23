//
//  JKZooInfo.h
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JKZooInfo : NSObject
@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) NSString *location;
@property (copy, nonatomic, readonly) NSString *feature;
@property (copy, nonatomic, readonly) NSString *urlString;
+ (NSArray<JKZooInfo *> *)infosWithJSONArray:(NSArray<NSDictionary *> *)jsonArray;
@end



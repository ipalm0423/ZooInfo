//
//  JKZooInfoTableViewCellHelper.h
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKZooInfoTableViewCell.h"

@class JKZooInfoTableViewCell, JKZooInfo;

@interface JKZooInfoTableViewCellHelper : NSObject
@property (weak, nonatomic) JKZooInfoTableViewCell *view;
- (instancetype)initWithInfo:(JKZooInfo *)info;
@end


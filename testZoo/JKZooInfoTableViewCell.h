//
//  JKZooInfoTableViewCell.h
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JKZooInfoTableViewCell : UITableViewCell
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSString *subTitle;
@property (strong, nonatomic) UIImage *iconImage;

+ (NSString *)cellIdentifier;
@end


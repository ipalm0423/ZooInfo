//
//  JKZooInfoTableViewCell.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "JKZooInfoTableViewCell.h"

@interface JKZooInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation JKZooInfoTableViewCell

+ (NSString *)cellIdentifier {
    return @"JKZooInfoTableViewCell";
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.descriptionLabel.text = nil;
    self.subTitleLabel.text = nil;
    self.iconImageView.image = nil;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    self.subTitleLabel.text = subTitle;
}

- (void)setDetail:(NSString *)detail {
    self.descriptionLabel.text = detail;
}

- (void)setIconImage:(UIImage *)iconImage {
    self.iconImageView.image = iconImage;
}

@end

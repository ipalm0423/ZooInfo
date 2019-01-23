//
//  ViewController.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "ViewController.h"
#import "JKZooDataManager.h"
#import "JKZooInfoTableViewCellHelper.h"

static CGFloat const kTopContainerViewMinHeight = 21;
static CGFloat const kTopContainerViewMaxHeight = 200;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContainerViewContraint;
@property (strong, nonatomic) JKZooDataManager *dataManager;
@property (strong, nonatomic) NSMutableDictionary *cellHelpers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDatas];
}

- (void)fetchDatas {
    if (self.dataManager == nil) {
        self.dataManager = [[JKZooDataManager alloc] init];
        self.cellHelpers = [NSMutableDictionary dictionary];
    }
    
    __weak typeof(self) weakSelf = self;
    [self.dataManager fetchWithCompletion:^(BOOL success) {
        if (success) {
            [weakSelf.tableView reloadData];
        }
    }];
}

- (JKZooInfoTableViewCellHelper *)helperForIndexPath:(NSIndexPath *)indexPath {
    JKZooInfoTableViewCellHelper *helper = [self.cellHelpers objectForKey:indexPath];
    
    if (helper == nil) {
        helper = [[JKZooInfoTableViewCellHelper alloc] initWithInfo:[self.dataManager infoForIndex:indexPath.row]];
        [self.cellHelpers setObject:helper forKey:indexPath];
    }
    return helper;
}

- (void)animateTopContainerView {
    BOOL shouldShowTopContainerView = self.tableView.contentOffset.y < (kTopContainerViewMaxHeight - kTopContainerViewMinHeight) / 2;
    if (shouldShowTopContainerView && self.topContainerViewContraint.constant != kTopContainerViewMaxHeight) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (!shouldShowTopContainerView && self.topContainerViewContraint.constant != kTopContainerViewMinHeight) {
        [self.tableView setContentOffset:CGPointMake(0, (kTopContainerViewMaxHeight - kTopContainerViewMinHeight)) animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataManager.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JKZooInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[JKZooInfoTableViewCell cellIdentifier] forIndexPath:indexPath];
    JKZooInfoTableViewCellHelper *info = [self helperForIndexPath:indexPath];
    info.view = cell;
    
    if (indexPath.row > (self.dataManager.count * 2 / 3)) {
        [self fetchDatas];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JKZooInfoTableViewCellHelper *helper = [self.cellHelpers objectForKey:indexPath];
    helper.view = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat height = kTopContainerViewMaxHeight - offset;
    
    if (offset <= 0) {
        self.topContainerViewContraint.constant = kTopContainerViewMaxHeight;
        self.titleLabel.alpha = 1;
        self.subTitleLabel.alpha = 0;
    } else if (height > kTopContainerViewMinHeight) {
        self.topContainerViewContraint.constant = height;
        self.titleLabel.alpha = height / (kTopContainerViewMaxHeight - kTopContainerViewMinHeight);
        self.subTitleLabel.alpha = offset / (kTopContainerViewMaxHeight - kTopContainerViewMinHeight);
    } else {
        self.titleLabel.alpha = 0;
        self.subTitleLabel.alpha = 1;
        self.topContainerViewContraint.constant = kTopContainerViewMinHeight;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self animateTopContainerView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self animateTopContainerView];
    }
}

@end

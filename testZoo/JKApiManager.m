//
//  JKApiManager.m
//  testZoo
//
//  Created by Jack on 2019/1/23.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "JKApiManager.h"
#import "JKZooInfo.h"

@interface JKApiManager()
@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;
@property (strong, nonatomic) NSURLSession *session;

@end

@implementation JKApiManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static JKApiManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[JKApiManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:_sessionConfig delegate:nil delegateQueue:nil];
    }
    
    return self;
}

- (NSURLSessionDataTask *)fetchZooItemWithCount:(NSUInteger)count offset:(NSNumber *)offset completion:(void(^)(NSError *error, NSNumber *newOffset, NSArray<JKZooInfo *> *infos))completion {
    NSString *urlStr = [NSString stringWithFormat:@"https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14&limit=%@&offset=%@", @(count), offset];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *parseError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
        NSDictionary *result = json[@"result"];
        NSInteger offset = [result[@"offset"] integerValue];
        
        NSArray *datas = result[@"results"];
        NSArray *infos = [JKZooInfo infosWithJSONArray:datas];
        NSNumber *newOffset = @(offset + infos.count);
        
        if (completion) {
            completion(error, newOffset, infos);
        }
    }];
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)fetchImageFromUrl:(NSURL *)URL completion:(void(^)(NSError *error, UIImage *image))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        
        if (completion) {
            completion(error, image);
        }
    }];
    [task resume];
    return task;
}

@end

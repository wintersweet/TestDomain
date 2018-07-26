//
//  NetWorkStatus.m
//  coincola
//
//  Created by 新国都 on 2018/6/13.
//  Copyright © 2018年 xinguodu. All rights reserved.
//

#import "NetWorkStatus.h"

@implementation NetWorkStatus

+(instancetype)sharedInstance
{
    static NetWorkStatus * _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}
-(id)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer setValue:@"Bearer" forHTTPHeaderField:@"Authorization"];
        _manager.requestSerializer.timeoutInterval = 20.0f;
    }
    return self;
}
-(void)testUrlStatus:(NSString*)url  block:(void(^)(NSString *time))block
                              failure:(void(^)(NSString *failure))faliureBlock
{
    NSDictionary *dic = @{@"country_code":@"CN",@"limit":@"20",@"offset":[NSNumber numberWithInteger:0],@"sort_order":@"GENERAL",@"type":@"SELL",@"crypto_currency":@"BTC"};
    
   
    NSTimeInterval interval1 = [[NSDate date] timeIntervalSince1970]*1000;
    [_manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了==");
        
        NSTimeInterval interval2 = [[NSDate date] timeIntervalSince1970]*1000;
        NSLog(@"start %f end %f",interval1,interval2);
        int substribe = interval2-interval1;
        
        NSString *result = [NSString stringWithFormat:@"%d",substribe];
        block(result);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"失败了==");
         faliureBlock(@"1");
    }];
  
}
@end

//
//  NetWorkStatus.h
//  coincola
//
//  Created by 新国都 on 2018/6/13.
//  Copyright © 2018年 xinguodu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetWorkStatus : NSObject
+(instancetype)sharedInstance;
@property (nonatomic,strong) AFHTTPSessionManager *manager;

-(id)init;
-(void)testUrlStatus:(NSString*)url  block:(void(^)(NSString *time))block
             failure:(void(^)(NSString *failure))faliureBlock;
@end

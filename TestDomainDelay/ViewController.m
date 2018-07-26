//
//  ViewController.m
//  TestDomainDelay
//
//  Created by 任佳乐 on 2018/6/13.
//  Copyright © 2018年 任佳乐. All rights reserved.
//

#import "ViewController.h"
#import "NetWorkStatus.h"
#define MyWeakSelf __weak typeof(self) weakSelf = self;

@interface ViewController ()
{
    
}
@property(nonatomic,assign)  __block CGFloat succTime ;     //成功请求的总耗时
@property(nonatomic,assign)  __block CGFloat failureCount;  //失败次数
@property(nonatomic,assign)  __block NSInteger requestCount;//请求次数
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * url  = @"https://app.coincola.com/v1/advertisement/list";
    NSString * url1 = @"https://www.cola-links.com/v1/advertisement/list";
    NSString * url2 = @"https://www.cola-otc.com/v1/advertisement/list";
    NSString * url3 = @"https://www.colaotc.com/v1/advertisement/list";
    
   
    
    dispatch_queue_t aqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aqueue, ^{
         [self checkUrlStatus:url];
    });
    dispatch_async(aqueue, ^{
      
//        [self checkUrlStatus:url1];
    });
    dispatch_async(aqueue, ^{
        
    
    });
    dispatch_async(aqueue, ^{
  
    });
    dispatch_async(aqueue, ^{
        
    });
    
}
-(void)testFunc
{
    //www.cola-links.com  www.cola-otc.com  www.colaotc.com
   
    
}
-(void)checkUrlStatus:(NSString*)url
{
    MyWeakSelf
    [[NetWorkStatus sharedInstance] testUrlStatus:url  block:^(NSString *second) {
        CGFloat tempTime = second.floatValue;
        weakSelf.succTime += tempTime;
        NSLog(@"%@的 第%ld次的 time== %@",url,weakSelf.requestCount,second);
        weakSelf.requestCount ++;
        //请求成功 再次请求
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (weakSelf.requestCount < 10) {
                [self checkUrlStatus:url];
                
            }else{
                NSLog(@"平均时间=%f",weakSelf.succTime/weakSelf.requestCount);
                NSLog(@"失败次数=%f",weakSelf.failureCount);
            }
        });
        
    } failure:^(NSString *failure) {
        
        weakSelf.requestCount ++;
        weakSelf.failureCount ++;
        NSLog(@"失败的次数=%f",weakSelf.failureCount);
        //失败 超时，后 继续请求
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.requestCount < 10) {
                [self checkUrlStatus:url];
                
            }else{
                NSLog(@"平均时间=%f",weakSelf.succTime/weakSelf.requestCount);
                NSLog(@"失败次数=%f",weakSelf.failureCount);
            }
        });
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewModel.m
//  MVVM_use
//
//  Created by admin on 2018/12/12.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewModel.h"
#import "SVProgressHUD.h"

@interface ViewModel ()

@property (nonatomic, assign) BOOL signalAAAisRequest;
@end

@implementation ViewModel

- (RACSignal *)signalAAA{
    if (_signalAAA) {  return _signalAAA; }

    @weakify(self);
    _signalAAA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        if (self.signalAAAisRequest ) {// 正在请求，不要去请求了
            return [RACDisposable disposableWithBlock:^{ }];;
        }
        // 第一遍可能是读取缓存显示, 此处不能调用[subscriber sendCompleted];
        if (!self.ModelAAA) {
            [subscriber sendNext:@(4)];
        }
        
        self.signalAAAisRequest = YES;
        // 模拟网络请求的代码，注意网络请求里面的block也要使用@strongify(self);来防止循环引用
        [SVProgressHUD showImage:nil status:@"开始请求....."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.signalAAAisRequest = NO;
            BOOL success = YES;// 实际请求会有失败和成功
            if (success) {
                [SVProgressHUD showImage:nil status:@"请求成功！"];
                
                NSString *code = @"0000";// 假设
                
                if ([@"0000" isEqualToString:code]) {
                    
                    [subscriber sendNext:@1];// 返回的请求状态码等是对的
                }else if ([@"0099" isEqualToString:code]) {
                    
                    [subscriber sendNext:@2];// 返回的请求状态码是错的：错误情况1
                }else if ([@"0000" isEqualToString:code]) {
                    
                    [subscriber sendNext:@3];// 返回的请求状态码是错的：错误情况2
                }else{
                    
                    [SVProgressHUD showImage:nil status:@"请求信息错误的提示！"];
                }
                
                [subscriber sendCompleted];
            }else{
                
                [SVProgressHUD showImage:nil status:@"请求失败！"];
                [subscriber sendNext:@5];
                [subscriber sendCompleted];
            } 
            
        });
        
        
        
        return [RACDisposable disposableWithBlock:^{ }];
    }];
    
    return _signalAAA;
}

@end

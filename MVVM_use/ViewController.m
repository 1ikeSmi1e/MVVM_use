//
//  ViewController.m
//  MVVM_use
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "ViewModel.h"
#import "TableViewCell.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@property (strong, nonatomic) ViewModel *viewModel;
@property (weak, nonatomic) TableViewCell *cell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
/// 当控制器里面有很多个请求的情况下，
/// 如果不使用MVVM的设计模式，则很多的请求的细节、请求后数据转化、读取缓存数据、缓存新数据都放在了控制器里面. 使得控制器太过于臃肿了。
/// 而使用MVVM时，请求的那一部分逻辑抽取在viewmodel里面。这样在查看一个控制器做了什么时会方便得多
    
    [self initView];
    [self AAARequest];
    
    // 这里是演示的RAC里面通知监听的方式======不需要再-dealloc方法移除了
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        NSLog(@"%@",x);
    }];
    
    // 这里演示的是RAC下KVO的监听======不需要再-dealloc方法移除了
    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"3 - %@",x);
    }];
    
    // 这里是RAC下代理新写法：不需要写代理，遵守协议
    [self.cell.btnClickSignal subscribeNext:^(id  _Nullable x) {
        [SVProgressHUD showImage:nil status:@"接收到了按钮点击d代理信号"];
        @strongify(self);
        
        [self AAARequest];
    }];
    
}

- (void)initView{
    
    TableViewCell *subView = [NSBundle.mainBundle loadNibNamed:@"TableViewCell" owner:nil options:0].lastObject;
    subView.frame = CGRectMake(15, 150, self.view.bounds.size.width - 30, 60);
    [self.view addSubview:subView];
    self.cell = subView;
}

- (void)AAARequest{
    // 这里是一种请求的假设
    self.viewModel.Params_signalAAA = @{}.mutableCopy;
    [self.viewModel.signalAAA subscribeNext:^(NSNumber *sender) {
       // 这里sender是自己在signalAAA里面传的NSNumber类型
        switch (sender.integerValue) {
            case 1:// 正确的结果
                NSLog(@"正确的结果");
                break;
            case 2:// 错误情况1
                NSLog(@"错误情况1");
                break;
            case 3:// 错误情况2
                NSLog(@"错误情况2");
                break;
            case 4:// 缓存
                NSLog(@"缓存");
                break;
            case 5:// 请求失败
                NSLog(@"请求失败");
                break;
            default:
                break;
        }
    }];
}






- (ViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ViewModel alloc] init];
    }
    return _viewModel;
}
@end

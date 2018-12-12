//
//  ViewModel.h
//  MVVM_use
//
//  Created by admin on 2018/12/12.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

// 请求A
@property (nonatomic, copy) NSDictionary *Params_signalAAA;
@property (nonatomic, strong) RACSignal *signalAAA;
@property (nonatomic, strong) id ModelAAA;// signalAAA请求到数据后转换成的模型数据(或者使用后台返回的NSDictionary，见仁见智)

// 请求B
@property (nonatomic, copy) NSDictionary *Params_signalBBB;
@property (nonatomic, strong) RACSignal *signalBBB;
@property (nonatomic, strong) id ModelBBB;


// 其它请求...（有的控制器可能会有上10个请求，比如首页，小项目除外）
@end

NS_ASSUME_NONNULL_END

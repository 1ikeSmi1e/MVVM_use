//
//  TableViewCell.h
//  MVVM_use
//
//  Created by admin on 2018/12/12.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) RACSubject *btnClickSignal;
@end

NS_ASSUME_NONNULL_END

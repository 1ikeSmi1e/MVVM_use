//
//  TableViewCell.m
//  MVVM_use
//
//  Created by admin on 2018/12/12.
//  Copyright © 2018 admin. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnClick:(id)sender {
    
    [_btnClickSignal sendNext:@"我可以代替代理哦"];
}

- (RACSubject *)btnClickSignal{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}
@end

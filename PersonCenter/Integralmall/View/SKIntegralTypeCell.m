//
//  SKIntegralTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKIntegralTypeCell.h"
@interface SKIntegralTypeCell ()
{
    NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end
@implementation SKIntegralTypeCell
- (IBAction)moreTypeClick:(UIButton *)sender {
    if(_vDelegate && [_vDelegate respondsToSelector:@selector(IntergralTypeMoreDelegate:)])
    {
        [_vDelegate IntergralTypeMoreDelegate:_currentIndex];
    }
}
- (void)initWithType:(NSInteger)tag realArray:(NSMutableArray *)array moniArray:(NSMutableArray *)otherArray
{
    _currentIndex = tag;
    if(tag == 1){
        if (array.count == 0) {
            _typeLab.text = @"虚拟商品(暂无商品,敬请期待)";
        } else {
            _typeLab.text = @"虚拟商品";
        }
        
    }else{
        if (otherArray.count == 0) {
            _typeLab.text = @"实物商品(暂无商品,敬请期待)";
        } else {
            _typeLab.text = @"实物商品";
        }
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

//
//  SKrechargeNumCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKrechargeNumCell.h"
@interface SKrechargeNumCell ()<UITextFieldDelegate>
{
NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *typeLab;


@end
@implementation SKrechargeNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
   _AcountTF.delegate = self;
 [_AcountTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    // Initialization code
}
- (void)setupViewWithType:(NSString *)type placeString:(NSString *)pla type:(NSInteger)textType index:(NSInteger)tag
{
    _typeLab.text = type;
//    _AcountTF.placeholder = pla;
   _currentIndex = tag;
    if (textType == 1) {
        _typeLab.textColor = [UIColor hexStringToColor:@"77828C"];
    }else{
         _typeLab.textColor = [UIColor hexStringToColor:@"303942"];
    }
}
- (void)changedTextField:(UITextField *)tf
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(AcountValuechange:index:)]) {
    [_vDelegate AcountValuechange:tf.text index:_currentIndex];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

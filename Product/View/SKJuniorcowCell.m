//
//  SKJuniorcowCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/8.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJuniorcowCell.h"

@interface SKJuniorcowCell ()<UITextFieldDelegate>
{
    NSInteger _currentIndex;
    NSInteger _currentButtonTag;
    NSInteger _currentScale;
}
@property (weak, nonatomic) IBOutlet UILabel *balamceLab;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *yuanLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewConstrainHeight;
@property (weak, nonatomic) IBOutlet UIButton *changeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *thereButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevenButton;
@property (weak, nonatomic) IBOutlet UIButton *enlargeOneButton;
@property (weak, nonatomic) IBOutlet UIButton *enlargeTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *enlargeThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *enlargeFourButton;
@property (weak, nonatomic) IBOutlet UIButton *enlargeFiveButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewheightConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constainlight7;
@end

@implementation SKJuniorcowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _countTF.delegate = self;
    if (kScreenWidth > 330) {
        [self constainheightwithret:YES];
    }else{
        [self constainheightwithret:NO];
    }
    [self setNumbuttonlayer:_oneButton];
    [self setNumbuttonlayer:_twoButton];
    [self setNumbuttonlayer:_thereButton];
    [self setNumbuttonlayer:_fourButton];
    [self setNumbuttonlayer:_fiveButton];
    [self setNumbuttonlayer:_sixButton];
    [self setNumbuttonlayer:_sevenButton];
    [self setMoreLayer:_enlargeOneButton];
     [self setMoreLayer:_enlargeTwoButton];
     [self setMoreLayer:_enlargeThreeButton];
     [self setMoreLayer:_enlargeFourButton];
     [self setMoreLayer:_enlargeFiveButton];
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = [UIColor colorWithRed:226/255.0 green:232/255.0 blue:238/255.0 alpha:1.0].CGColor;
    
    _bgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [_countTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    // Initialization code
}
- (void)setNumbuttonlayer:(UIButton *)sender
{
    sender.layer.borderWidth = 0.5;
    sender.layer.borderColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    sender.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    sender.layer.cornerRadius = 15;
    sender.clipsToBounds = YES;
}
- (void)setMoreLayer:(UIButton *)sender
{
    sender.layer.borderWidth = 0.5;
    sender.layer.borderColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    
    sender.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    sender.layer.cornerRadius = 5;
    sender.clipsToBounds = YES;
}
#pragma mark --> 设置按钮之间的间隙
- (void)constainheightwithret:(BOOL)ret
{
    CGFloat leight;
    if (ret) {
        leight = 10;
    }else{
        leight = 5;
    }
    _constainlight1.constant = leight;
     _constainlight2.constant = leight;
     _constainlight3.constant = leight;
     _constainlight4.constant = leight;
     _constainlight5.constant = leight;
     _constainlight6.constant = leight;
     _constainlight7.constant = leight;
}
- (void)changeType:(NSInteger)type buttonType:(NSInteger)buttonType scale:(NSInteger)scale yushu:(CGFloat)yushu currentIndx:(NSInteger)index balance:(NSString *)balance
{
    _currentIndex = type;
    _currentScale = scale;
    _currentButtonTag = buttonType;
    [self setNumbuttontitle:index];
    if ([balance integerValue] > 1) {
    _balamceLab.text = [NSString stringWithFormat:@"账户余额：%@",balance];
    }else{
    _balamceLab.text = @"账户余额：0.00";
    }
    
    self.countTF.placeholder = index ==1 ? @"请输入1000的倍数，最低1万元":@"请输入100的倍数，最低2千元";
    
    if (type == 1) {
        [_changeTypeButton setTitle:@"手动输入策略资金>>" forState:0];
        _bgViewheightConstrain.constant = 0;
        _buttonViewConstrainHeight.constant = 113;
        [self hidden:YES];
    }else{
         [_changeTypeButton setTitle:@"快速选择>>" forState:0];
        _bgViewheightConstrain.constant = 45;
        _buttonViewConstrainHeight.constant = 0;
        [self hidden:NO];
    }
    if (yushu < 0.1) {
//        if(index == 1){
//            _countTF.text = @"10000";
//        }else{
//            _countTF.text = @"2000";
//        }
        _countTF.text = @"";
    }
    [self changbuttonTitle:buttonType yushu:yushu inde:index];
    [self changebuttonbackColor:buttonType];
    [self changescalebuttonbackColor:scale];
}
- (void)setNumbuttontitle:(NSInteger)tag
{
    if (tag == 1) {
        [_oneButton setTitle:@"1万元" forState:0];
          [_twoButton setTitle:@"5万元" forState:0];
          [_thereButton setTitle:@"10万元" forState:0];
          [_fourButton setTitle:@"20万元" forState:0];
          [_fiveButton setTitle:@"50万元" forState:0];
          [_sixButton setTitle:@"100万元" forState:0];
          [_sevenButton setTitle:@"200万元" forState:0];
    }else{
        [_oneButton setTitle:@"2000元" forState:0];
        [_twoButton setTitle:@"5000元" forState:0];
        [_thereButton setTitle:@"1万元" forState:0];
        [_fourButton setTitle:@"2万元" forState:0];
        [_fiveButton setTitle:@"5万元" forState:0];
        [_sixButton setTitle:@"10万元" forState:0];
        [_sevenButton setTitle:@"20万元" forState:0];
    }
}
- (void)changbuttonTitle:(NSInteger)buttonType yushu:(CGFloat)yushu inde:(NSInteger)tag
{
    NSInteger num = 0;
    NSInteger TianNum = 0;
    switch (buttonType) {
        case 1:
            num = 1;
            TianNum = 2000;
            break;
        case 2:
            num = 5;
             TianNum = 5000;
            break;
        case 3:
            num = 10;
             TianNum = 10000;
            break;
        case 4:
            num = 20;
             TianNum = 20000;
            break;
        case 5:
            num = 50;
             TianNum = 50000;
            break;
        case 6:
            num = 100;
             TianNum = 100000;
            break;
        case 7:
            num = 200;
             TianNum = 200000;
            break;
        default:
            break;
    }
    for (NSInteger i = 201; i < 206; i ++ ) {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:i];
        if (tag == 1) {
            [button setTitle:[NSString stringWithFormat:@"%ld万元\n放大%ld倍",num * (i - 200),i - 200] forState:0];
            if (yushu >0) {
                [button setTitle:[NSString stringWithFormat:@"%.1lf万元\n放大%ld倍",yushu * (i - 200),i - 200] forState:0];
            }
            if (i > 203) {
                button.hidden = NO;
            }
        }else{
            if (yushu > 0) {
                TianNum = yushu * 10000;
            }
            NSInteger scale = TianNum* (i - 198)/10000;
            if (yushu >0) {
                scale = yushu * (i - 198)/10000;
            }
            if (TianNum * (i - 198) >= 10000) {
                [button setTitle:[NSString stringWithFormat:@"%.1lf万元\n放大%ld倍",TianNum * (i - 198)/10000.0,i - 198] forState:0];
            }else{
                [button setTitle:[NSString stringWithFormat:@"%ld元\n放大%ld倍",TianNum* (i - 198),i - 198] forState:0];
            }
           
            if (i > 203) {
                button.hidden = YES;
            }
        }
    }
}
- (void)changebuttonbackColor:(NSInteger )tag
{
    for (NSInteger i = 100; i < 108; i ++ ) {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:i];
        if (100 + tag == i) {
          button.layer.backgroundColor = [UIColor hexStringToColor:@"4062f4"].CGColor;
            [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        }else{
            button.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
            [button setTitleColor:[UIColor hexStringToColor:@"3F434F"] forState:0];
        }
    }
}
- (void)changescalebuttonbackColor:(NSInteger )tag
{
    for (NSInteger i = 201; i < 206; i ++ ) {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:i];
        if (200 + tag == i) {
            button.layer.backgroundColor = [UIColor hexStringToColor:@"4062f4"].CGColor;
            [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        }else{
            button.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
            [button setTitleColor:[UIColor hexStringToColor:@"3F434F"] forState:0];
        }
    }
}
- (void)hidden:(BOOL)ret{
    _yuanLab.hidden = ret;
    _countTF.hidden = ret;
    _oneButton.hidden = !ret;
    _twoButton.hidden = !ret;
    _thereButton.hidden = !ret;
    _fourButton.hidden = !ret;
    _fiveButton.hidden = !ret;
    _sixButton.hidden = !ret;
    _sevenButton.hidden = !ret;
}
- (IBAction)changeTypeClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKJuniorcowCellchangTypeClick:)]) {
        if (sender.tag == 1205) {
             [_vDelegate SKJuniorcowCellchangTypeClick:_currentIndex];
        }else{
              [_vDelegate SKJuniorcowCellchangTypeClick:sender.tag];
        }
    }
}
- (IBAction)typebuttonClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(typeButtonchangTypeClick:senderTag:)]) {
        if (sender.tag > 200) {
            [_vDelegate typeButtonchangTypeClick:_currentScale senderTag:sender.tag];
        }else{
             [_vDelegate typeButtonchangTypeClick:_currentButtonTag senderTag:sender.tag];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(countTFValuechangTypeClick:type:)]) {
    [_vDelegate countTFValuechangTypeClick:textField.text type:@"1"];
    }
    return [textField resignFirstResponder];
}
-(void)changedTextField:(UITextField *)textField
{
      if (_vDelegate && [_vDelegate respondsToSelector:@selector(countTFValuechangTypeClick:type:)]) {
      [_vDelegate countTFValuechangTypeClick:textField.text type:@"2"];
      }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SKanalogdiskPurchaseCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/16.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKanalogdiskPurchaseCell.h"

@interface SKanalogdiskPurchaseCell ()<UITextFieldDelegate>
{
  NSString *_sellType;
}
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;
@property (weak, nonatomic) IBOutlet UIView *bgView3;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *stockBussinesButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedShareBtn;

@end

@implementation SKanalogdiskPurchaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setViewboardColorWithview:_bgView1];
    [self setViewboardColorWithview:_bgview2];
    [self setViewboardColorWithview:_bgView3];
    [self setViewboardColorWithbtn:_button1];
    [self setViewboardColorWithbtn:_button2];
    [self setViewboardColorWithbtn:_button3];
    [self setViewboardColorWithbtn:_button4];
    _NumTF.delegate = self;
    _priceTF.delegate = self;
}

- (void)setViewboardColorWithview:(UIView *)bgView
{
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:213/255.0 green:221/255.0 blue:229/255.0 alpha:1].CGColor;
}
- (void)setViewboardColorWithbtn:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.borderColor = [UIColor colorWithRed:213/255.0 green:221/255.0 blue:229/255.0 alpha:1].CGColor;
}
- (void)setupBussinessButtonType:(NSInteger)type code:(NSString *)code price:(NSString *)price countNum:(NSString *)countNum
{
    if (type == 1) {
        [_stockBussinesButton setTitle:@"买入" forState:0];
    _sellType = @"1";
    }else{
         [_stockBussinesButton setTitle:@"卖出" forState:0];
    _sellType = @"2";
    }
    if (code.length > 6) {
        [_selectedShareBtn setTitle:code forState:0];
        if ([code isEqualToString:@"请输入股票代码/简拼"]) {
            [_selectedShareBtn setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
        }else{
            [_selectedShareBtn setTitleColor:[UIColor hexStringToColor:@"303942"] forState:0];
        }
    }else{
    }
    if ([price floatValue] > 0) {
        self.priceTF.text = price;
    }else{
        self.priceTF.text = @"";
    }
    if ([countNum integerValue] >= 100) {
        self.NumTF.text = [NSString stringWithFormat:@"%@",countNum];
    }else{
        self.NumTF.text = @"";
    }
}
- (IBAction)shareBtnClick:(UIButton *)sender {
    if(_vDelegate && [_vDelegate respondsToSelector:@selector(SKanalogdiskPurchaseCellClick:type:)]){
        [_vDelegate SKanalogdiskPurchaseCellClick:@"Y-W" type:_sellType];
    }
}
- (IBAction)priceChangeValue:(UIButton *)sender {
    CGFloat currentPrice = [self.priceTF.text floatValue];
    if (sender.tag == 16) {
        if (currentPrice <= 0) {
            
        }else{
            currentPrice -= 0.01;
        }
    }else{
        if (currentPrice > 0) {
            currentPrice += 0.01;
        }
    }
    self.priceTF.text = [NSString stringWithFormat:@"%0.2f",currentPrice];
    if(_vDelegate && [_vDelegate respondsToSelector:@selector(changevalue:count:)]){
        [_vDelegate changevalue:self.priceTF.text count:self.NumTF.text];
    }
}
- (IBAction)numChangeValue:(UIButton *)sender {
    NSInteger currentCount = [self.NumTF.text integerValue];
    if (sender.tag == 18) {
        if (currentCount < 101) {
            
        }else{
            currentCount -= 100;
        }
    }else{
        if (currentCount >= 100) {
             currentCount += 100;
        }
    }
    self.NumTF.text = [NSString stringWithFormat:@"%ld",(long)currentCount];
    if(_vDelegate && [_vDelegate respondsToSelector:@selector(changevalue:count:)]){
        [_vDelegate changevalue:self.priceTF.text count:self.NumTF.text];
    }
}
- (IBAction)buyShareClick:(UIButton *)sender {
    if(_vDelegate && [_vDelegate respondsToSelector:@selector(SKanalogdiskPurchaseCellClick:type:)]){
        [_vDelegate SKanalogdiskPurchaseCellClick:@"Y-X" type:_sellType];
    }
}
- (IBAction)changAmoutClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(changAmountClickType:)]) {
        [_vDelegate changAmountClickType:sender.tag - 10];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
   return YES;
 }
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

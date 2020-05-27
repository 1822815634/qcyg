//
//  SKMyAuthenInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMyAuthenInfoCell.h"

@interface SKMyAuthenInfoCell ()<UITextFieldDelegate>
{
    NSIndexPath *_currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *TypeLab;

@end
@implementation SKMyAuthenInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentTF.delegate = self;
    [self.contentTF addTarget:self action:@selector(contentDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)initMyAuthenInfoType:(NSString *)type palceString:(NSString *)string index:(NSIndexPath *)index
{
    _TypeLab.text = type;
    self.contentTF.placeholder = string;
    _currentIndex = index;
}
- (void)contentDidChanged:(id)sender {
    // 调用代理方法，告诉代理，哪一行的文本发生了改变
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(contentDidChanged:forIndexPath:)]) {
        [_Vdelegate contentDidChanged:self.contentTF.text forIndexPath:_currentIndex];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

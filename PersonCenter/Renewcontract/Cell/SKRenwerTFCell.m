//
//  SKRenwerTFCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/22.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKRenwerTFCell.h"
@interface SKRenwerTFCell ()<UITextFieldDelegate>

@end
@implementation SKRenwerTFCell

- (void)awakeFromNib {
    [super awakeFromNib];
self.countTF.delegate = self;
    // Initialization code
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
 return [textField resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

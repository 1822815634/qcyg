//
//  SKCommitPointReplyView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKCommitPointReplyView.h"
@interface SKCommitPointReplyView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTXView;
@property (weak, nonatomic) IBOutlet UILabel *placederLab;

@end
@implementation SKCommitPointReplyView

#pragma mark --> xib加载提交评论视图
+ (SKCommitPointReplyView *)instanceSKCommitPointReplyView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKCommitPointReplyView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)show
{
   
}
- (IBAction)commitReply:(UIButton *)sender {
    [self endEditing:YES];
    if(_contentTXView.text.length > 1){
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(commitReplycontent:)]) {
        [_vDelegate commitReplycontent:_contentTXView.text];
    }}else{
        [self toastShow:@"请输入您的评论"];
    }
}

- (IBAction)cancelCommit:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)dissmiss
{
    [self removeFromSuperview];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    _commitBtn.layer.cornerRadius = 15;
    _commitBtn.clipsToBounds = YES;
    _contentTXView.delegate = self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placederLab.text = @" 请输入观点内容";
    }else{
        _placederLab.text = @"";
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end

//
//  SKMyAnswerViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2019/4/28.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKMyAnswerViewController.h"

@interface SKMyAnswerViewController ()<UITextFieldDelegate , UITextViewDelegate>
{
UILabel *_placeholderLab;
}
@property (nonatomic , weak)UILabel *contentLab;
@property (nonatomic , weak)UITextView *contentTV;
@property (nonatomic , weak)UIButton *commitButton;

@end

@implementation SKMyAnswerViewController

- (UILabel *)contentLab
{
if (!_contentLab) {
UILabel *tf = [[UILabel alloc] init];
tf.backgroundColor = [UIColor whiteColor];;
tf.font = kFont(15);
tf.numberOfLines = 0;
WS(weakSelf);
[weakSelf.view addSubview:tf];
[tf mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.equalTo(weakSelf.view.mas_left).offset(15);
make.right.equalTo(weakSelf.view.mas_right).offset(-15);
make.top.equalTo(weakSelf.view.mas_top).offset(20);
}];
_contentLab = tf;
}
return _contentLab;
}
- (UITextView *)contentTV
{
if (!_contentTV) {
UITextView *tf = [[UITextView alloc] init];
//        tf.text = @"请输入观点内容";
tf.backgroundColor = [UIColor whiteColor];
tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
tf.textAlignment = NSTextAlignmentLeft;
tf.delegate = self;
WS(weakSelf);
[weakSelf.view addSubview:tf];
[tf mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.equalTo(weakSelf.view.mas_left).offset(15);
make.right.equalTo(weakSelf.view.mas_right).offset(-15);
make.top.equalTo(weakSelf.contentLab.mas_bottom).offset(20);
make.height.equalTo(@(135));
}];
_contentTV = tf;
}
return _contentTV;
}
- (UIButton *)commitButton
{
if (!_commitButton) {
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
[button setTitle:@"提交" forState:0];
[button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
button.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
button.clipsToBounds = YES;
button.layer.cornerRadius = 22.5;
[button addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
WS(weakSelf);
[self.view addSubview:button];
[button mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.equalTo(weakSelf.view.mas_left).offset(13);
make.right.equalTo(weakSelf.view.mas_right).offset(-13);
make.top.equalTo(weakSelf.contentTV.mas_bottom).offset(25);
make.height.equalTo(@(45));
}];
_commitButton = button;
}
return _commitButton;
}
- (void)viewDidLoad {
[super viewDidLoad];
self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
self.contentLab.text = self.content;
[self.commitButton setTitle:@"提交" forState:0];
[self addplaceholderLab];
// Do any additional setup after loading the view.
}
- (void)addplaceholderLab
{
_placeholderLab = [[UILabel alloc] init];
_placeholderLab.text = @" 请输入回答内容";
_placeholderLab.enabled = NO;
_placeholderLab.font = kFont(15);
[self.view addSubview:_placeholderLab];
WS(weakSelf);
[_placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.equalTo(weakSelf.view.mas_left).offset(13);
make.right.equalTo(weakSelf.view.mas_right).offset(-13);
make.top.equalTo(weakSelf.contentLab.mas_bottom).offset(25);
make.height.equalTo(@(25));
}];
}
- (void)commitClick
{
if( _contentTV.text.length < 1){
[self.view toastShow:@"请检查您的输入信息"];
}else{
WS(weakSelf);
NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"content":_contentTV.text,@"hid":self.hid};
[SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
[weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
if(code == 0){
[weakSelf.navigationController popViewControllerAnimated:YES];
}
} andfail:^(NSError *error) {

} path:@"answer_add"];
}
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
_placeholderLab.text = @" 请输入回答内容";
}else{
_placeholderLab.text = @"";
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

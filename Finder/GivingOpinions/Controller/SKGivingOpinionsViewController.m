//
//  SKGivingOpinionsViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKGivingOpinionsViewController.h"

@interface SKGivingOpinionsViewController ()<UITextFieldDelegate , UITextViewDelegate>
{
    UILabel *_placeholderLab;
NSString *_CurrentType;
}
@property (nonatomic , weak)UITextField *titleTF;
@property (nonatomic , weak)UITextView *contentTV;
@property (nonatomic , weak)UIButton *commitButton;
@property (nonatomic , weak)UIButton *slectedTypeButton;
@end

@implementation SKGivingOpinionsViewController
- (UITextField *)titleTF
{
    if (!_titleTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入观点标题";
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
            make.top.equalTo(weakSelf.view.mas_top).offset(20);
         make.height.equalTo(@(30));
        }];
        _titleTF = tf;
    }
    return _titleTF;
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
            make.top.equalTo(weakSelf.titleTF.mas_bottom).offset(20);
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
- (UIButton *)slectedTypeButton
{
if (!_slectedTypeButton) {
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
[button setTitle:@"请选择您的提问类型" forState:0];
[button setTitleColor:[UIColor hexStringToColor:@"333333"] forState:0];
button.titleLabel.font = kFont(15);
button.backgroundColor = [UIColor whiteColor];
button.titleLabel.textAlignment = NSTextAlignmentLeft;
[button addTarget:self action:@selector(selectedType) forControlEvents:UIControlEventTouchUpInside];
WS(weakSelf);
[self.view addSubview:button];
[button mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.equalTo(weakSelf.titleTF.mas_left).offset(13);
make.right.equalTo(weakSelf.titleTF.mas_right).offset(-13);
make.top.equalTo(weakSelf.titleTF.mas_top).offset(0);
make.height.equalTo(@(30));
}];
_slectedTypeButton = button;
}
return _slectedTypeButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.type == 1) {
         [self.commitButton setTitle:@"提问" forState:0];
    self.titleTF.placeholder = @"";
    self.titleTF.enabled = NO;
    [self slectedTypeButton];
    }else{
       [self.commitButton setTitle:@"提交" forState:0];
    }
    [self addplaceholderLab];
    // Do any additional setup after loading the view.
}
- (void)addplaceholderLab
{
    _placeholderLab = [[UILabel alloc] init];
    _placeholderLab.text = @" 请输入观点内容";
if (self.type == 1) {
_placeholderLab.text = @" 请输入问答内容";
}
    _placeholderLab.enabled = NO;
    _placeholderLab.font = kFont(15);
    [self.view addSubview:_placeholderLab];
    WS(weakSelf);
    [_placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(13);
        make.right.equalTo(weakSelf.view.mas_right).offset(-13);
       make.top.equalTo(weakSelf.titleTF.mas_bottom).offset(25);
        make.height.equalTo(@(25));
    }];
}
- (void)selectedType{
        WS(weakSelf);
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        _CurrentType = @"3";
        [weakSelf.slectedTypeButton setTitle:@"其他" forState:0];
        }];
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"个股" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _CurrentType = @"1";
        [weakSelf.slectedTypeButton setTitle:@"个股" forState:0];
        }];


        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"大盘" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _CurrentType = @"2";
        [weakSelf.slectedTypeButton setTitle:@"大盘" forState:0];
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:camera];
        [alertVc addAction:picture];
        [self presentViewController:alertVc animated:YES completion:nil];
}
- (void)commitClick
{
     if (self.type == 1) {
     self.titleTF.text = @"      ";
     }
         if(self.titleTF.text.length < 1 || _contentTV.text.length < 1){
        [self.view toastShow:@"请检查您的输入信息"];
    }else{
        WS(weakSelf);
        NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"title":self.titleTF.text,@"content":_contentTV.text};
    NSString *path;
    if (self.type == 1) {
    if ([_CurrentType intValue] < 1) {
    [self.view toastShow:@"请选择提问类型"];
    return;
    }
    path = @"tiwen";
    params =  @{@"token":[SKUserInfoModel userToken],@"content":_contentTV.text,@"type":_CurrentType,@"tid":self.tid};
    }else{
    path = @"point";
    }
    [self.view endEditing:YES];
        [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
             [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
          if(code == 0){
            [weakSelf.navigationController popViewControllerAnimated:YES];
           }
        } andfail:^(NSError *error) {
            
        } path:path];
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
        _placeholderLab.text = @" 请输入观点内容";
    if (self.type == 1) {
    _placeholderLab.text = @" 请输入问答内容";
    }
    }else{
        _placeholderLab.text = @"";
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
[self.view endEditing:YES];
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

//
//  SKAddressViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/22.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKAddressViewController.h"

@interface SKAddressViewController ()<UITextFieldDelegate , UITextViewDelegate>

{
     UILabel *_placeholderLab;
}

@property (nonatomic , weak)UIButton *commitBtn;

@property (nonatomic , weak)UIView *bgView;

@property (nonatomic , weak)UITextField *nickNameTF;

@property (nonatomic , weak)UITextField *mobileTF;

@property (nonatomic , weak)UITextView *addressTV;

@end

@implementation SKAddressViewController
- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"修改地址" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        button.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
        [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.view).offset(0);
            make.height.equalTo(@(45));
        }];
        _commitBtn = button;
    }
    return _commitBtn;
}
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(weakSelf.view).offset(0);
            make.height.equalTo(@(265));
        }];
        _bgView = view;
    }
    return _bgView;
}
- (UITextField *)nickNameTF
{
    if (!_nickNameTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入姓名";
        tf.font = kFont(17);
        tf.textColor = ktextColor;
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(123);
            make.right.equalTo(weakSelf.view.mas_right).offset(-15);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
            make.height.equalTo(@(20));
        }];
        _nickNameTF = tf;
    }
    return _nickNameTF;
}
- (UITextField *)mobileTF
{
    if (!_mobileTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入手机号码";
        tf.font = kFont(17);
        tf.textColor = ktextColor;
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(123);
            make.right.equalTo(weakSelf.view.mas_right).offset(-15);
            make.top.equalTo(weakSelf.nickNameTF.mas_bottom).offset(41);
            make.height.equalTo(@(20));
        }];
        _mobileTF = tf;
    }
    return _mobileTF;
}
- (UITextView *)addressTV
{
    if (!_addressTV) {
        UITextView *textView = [[UITextView alloc] init];
        [self.bgView addSubview:textView];
        textView.delegate = self;
        WS(weakSelf);
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(13);
            make.right.equalTo(weakSelf.view.mas_right).offset(-15);
            make.top.equalTo(weakSelf.mobileTF.mas_bottom).offset(81);
            make.height.equalTo(@(70));
        }];
        _addressTV = textView;
    }
    return _addressTV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self commitBtn];
    [self initView];
    // Do any additional setup after loading the view.
}
- (void)config{
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken]};
    [SVCCommunityApi GoodsListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSDictionary *dict = [JSON objectForKey:@"data"];
            if ([dict isKindOfClass:[NSNull class]]) {
                
            }else {
                weakSelf.nickNameTF.text = [dict objectForKey:@"name"];
                weakSelf.mobileTF.text = [dict objectForKey:@"phone"];
                weakSelf.addressTV.text = [dict objectForKey:@"address"];
                _placeholderLab.text = @"";
            }
        }
    } andfail:^(NSError *error) {
        
    } path:@"getAddress"];
}
- (void)initView{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"收货人姓名";
    label.font = kFont(18);
    label.textColor = [UIColor hexStringToColor:@"838383"];
    label.textAlignment = NSTextAlignmentLeft;
    WS(weakSelf);
    [weakSelf.bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(13);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(100));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(13);
        make.top.equalTo(label.mas_bottom).offset(20);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"手机号码";
    label1.font = kFont(18);
    label1.textColor = [UIColor hexStringToColor:@"838383"];
    label1.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(13);
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(100));
    }];
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(13);
        make.top.equalTo(label1.mas_bottom).offset(20);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"地址";
    label2.font = kFont(18);
    label2.textColor = [UIColor hexStringToColor:@"838383"];
    label2.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(13);
        make.top.equalTo(lineView1.mas_bottom).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(100));
    }];
    
    _placeholderLab = [[UILabel alloc] init];
    _placeholderLab.text = @"请填写详细收货地址";
    _placeholderLab.enabled = NO;
    _placeholderLab.font = kFont(15);
    [self.view addSubview:_placeholderLab];
    [_placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(13);
        make.right.equalTo(weakSelf.view.mas_right).offset(-13);
        make.top.equalTo(weakSelf.addressTV.mas_top).offset(2.5);
        make.height.equalTo(@(25));
    }];
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeholderLab.text = @"请填写详细收货地址";
    }else{
        _placeholderLab.text = @"";
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
- (void)sureClick
{
    if(_nickNameTF.text.length < 1 || _addressTV.text.length < 1 || _mobileTF.text.length < 1){
        [self.view toastShow:@"请检查您的输入信息"];
    }else{
        WS(weakSelf);
        NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"name":_nickNameTF.text,@"phone":_mobileTF.text,@"address":_addressTV.text};
        [SVCCommunityApi GoodsListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            [weakSelf.view toastShow:[[JSON objectForKey:@"data"] objectForKey:@"msg"]];
        } andfail:^(NSError *error) {
            
        } path:@"setAddress"];
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

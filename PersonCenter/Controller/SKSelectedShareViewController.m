//
//  SKSelectedShareViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSelectedShareViewController.h"
#import "SKShareselectModel.h"
#import "SKShareselectedInfoCell.h"
@interface SKSelectedShareViewController ()<UITextFieldDelegate , UITableViewDelegate , UITableViewDataSource >
@property (nonatomic , weak)UITextField *cardNumTF;
@property (nonatomic , strong)NSMutableArray *selectedSources;

@property (nonatomic , weak)UITableView *mainTableView;
@end

@implementation SKSelectedShareViewController
- (NSMutableArray *)selectedSources
{
    if (!_selectedSources) {
        _selectedSources = [NSMutableArray new];
    }
    return _selectedSources;
}
- (UITextField *)cardNumTF
{
    if (!_cardNumTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入股票代码/简拼";
        tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.layer.borderWidth = 1.0;
        tf.layer.borderColor = [UIColor hexStringToColor:@"eeeeee"].CGColor;
        [tf addTarget:self action:@selector(shareCardNumChange) forControlEvents:UIControlEventEditingChanged];
        tf.layer.cornerRadius = 6;
        tf.clipsToBounds = YES;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.view addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(13);
            make.right.equalTo(weakSelf.view.mas_right).offset(-13);
        }];
        _cardNumTF = tf;
    }
    return _cardNumTF;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] init];
        WS(weakSelf);
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.rowHeight = 30;
        tab.showsVerticalScrollIndicator = NO;
        [tab registerClass:[SKShareselectedInfoCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tab];
        [tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(0);
            make.right.equalTo(weakSelf.view.mas_right).offset(0);
            make.top.equalTo(weakSelf.cardNumTF.mas_bottom).offset(10);
            make.bottom.equalTo(@(0));
        }];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    if (self.type == 1) {
        [self.cardNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0.01));
            make.top.equalTo(weakSelf.view.mas_top).offset(0);
        }];
        [self requestData:@"position"];
    }else{
        [self.cardNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(40));
            make.top.equalTo(weakSelf.view.mas_top).offset(13);
        }];
    }
}
- (void)requestData:(NSString *)path
{
    WS(weakSelf);
    NSDictionary * params;
    if (self.type == 1) {
        [WSProgressHUD show];
        params = @{@"token":[SKUserInfoModel userToken]};
    }else{
    if ([self.code isEqualToString:@"请输入股票代码/简拼"]) {
        params = @{@"token":[SKUserInfoModel userToken],@"keys":_cardNumTF.text};
    }else{
        params = @{@"token":[SKUserInfoModel userToken],@"keys":self.code};
    }
    }
    [SVCCommunityApi SimulateInfoNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
    if (weakSelf.type == 1) {
    [WSProgressHUD dismiss];
    }
          if (code == 0) {
                    NSArray *data = [JSON objectForKey:@"data"];
                    [weakSelf.selectedSources removeAllObjects];
                    for (NSDictionary *dict in data) {
                        SKShareselectModel *model = [SKShareselectModel initWithDictionary:dict];
                        [weakSelf.selectedSources addObject:model];
                }
            }
        [weakSelf.mainTableView reloadData];
        } andfail:^(NSError *error) {
        if (weakSelf.type == 1) {
        [WSProgressHUD dismiss];
        }
        [weakSelf.view toastShow:netFailString];
     } path:path];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKShareselectedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    SKShareselectModel *model = self.selectedSources[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SKShareselectModel *model = self.selectedSources[indexPath.row];
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(SKshareSelectedViewTypeClickWithcode:gid:amount:type:)]) {
        [_Vdelegate SKshareSelectedViewTypeClickWithcode:model.code gid:model.gid amount:model.amount type:[NSString stringWithFormat:@"%d",self.type]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareCardNumChange
{
//    self.code = @"Y";
    self.code = self.cardNumTF.text;
    [self requestData:@"select"];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

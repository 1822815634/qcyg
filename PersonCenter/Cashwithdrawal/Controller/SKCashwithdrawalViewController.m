//
//  SKCashwithdrawalViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKCashwithdrawalViewController.h"
#import "SKTransactionrecordViewController.h"
#import "SKRelaNamecertificationViewController.h"
#import "SKCashwithdrawaladdCardCell.h"
#import "SKCashoutbuttonViewCell.h"
#import "SKCashoutShowInfoCell.h"
#import "SKCashwithPayPasswordView.h"
#import "SKCashNumCell.h"
#import "SKBankMangerViewController.h"
@interface SKCashwithdrawalViewController ()<UITableViewDelegate , UITableViewDataSource ,SKCashouShowdidClickViewDelegate , SKCashwithPayPasswordViewDelegate>
{
    NSString *_countNum;
    NSNumber *_result;//1已设置支付密码 0未设置
}
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , weak)SKCashwithPayPasswordView *passwordView;
@end

@implementation SKCashwithdrawalViewController
- (SKCashwithPayPasswordView *)passwordView
{
    if (!_passwordView) {
        SKCashwithPayPasswordView *View = [SKCashwithPayPasswordView instanceSKPasswordView];
        View.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
        View.vDelegate = self;
       [[[UIApplication sharedApplication] keyWindow]addSubview:View];
        _passwordView = View;
    }
    return _passwordView;
}
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKCashNumCell" withTab:tab];
          [self registerCell:@"SKCashoutbuttonViewCell" withTab:tab];
         [self registerCell:@"SKCashoutShowInfoCell" withTab:tab];
        [self registerCell:@"SKCashwithdrawaladdCardCell" withTab:tab];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
#pragma mark --> 注册cell
- (void)registerCell:(NSString *)cellName withTab:(UITableView *)tab
{
    [tab registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getIsPayPwd];
}

- (void)getIsPayPwd {
    WS(weakSelf);
    [SVCCommunityApi withdrawWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSDictionary *dict = [JSON objectForKey:@"data"];
            _result = [dict objectForKey:@"result"];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:@"ispaypwd"];
}

-(void)getData{
    WS(weakSelf);
    [SVCCommunityApi withdrawWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSDictionary *dict = [JSON objectForKey:@"data"];
            [weakSelf.sources addObject:dict];
        }
        [weakSelf.mainTableView reloadData];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:@"info"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKCashwithdrawaladdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKCashwithdrawaladdCardCell" forIndexPath:indexPath];
        if (self.sources.count > 0) {
            [cell setaddCardCellInfo:self.sources[0]];
        }
        cell.selectionStyle = 0;
        return cell;
    }else if(indexPath.row == 1){
        SKCashNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKCashNumCell" forIndexPath:indexPath];
        if (self.sources.count > 0) {
            NSDictionary *dict = self.sources[0];
            [cell initBalanceLab:[dict objectForKey:@"money"]];
        }
        [cell.countNumTF addTarget:self action:@selector(EditChange:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = 0;
        return cell;
    }else if(indexPath.row == 2){
        SKCashoutbuttonViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SKCashoutbuttonViewCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.vDelegate = self;
        [cell setbuttontile:@"确认提款" type:1];
        return cell;
    }else{
        SKCashoutShowInfoCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SKCashoutShowInfoCell" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 3:
                [cell settitleLab:@"最快30分钟到账" dec:@"最快30分钟，一般3小时内到账，所有提款24小时内到账(节假日除外)"];
                break;
            case 4:
                [cell settitleLab:@"提款0手续费" dec:@"提款产生的银行手续费全免"];
                break;
            case 5:
                [cell settitleLab:@"支持银行多达10几家" dec:@"推荐您使用工商银行、建设银行、招商银行、农业银行提款，到账最快"];
                break;
            case 6:
                [cell settitleLab:@"温馨提示" dec:@"禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用"];
                break;
            default:
                break;
        }
        cell.selectionStyle = 0;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else if(indexPath.row == 1){
        return 111;
    }else if(indexPath.row == 2){
        return 100;
    }else if(indexPath.row == 4){
        return 50;
    }
    else{
        return 75;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SKBankMangerViewController *bankVC = [[SKBankMangerViewController alloc] init];
        bankVC.title = @"银行卡管理";
        [self.navigationController pushViewController:bankVC animated:YES];
    }
}
#pragma mark --> 输入银行卡密码
- (void)senderDidClick
{
    if ([_countNum integerValue] > 0) {
        [self.view endEditing:YES];
        if ([_result intValue] == 0) {
            //未设置支付密码
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"您尚未设置支付密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不，我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                
            }];
            WS(weakSelf);
            UIAlertAction *camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                SKRelaNamecertificationViewController *RelaNameVC = [[SKRelaNamecertificationViewController alloc] init];
                    RelaNameVC.name_Type = Relapassword;
                    RelaNameVC.title = @"支付密码";
                [self.navigationController pushViewController:RelaNameVC animated:YES];
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:camera];
            [self presentViewController:alertVc animated:YES completion:nil];
        } else {
            [self.passwordView show];
        }
    }else{
        [self.view toastShow:@"请检查你的提现金额"];
    }
}
- (void)EditChange:(UITextField *)tf
{
    _countNum = tf.text;
}
#pragma mark --> 获取密码
- (void)getpassWord:(NSString *)password
{
    if ([password isEqualToString:@"Y"]) {
    SKRelaNamecertificationViewController *RelaNameVC = [[SKRelaNamecertificationViewController alloc] init];
    RelaNameVC.name_Type = Relapassword;
    RelaNameVC.title = @"支付密码";
    [self.navigationController pushViewController:RelaNameVC animated:YES];
    }else{
        if ([_countNum integerValue ] < 1) {
            [self.view toastShow:@"请输入合法数字"];
            return;
        }
        WS(weakSelf);
        NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"money":_countNum,@"paypwd":password};
        [SVCCommunityApi withdrawWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                [weakSelf onClickedOKbtn];
            }
        [weakSelf.view toastShow:msg];
        } andfail:^(NSError *error) {
            
        } path:@"apply"];
    }
}
#pragma mark --> 点击提现
- (void)onClickedOKbtn
{
    SKTransactionrecordViewController *transtionVC = [[SKTransactionrecordViewController alloc] init];
    transtionVC.title = @"交易记录";
    transtionVC.indexTag = 3;
    [self.navigationController pushViewController:transtionVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

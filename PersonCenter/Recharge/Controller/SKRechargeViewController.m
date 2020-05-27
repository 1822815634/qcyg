//
//  SKRechargeViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/25.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRechargeViewController.h"
#import "SKTransactionrecordViewController.h"
#import "SKBullraceheaderView.h"
#import "SKCashoutbuttonViewCell.h"
#import "XMThireWebViewController.h"
#import "SKrechargeTypeCell.h"
#import "SKrechargeNumCell.h"
#import "SKrechargeShowInfoCell.h"
#import "SKPaytypeInfoViewCell.h"
#import "SKrechargeBankInfoCell.h"
#import "SKxianEduCell.h"
#import "SKAcountblanceCell.h"
@interface SKRechargeViewController ()<SKBullraceheaderViewDelegate ,UITableViewDelegate , UITableViewDataSource , SKCashouShowdidClickViewDelegate , SKrechargeNumCellAcountValuechangeViewDelegate>
{
    NSInteger _currentIndex;
    NSString *_selectedType;
    NSString *_amount;
    NSString *_kuaijiecount;
    NSString *_bankID;
    NSString *_relaName;
    NSString *_identifitId;
    NSArray *_bankList;
    NSString *_balance;
}
@property (nonatomic , weak)SKBullraceheaderView *headerView;
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , strong)NSMutableArray *source;
@property (nonatomic , strong)NSMutableArray *list;
@end

@implementation SKRechargeViewController
- (SKBullraceheaderView *)headerView
{
    if (!_headerView) {
        SKBullraceheaderView *view = [[SKBullraceheaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 44);
        view.vDelegate = self;
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (NSMutableArray *)source
{
    if (!_source) {
        _source = [NSMutableArray new];
    }
    return _source;
}
- (NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight - Knavheight - 44) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKrechargeNumCell" withTab:tab];
        [self registerCell:@"SKCashoutbuttonViewCell" withTab:tab];
        [self registerCell:@"SKrechargeTypeCell" withTab:tab];
        [self registerCell:@"SKrechargeShowInfoCell" withTab:tab];
        [self registerCell:@"SKPaytypeInfoViewCell" withTab:tab];
         [self registerCell:@"SKPaytypeInfoViewCell" withTab:tab];
         [self registerCell:@"SKrechargeBankInfoCell" withTab:tab];
         [self registerCell:@"SKxianEduCell" withTab:tab];
         [self registerCell:@"SKAcountblanceCell" withTab:tab];
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
    self.view.backgroundColor = [UIColor whiteColor];
    _bankList = @[@"中国银行",@"建设银行",@"交通银行",@"兴业银行",@"中信银行",@"平安银行",@"邮政银行",@"浦发银行",@"光大银行",@"招商银行",@"民生银行"];
    _currentIndex = 1;
    _selectedType = @"请选择支付方式";
    _amount = @"0";
    [self.headerView setupView:_currentIndex titleArr:@[@"线下充值",@"线上支付"]];
//    [self.headerView setupView:_currentIndex titleArr:@[@"线下充值"]];
    // Do any additional setup after loading the view.
}
- (void)config{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    [self request1:group];
    [self request3:group];
    [self request4:group];
    [self getBalanceWithgroup:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.mainTableView reloadData];
    });
}
- (void)request1:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi getRechargePayWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.datas addObject:JSON];
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
      dispatch_group_leave(group);
    } path:@"getpay"];
}
#pragma mark -->获取余额
- (void)getBalanceWithgroup:(dispatch_group_t)group{
     NSDictionary *params = @{@"token":[SKUserInfoModel userToken]};
     dispatch_group_enter(group);
     [SVCCommunityApi getBalanceWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
     _balance = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"balance"]];
     }
     dispatch_group_leave(group);
     } andfail:^(NSError *error) {
     dispatch_group_leave(group);
     }];
}
#pragma mark --> 线下充值信息
- (void)request3:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi getRechargePayWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            if (JSON) {
                [weakSelf.list addObject:JSON];
            }
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
    } path:@"querypayinfo"];
}
- (void)request4:(dispatch_group_t)group {
//    WS(weakSelf);
    dispatch_group_enter(group);
     [SVCCommunityApi getRzPayInfoWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
      NSDictionary *dictionary = [JSON objectForKey:@"data"];
     _relaName = [dictionary objectForKey:@"username"];
      _identifitId = [dictionary objectForKey:@"cert_no"];
      _bankID = [dictionary objectForKey:@"bankcard"];
     }
    dispatch_group_leave(group);
    } andfail:^(NSError *error) {
    dispatch_group_leave(group);
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 1) {
        if (indexPath.row == 0) {
        return [self SKrechargeNumCellType:@"充值金额" placeString:@"请输入充值金额" tab:tableView index:indexPath textType:0 content:@""];
        }else if (indexPath.row == 1){
            SKrechargeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKrechargeTypeCell" forIndexPath:indexPath];
            [cell selectedType:_selectedType];
            cell.selectionStyle = 0;
            return cell;
        }else if (indexPath.row == 2){
            return [self SKCashoutbuttonViewCellType:@"提交" tab:tableView index:indexPath];
        }else if (indexPath.row == 3){
            SKrechargeShowInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKrechargeShowInfoCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            return cell;
        }else{
            SKPaytypeInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPaytypeInfoViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            NSDictionary *dict;
            if (self.datas.count > 0) {
                dict = self.datas[0];
            }
            switch (indexPath.row) {
                case 4:
                    [cell setupViewType:2 countName:[dict objectForKey:@"bank_account"] conutType:[dict objectForKey:@"bank_name"] countInfo:[dict objectForKey:@"bank_addr"] imagPath:[dict objectForKey:@"bank_img"]];
                    break;
                case 5:
                    [cell setupViewType:1 countName:@"支付宝" conutType:@"扫码支付" countInfo:[dict objectForKey:@"bank_addr"] imagPath:[dict objectForKey:@"pay_img"]];
                    break;
                case 6:
                    [cell setupViewType:1 countName:@"微信" conutType:@"扫码支付" countInfo:[dict objectForKey:@"wx_account"] imagPath:[dict objectForKey:@"wx_img"]];
                    break;
                default:
                    break;
            }
            return cell;
        }
    }else{
        NSDictionary *dict;
        if (self.list.count > 0) {
            dict = self.list[0];
        }
        if (indexPath.row == 0) {
            return [self SKAcountblanceCellType:_balance tab:tableView index:indexPath];
        }else if (indexPath.row == 4){
        return [self SKrechargeNumCellType:@"*充值金额" placeString:@"请输入充值金额" tab:tableView index:indexPath textType:1 content:_kuaijiecount];
        }
        else if (indexPath.row == 1){
        return [self SKrechargeNumCellType:@"*银行账号" placeString:@"请输入银行账号" tab:tableView index:indexPath textType:1 content:_bankID];
        }
        else if (indexPath.row == 2){
        return [self SKrechargeNumCellType:@"*真实姓名" placeString:@"请输入真实姓名" tab:tableView index:indexPath textType:1 content:_relaName];
        }
        else if (indexPath.row == 3){
            return [self SKrechargeNumCellType:@"*身份证号" placeString:@"请输入身份证号" tab:tableView index:indexPath textType:1 content:_identifitId];
        }else if (indexPath.row == 5){
            return [self SKCashoutbuttonViewCellType:@"提交" tab:tableView index:indexPath];
        }else if(indexPath.row == 6){
            return [self SKxianEduCellType:@"快捷支付-手机端限额" tab:tableView index:indexPath];
        }else{
            return [self SKrechargeBankInfoCellType:_bankList[indexPath.row - 7] tab:tableView index:indexPath];
        }
    }
}
- (SKrechargeNumCell *)SKrechargeNumCellType:(NSString *)type placeString:(NSString *)pla tab:(UITableView *)tab index:(NSIndexPath *)index textType:(NSInteger)textType content:(NSString *)content
{
    SKrechargeNumCell *cell = [tab dequeueReusableCellWithIdentifier:@"SKrechargeNumCell" forIndexPath:index];
    [cell setupViewWithType:type placeString:pla type:textType index:index.row];
    cell.vDelegate = self;
    if (_currentIndex == 3) {
    
    }else{
        cell.AcountTF.enabled = YES;
        cell.AcountTF.text = @"";
        if (_currentIndex == 1) {
            if ([_amount integerValue] > 0) {
              cell.AcountTF.text = _amount;
            }
        }else{
        if (content.length > 0) {
        cell.AcountTF.text = content;
        }
        }
        cell.AcountTF.placeholder = pla;
    
    }
   
    cell.selectionStyle = 0;
    return cell;
}

- (SKAcountblanceCell *)SKAcountblanceCellType:(NSString *)type tab:(UITableView *)tab index:(NSIndexPath *)index
{
    SKAcountblanceCell *cell = [tab dequeueReusableCellWithIdentifier:@"SKAcountblanceCell" forIndexPath:index];
    [cell setAcountLabText:type];
    cell.selectionStyle = 0;
    return cell;
}
- (SKrechargeBankInfoCell *)SKrechargeBankInfoCellType:(NSString *)type tab:(UITableView *)tab index:(NSIndexPath *)index
{
    SKrechargeBankInfoCell *cell = [tab dequeueReusableCellWithIdentifier:@"SKrechargeBankInfoCell" forIndexPath:index];
    [cell setbankInfo:type];
    cell.selectionStyle = 0;
    return cell;
}
- (SKCashoutbuttonViewCell *)SKCashoutbuttonViewCellType:(NSString *)type tab:(UITableView *)tab index:(NSIndexPath *)index
{
    SKCashoutbuttonViewCell *cell = [tab dequeueReusableCellWithIdentifier:@"SKCashoutbuttonViewCell" forIndexPath:index];
    [cell setbuttontile:type type:1];
    cell.vDelegate = self;
    cell.selectionStyle = 0;
    return cell;
}
- (SKxianEduCell *)SKxianEduCellType:(NSString *)type tab:(UITableView *)tab index:(NSIndexPath *)index
{
    SKxianEduCell *cell = [tab dequeueReusableCellWithIdentifier:@"SKxianEduCell" forIndexPath:index];
    [cell setupxianEdu:type];
    cell.selectionStyle = 0;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex == 1) {
        return 7;
    }else{
    return _bankList.count + 7;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 1) {
        if(indexPath.row == 1 || indexPath.row == 0){
            return 60;
        }else if (indexPath.row == 2){
            return 100;
        }else if (indexPath.row == 3){
            return 85;
        }else{
            return 88;
        }
    }else{
        if(indexPath.row == 3){
            return 40;
        }else if (indexPath.row == 5){
            return 100;
        }else{
            return 60;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_currentIndex == 1 && indexPath.row == 1) {
        [self creatAlertController_sheet:@"请选择支付方式"];
    }
}
-(void)creatAlertController_sheet:(NSString *)msg {
    NSDictionary *dict;
    if (self.datas.count > 0) {
        dict = self.datas[0];
    }
    NSArray *payList = [dict objectForKey:@"pay_way"];
    WS(weakSelf);
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:payList[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _selectedType = payList[0];
        [weakSelf.mainTableView reloadData];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:payList[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _selectedType = payList[1];
          [weakSelf.mainTableView reloadData];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:payList[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _selectedType = payList[2];
          [weakSelf.mainTableView reloadData];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
     [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
     [actionSheet addAction:action4];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)SKBullraceheaderViewTypeViewClick:(NSInteger)tag
{
    _currentIndex = tag;
    [self.mainTableView reloadData];
}
- (void)AcountValuechange:(NSString *)acount index:(NSInteger)index
{
      if (_currentIndex == 1) {
      _amount = acount;
      }else{
      if (index == 1) {
      _bankID = acount;
      }else if (index == 2){
      _relaName = acount;
      }else if (index == 3){
      _identifitId = acount;
      }else{
      _kuaijiecount = acount;
      }
      }
}
- (void)senderDidClick
{
    if (_currentIndex == 1) {
        if ([_selectedType isEqualToString:@"请选择支付方式"]) {
            [self.view toastShow:@"请选择支付方式"];
            return;
        }else{
            [self commint:_amount type:1 path:@"pay"];
        }
    }else{
         [self commint:_kuaijiecount type:3 path:@"ysb_charge"];
    }
}
- (void)commint:(NSString *)acount type:(NSInteger)type path:(NSString *)path{
    if ([acount integerValue] > 0) {
        NSDictionary *param;
        if (type == 3) {
        if (_bankID.length < 1 || _identifitId.length < 1 || _relaName.length < 1) {
        [self.view toastShow:@"请检查您的输入"];
        }else{
            [self kuaijiePay:[SKUserInfoModel userToken] order_am:_kuaijiecount bankcard:_bankID username:_relaName cert_no:_identifitId];
        }
        }else{
                param = @{@"token":[SKUserInfoModel userToken],@"title":_selectedType,@"amount":_amount};
            [self commitOfflinepay:param path:path type:type];
        }
    }else{
        [self.view toastShow:@"请输入充值金额"];
    }
}
#pragma mark --> 交易记录
- (void)Transactionrecord
{
    SKTransactionrecordViewController *transtionVC = [[SKTransactionrecordViewController alloc] init];
    transtionVC.title = @"交易记录";
    transtionVC.indexTag = 1;
    [self.navigationController pushViewController:transtionVC animated:YES];
}
#pragma mark --> 提交支付
- (void)commitOfflinepay:(NSDictionary *)dict path:(NSString *)path type:(NSInteger)type
{
    WS(weakSelf);
    [SVCCommunityApi offLineRechargeWithNSDictionary:dict BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.view toastShow:msg];
        }
        if (type == 1) {
            [weakSelf Transactionrecord];
        }
    } andfail:^(NSError *error) {
        
    } path:path];
}
#pragma mark --> 跳转第三方支付
- (void)kuaijiePay:(NSString *)param order_am:(NSString *)order_am bankcard:(NSString *)bankcard username:(NSString *)username cert_no:(NSString *)cert_no
{
    XMThireWebViewController *vc = [[XMThireWebViewController alloc]init];
    vc.httpStr = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/pay/fuypay_send"];
    vc.prameStr = param;
    vc.order_am = order_am;
    vc.bankcard = bankcard;
    vc.cert_no = cert_no;
    vc.username = username;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

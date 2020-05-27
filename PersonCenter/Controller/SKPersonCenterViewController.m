//
//  SKPersonCenterViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPersonCenterViewController.h"
#import "SKIntegralmallViewController.h"
#import "SKHelperCenterViewController.h"
#import "BSWKwebViewController.h"
#import "SVCTabBarController.h"
#import "SKPromotemoneyViewController.h"
#import "SKApplyconfiyViewController.h"
#import "SKRelaNamecertificationViewController.h"
#import "SKMyCouponViewController.h"
#import "SKSettingViewController.h"
#import "SKBankMangerViewController.h"
#import "SKAssetmanagementViewController.h"
#import "SKCashwithdrawalViewController.h"
#import "SKRechargeViewController.h"
#import "SKAnalogdiskViewController.h"
#import "SKLiftibgsurplusViewController.h"
#import "SKTransactionrecordViewController.h"
#import "SKpersonOperaTypeCell.h"
#import "SKPersonInfoHeaderView.h"
#import "SKPersonMainTypeCell.h"
@interface SKPersonCenterViewController ()<UITableViewDelegate , UITableViewDataSource , SKPersonInfoHeaderViewSettingClickViewDelegate , SKPersonMainTypeCellDelegate , SKpersonOperaTypeCellDelegate , SKSettingViewControllerReflashDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *ConstractList;
@end

@implementation SKPersonCenterViewController
- (NSMutableArray *)ConstractList
{
    if (!_ConstractList) {
        _ConstractList = [NSMutableArray new];
    }
    return _ConstractList;
}
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configData];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, -kstatueHeight, kScreenWidth, kScreenHeight - kTabbarHeight + kstatueHeight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
         [self registerCell:@"SKpersonOperaTypeCell" withTab:tab];
        [self registerCell:@"SKPersonMainTypeCell" withTab:tab];
        [tab registerNib:[UINib nibWithNibName:@"SKPersonInfoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SKPersonInfoHeaderView"];
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
    [self mainTableView];
    if ([SKUserInfoModel userToken].length < 6) {
        [self.view toastShow:@"请先点击设置->退出登录->去登录界面登录"];
    }
      [self initConstactButtton];
}
- (void)initConstactButtton
{
    UIButton *constactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [constactBtn setImage:showImage(@"在线客服") forState:0];
    [self.view addSubview:constactBtn];
    [constactBtn addTarget:self action:@selector(constractUS) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    [constactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(- 13);
        make.height.width.equalTo(@(60));
    }];
    
}
#pragma mark --> 点击在线客服
- (void)constractUS
{
    
    [self initWebWithPath:[[NSUserDefaults standardUserDefaults] objectForKey:@"kefu"] title:@"在线客服"];
}
#pragma mark --> 跳转判断
- (void)webChange:(NSInteger)tag title:(NSString *)title
{
    if (self.ConstractList.count > 0) {
        NSDictionary *dict = self.ConstractList[tag];
        [self initWebWithPath:[dict objectForKey:@"url"] title:title];
    }
}
#pragma mark -->  跳转H5
- (void)initWebWithPath:(NSString *)path title:(NSString *)title
{
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = path;
    constactVC.title = title;
    [self.navigationController pushViewController:constactVC animated:YES];
}
- (void)configData
{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    [self request1:group];
    [self request2:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.mainTableView reloadData];
    });
}
#pragma mark -->获取用户信息
- (void)request1:(dispatch_group_t)group
{
    WS(weakSelf);
     dispatch_group_enter(group);
   [SVCCommunityApi userInfoWithNSDictionary:@{@"token":[SKUserInfoModel userToken],@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        NSDictionary *dict = [JSON objectForKey:@"data"];
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
        [weakSelf.sources addObject:dict];
        }else if (code == 400){
        [weakSelf logout];
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
         dispatch_group_leave(group);
    }];
}
#pragma mark -->重新登录
- (void)logout{
        SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
        logVC.title = @"登录";
        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
        [SKUserInfoModel deleteModel];
        [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark --> 设置相关
- (void)request2:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi abouthelpNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.ConstractList removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                [weakSelf.ConstractList addObject:dict];
            }
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}
#pragma mark --> tab 代理函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]) {
        SKpersonOperaTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKpersonOperaTypeCell" forIndexPath:indexPath];
        cell.Vdelegate = self;
        cell.selectionStyle = 0;
        switch (indexPath.section) {
//            case 0:
//                [cell initSkpersonOperaTypeCell:@[@"实名认证",@"银行卡绑定",@"支付密码"] imageArr:@[@"实名认证",@"银行卡绑定",@"支付密码"] hidden:YES title:@"交易认证" index:[NSIndexPath indexPathForRow:0 inSection:1]];
//                break;
//            case 1:
//                [cell initSkpersonOperaTypeCell:@[@"账户资产",@"操盘明细",@"续约追保",@"申请配资"] imageArr:@[@"账户资产",@"持仓明细",@"债约追保",@"申请配资"] hidden:NO title:@"账户操作" index:indexPath];
//                break;
            case 0:
//                [cell initSkpersonOperaTypeCell:@[@"我的优惠券",@"推广赚钱",@"大赛操盘",@"金币商城"] imageArr:@[@"我的优惠券",@"推广赚钱",@"大赛操盘",@"积分商城"] hidden:NO title:@"活动与优惠" index:[NSIndexPath indexPathForRow:0 inSection:3]];
                 [cell initSkpersonOperaTypeCell:@[@"我的优惠券",@"推广赚钱",@"大赛操盘"] imageArr:@[@"我的优惠券",@"推广赚钱",@"大赛操盘"] hidden:YES title:@"活动与优惠" index:[NSIndexPath indexPathForRow:0 inSection:3]];
                break;
            case 1:
                [cell initSkpersonOperaTypeCell:@[@"公司介绍",@"帮助中心",@"联系客服"] imageArr:@[@"公司介绍",@"myhelp",@"联系客服"] hidden:YES title:@"关于钱程优顾" index:[NSIndexPath indexPathForRow:0 inSection:4]];
                break;
            default:
                break;
        }
        return cell;
    }
    if (indexPath.section == 0) {
        SKPersonMainTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonMainTypeCell" forIndexPath:indexPath];
        cell.vDelegate = self;
        cell.selectionStyle = 0;
        return cell;
    }else{
    SKpersonOperaTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKpersonOperaTypeCell" forIndexPath:indexPath];
        cell.Vdelegate = self;
    cell.selectionStyle = 0;
        switch (indexPath.section) {
            case 1:
                [cell initSkpersonOperaTypeCell:@[@"实名认证",@"银行卡绑定",@"支付密码"] imageArr:@[@"实名认证",@"银行卡绑定",@"支付密码"] hidden:YES title:@"交易认证" index:indexPath];
                break;
            case 2:
                [cell initSkpersonOperaTypeCell:@[@"账户资产",@"操盘明细",@"续约追保",@"申请配资"] imageArr:@[@"账户资产",@"持仓明细",@"债约追保",@"申请配资"] hidden:NO title:@"账户操作" index:indexPath];
                break;
            case 3:
                [cell initSkpersonOperaTypeCell:@[@"我的优惠券",@"推广赚钱",@"大赛操盘",@"金币商城"] imageArr:@[@"我的优惠券",@"推广赚钱",@"大赛操盘",@"积分商城"] hidden:NO title:@"活动与优惠" index:indexPath];
                break;
            case 4:
                [cell initSkpersonOperaTypeCell:@[@"公司介绍",@"帮助中心",@"联系客服"] imageArr:@[@"公司介绍",@"myhelp",@"联系客服"] hidden:YES title:@"关于钱程优顾" index:indexPath];
                break;
            default:
                break;
        }
    return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SKPersonInfoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKPersonInfoHeaderView"];
        if (self.sources.count > 0) {
            [headerView setupUserInfoHeaderView:self.sources[0]];
        }
        headerView.vDelegate = self;
        return headerView;
    }else{
    return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]){
        return 2;
    }
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]) {
        return 170;
    }
    if (indexPath.section == 0) {
        return 90;
    }else{
        return 170;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]) {
            return 120;
        } else {
            return 204;
        }
    }else{
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 5.f;
    }else if (section == 4){
        return 0.01f;
    }else{
    return 10.0f;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}
#pragma mark --> 设置界面
- (void)SKPersonInfoHeaderViewSettingClick
{
    SKSettingViewController *settingVC = [[SKSettingViewController alloc] init];
    settingVC.title = @"设置";
    settingVC.vDelegate = self;
    if (self.sources.count > 0) {
        settingVC.headerImagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,[self.sources[0] objectForKey:@"avatar"]];
    }
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark --> 头部type点击响应
- (void)SKPersonMainTypeCellClick:(NSInteger)tag
{
    switch (tag) {
            case 1:
            [self Recharge];
            break;
        case 2:
            [self Liftingsurplus];
            break;
        case 3:
            [self Cashwithdrawal];
            break;
        case 4:
            [self Transactionrecord];
            break;
        default:
            break;
    }
}
#pragma mark --> 提盈
-(void)Liftingsurplus
{
    SKLiftibgsurplusViewController *liftingVC = [[SKLiftibgsurplusViewController alloc] init];
    liftingVC.title = @"提盈";
    [self.navigationController pushViewController:liftingVC animated:YES];
}
#pragma mark --> 提现
- (void)Cashwithdrawal
{
    SKCashwithdrawalViewController *CashwithdrawalVC = [[SKCashwithdrawalViewController alloc] init];
    CashwithdrawalVC.title = @"提现";
    [self.navigationController pushViewController:CashwithdrawalVC animated:YES];
}
#pragma mark --> 充值
- (void)Recharge
{
    SKRechargeViewController *rechargeVC = [[SKRechargeViewController alloc] init];
    rechargeVC.title = @"充值";
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
#pragma mark --> 交易记录
- (void)Transactionrecord
{
SKTransactionrecordViewController *transtionVC = [[SKTransactionrecordViewController alloc] init];
transtionVC.title = @"交易记录";
transtionVC.indexTag = 3;
[self.navigationController pushViewController:transtionVC animated:YES];
}
#pragma mark --> 实名认证
- (void)relaNameVCWithtype:(NSInteger)type
{
    SKRelaNamecertificationViewController *RelaNameVC = [[SKRelaNamecertificationViewController alloc] init];
    if (type == 31) {
        RelaNameVC.name_Type = RelaName;
        RelaNameVC.title = @"实名认证";
    }else{
        RelaNameVC.name_Type = Relapassword;
        RelaNameVC.title = @"支付密码";
    }
    [self.navigationController pushViewController:RelaNameVC animated:YES];
}
#pragma mark --> 银行卡管理
- (void)bankManger
{
    SKBankMangerViewController *bankVC = [[SKBankMangerViewController alloc] init];
    bankVC.title = @"银行卡管理";
    [self.navigationController pushViewController:bankVC animated:YES];
}
#pragma mark --> 资产管理
- (void)assetmanagement
{
    SKAssetmanagementViewController *assetmanagementVC = [[SKAssetmanagementViewController alloc] init];
    assetmanagementVC.title = @"资产管理";
    [self.navigationController pushViewController:assetmanagementVC animated:YES];
}
#pragma mark --> 操盘明细
- (void)Caopandetail
{
    SKHelperCenterViewController *detailVC = [[SKHelperCenterViewController alloc] init];
    detailVC.title = @"操盘明细";
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark --> 积分商城
- (void)Integralsmall
{
    SKIntegralmallViewController *smallVC = [[SKIntegralmallViewController alloc] init];
    smallVC.title = @"积分商城";
    [self.navigationController pushViewController:smallVC animated:YES];
}
#pragma mark --> 推广赚钱
- (void)prmotemoney
{
    SKPromotemoneyViewController *promotemoneyVC = [[SKPromotemoneyViewController alloc] init];
    promotemoneyVC.title = @"推广赚钱";
    [self.navigationController pushViewController:promotemoneyVC animated:YES];
}
#pragma mark --> 续约追保
- (void)applycationConfigrationVC
{
    SKApplyconfiyViewController *applyVC = [[SKApplyconfiyViewController alloc] init];
    applyVC.title = @"续约追保";
    [self.navigationController pushViewController:applyVC animated:YES];
}
#pragma mark --> 我的优惠券
- (void)myCouponVC
{
    SKMyCouponViewController *couponVC = [[SKMyCouponViewController alloc] init];
    couponVC.title = @"我的优惠券";
    [self.navigationController pushViewController:couponVC animated:YES];
}
#pragma mark --> 模拟操盘
- (void)SKAnalogdisk
{
    SKAnalogdiskViewController *snlogdiskVC = [[SKAnalogdiskViewController alloc] init];
    snlogdiskVC.title = @"模拟操盘";
    [self.navigationController pushViewController:snlogdiskVC animated:YES];
}
- (void)SKpersonOperaTypeCellTypeClickIndex:(NSInteger)index tag:(NSInteger)tag
{
    if (index == 1) {
        switch (tag) {
            case 31:
            case 33:
                 [self relaNameVCWithtype:tag];
                break;
            case 32:
                [self bankManger];
                break;
            default:
                break;
        }
    }else if (index == 2){
        switch (tag) {
            case 31:
                [self assetmanagement];
                break;
            case 32:
                [self Caopandetail];
                break;
            case 34:
                [self tabbarItemselected:1];
                break;
            case 33:
                [self applycationConfigrationVC];
                break;
            default:
                break;
        }
    }else if (index == 3){
        switch (tag) {
            case 31:
                [self myCouponVC];
                break;
            case 32:
                [self prmotemoney];
                break;
            case 33:
                [self SKAnalogdisk];
                break;
            case 34:
                [self Integralsmall];
                break;
            default:
                break;
        }
    }else{
        switch (tag) {
            case 31:
                [self webChange:0 title:@"公司介绍"];
                break;
            case 32:
                if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]){
                    [self.view toastShow:@"敬请期待"];
                    return;
                }
                [self webChange:4 title:@"帮助中心"];
                break;
            case 33:
                [self constractUS];
                break;
            default:
                break;
        }
    }
}
#pragma mark --> tabbar跳转
- (void)tabbarItemselected:(NSInteger)tag
{
    SVCTabBarController *tabbar = [[SVCTabBarController alloc] init];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    keyWindow.rootViewController = tabbar;
    tabbar.selectedIndex = tag;
}
- (void)updateHeaderImagell
{
    [self configData];
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

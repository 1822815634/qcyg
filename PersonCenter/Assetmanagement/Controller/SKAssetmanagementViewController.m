//
//  SKAssetmanagementViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAssetmanagementViewController.h"
#import "SKAssestDetailViewController.h"
#import "SKCashwithdrawalViewController.h"
#import "SKAssetmentSumCell.h"
#import "SKAssetmentInfoCell.h"
#import "SKAssetModel.h"
@interface SKAssetmanagementViewController ()<UITableViewDelegate , UITableViewDataSource , SKAssetmentSumCelltixianClickViewDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *datas;
@end

@implementation SKAssetmanagementViewController
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
          tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [self registerCell:@"SKAssetmentSumCell" withTab:tab];
         [self registerCell:@"SKAssetmentInfoCell" withTab:tab];
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
    [self addRightBtn];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData
{
    WS(weakSelf);
    [SVCCommunityApi getassetsWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            SKAssetModel *model = [SKAssetModel initWithDictionary:[JSON objectForKey:@"data"]];
            [weakSelf.datas addObject:model];
        }
        [weakSelf.mainTableView reloadData];
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
    } path:@"info"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKAssetModel *model;
    if (self.datas.count > 0) {
        model = self.datas[0];
    }
    if (indexPath.section == 1) {
        SKAssetmentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKAssetmentInfoCell" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = 0;
        return cell;
    }else{
    SKAssetmentSumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKAssetmentSumCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
        cell.vDelegate = self;
    cell.model = model;
    return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return kScreenHeight - Knavheight - 153 - 10;
    }else{
    return 153;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.01f;
    }else{
        return 10.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (void)addRightBtn {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60, 35);
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [but setTitle:@"资金明细"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (void)onClickedOKbtn {
    SKAssestDetailViewController *detailVC = [[SKAssestDetailViewController alloc] init];
    detailVC.title = @"资金明细";
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)tixianClick
{
    SKCashwithdrawalViewController *CashwithdrawalVC = [[SKCashwithdrawalViewController alloc] init];
    CashwithdrawalVC.title = @"提现";
    [self.navigationController pushViewController:CashwithdrawalVC animated:YES];
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

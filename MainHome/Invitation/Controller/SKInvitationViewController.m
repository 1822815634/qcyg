//
//  SKInvitationViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKInvitationViewController.h"
#import "SKInvitationCell.h"
#import "SKInvationModel.h"
#import "SKInbitationInfoCell.h"
#import "SKInvitationNullCell.h"
@interface SKInvitationViewController ()<UITableViewDelegate , UITableViewDataSource ,SKInvitationNullCellDelegate>
{
    NSString *_commission;
    NSString *_count;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKInvitationViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
         tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [self registerCell:@"SKInvitationCell" withTab:tab];
        [self registerCell:@"SKInbitationInfoCell" withTab:tab];
                [self registerCell:@"SKInvitationNullCell" withTab:tab];
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
     [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi expandmoneyWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            weakSelf.type = 1;
            [weakSelf.sources removeAllObjects];
            _commission = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"commission"]];
            _count = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"count"]];
            NSArray *list = [JSON objectForKey:@"list"];
            for (NSDictionary *dict in list) {
                SKInvationModel *model = [SKInvationModel initWithDictionary:dict];
                [weakSelf.sources addObject:model];
            }
        }else{
            weakSelf.type = 0;
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
    } path:@"expand"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SKInbitationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKInbitationInfoCell" forIndexPath:indexPath];
        [cell setupViewWithCommission:_commission count:_count];
        cell.selectionStyle = 0;
        return cell;
    }else{
        if (self.type == 1) {
            SKInvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKInvitationCell" forIndexPath:indexPath];
            SKInvationModel *model = self.sources[indexPath.row];
            cell.model = model;
            cell.selectionStyle = 0;
            return cell;
        }else{
            SKInvitationNullCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKInvitationNullCell" forIndexPath:indexPath];
            cell.vDelegate = self;
            cell.selectionStyle = 0;
            return cell;
        }
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
    if (section == 0) {
        return 1;
    }else{
        if (self.type == 1) {
            return self.sources.count;
        }else{
        return 1;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else{
        if (self.type == 1) {
            return 140;
        }else{
            return kScreenHeight - 100 - 10 - Knavheight;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10.0f;
    }else{
        return 0.01f;
    }
}
- (void)SKInvitationNullCellClick
{
    NSLog(@"我要发起邀请了哟");
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

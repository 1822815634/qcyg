//
//  SKTransactionrecordViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/12/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKTransactionrecordViewController.h"
#import "SKTransactionCell.h"
#import "SKTradeHistoryModel.h"
#import "SKOperaHeaderView.h"
@interface SKTransactionrecordViewController ()<SKOperaHeaderViewTypeViewDelegate , UITableViewDelegate , UITableViewDataSource>
{
     NSInteger _currentIndex;
}
@property (nonatomic , weak)SKOperaHeaderView *headerView;
@property (nonatomic , strong)NSMutableArray *sources1;
@property (nonatomic , strong)NSMutableArray *sources2;
@property (nonatomic , strong)NSMutableArray *sources3;
@property (nonatomic , weak)UITableView *mainTableView;
@end

@implementation SKTransactionrecordViewController
- (NSMutableArray *)sources1
{
    if (!_sources1) {
        _sources1 = [NSMutableArray new];
    }
    return _sources1;
}
- (NSMutableArray *)sources2
{
    if (!_sources2) {
        _sources2 = [NSMutableArray new];
    }
    return _sources2;
}
- (NSMutableArray *)sources3
{
    if (!_sources3) {
        _sources3 = [NSMutableArray new];
    }
    return _sources3;
}
- (SKOperaHeaderView *)headerView
{
    if (!_headerView) {
        SKOperaHeaderView *view = [[SKOperaHeaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 44);
        view.vDelegate = self;
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight - Knavheight - 44) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.rowHeight = 80;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKTransactionCell" withTab:tab];
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
    _currentIndex = 1;
    if (self.indexTag == 2 || self.indexTag == 3) {
        _currentIndex = self.indexTag;
    }
    [self.headerView setupView:_currentIndex titleArr:@[@"线下充值记录",@"线上充值记录",@"提现记录"]];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)config{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    [self request1:group];
    [self request2:group];
    [self request3:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
        [weakSelf.mainTableView reloadData];
    });
}
- (void)request1:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi tradeHistoryWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *list = [JSON objectForKey:@"data"];
            [weakSelf.sources1 removeAllObjects];
            for (NSDictionary *dict in list) {
                SKTradeHistoryModel *model = [SKTradeHistoryModel initWithDictionary:dict];
                [weakSelf.sources1 addObject:model];
            }
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
        dispatch_group_leave(group);
    } path:@"onlog"];
}
- (void)request2:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi tradeHistoryWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *list = [JSON objectForKey:@"data"];
            [weakSelf.sources2 removeAllObjects];
            for (NSDictionary *dict in list) {
                SKTradeHistoryModel *model = [SKTradeHistoryModel initWithDictionary:dict];
                [weakSelf.sources2 addObject:model];
            }
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
         dispatch_group_leave(group);
    } path:@"offlog"];
}
- (void)request3:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi withdrawWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *list = [JSON objectForKey:@"data"];
            [weakSelf.sources3 removeAllObjects];
            for (NSDictionary *dict in list) {
                SKTradeHistoryModel *model = [SKTradeHistoryModel initWithDictionary:dict];
                [weakSelf.sources3 addObject:model];
            }
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
         dispatch_group_leave(group);
    } path:@"log"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKTransactionCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (_currentIndex == 2) {
        [cell setTransactionWithTag:_currentIndex model:self.sources1[indexPath.row]];
    }else if(_currentIndex == 1){
         [cell setTransactionWithTag:_currentIndex model:self.sources2[indexPath.row]];
    }else{
        [cell setTransactionWithTag:_currentIndex model:self.sources3[indexPath.row]];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex == 2) {
        return self.sources1.count;
    }else if (_currentIndex == 1){
        return self.sources2.count;
    }else{
        return self.sources3.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (void)SKOperaHeaderViewTypeViewClick:(NSInteger)tag
{
    _currentIndex = tag;
    [self.mainTableView reloadData];
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

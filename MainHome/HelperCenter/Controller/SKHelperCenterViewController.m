//
//  SKHelperCenterViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/26.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKHelperCenterViewController.h"
#import "SKApplycationConfigerCell.h"
#import "SKapplycationfiguratModel.h"
@interface SKHelperCenterViewController ()<UITableViewDelegate , UITableViewDataSource >
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;

@end

@implementation SKHelperCenterViewController
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
        [self registerCell:@"SKApplycationConfigerCell" withTab:tab];
         tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
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
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi zhaiyueZhuiBaoNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.sources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKapplycationfiguratModel *model = [SKapplycationfiguratModel initWithDictionary:dict];
                [weakSelf.sources addObject:model];
            }
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
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SKApplycationConfigerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKApplycationConfigerCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
    SKapplycationfiguratModel * model = self.sources[indexPath.section];
    [cell initCellWithModel:model];
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
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sources.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10.f;
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

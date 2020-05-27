//
//  SKApplyconfiyViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKApplyconfiyViewController.h"
#import "SKRenewcontractViewController.h"
#import "SKApplycationConfigerCell.h"
#import "SKapplyInfoNodataCell.h"
#import "SKapplycationfiguratModel.h"
@interface SKApplyconfiyViewController ()<UITableViewDelegate , UITableViewDataSource , SKApplycationConfigerCelldidClickViewDelegate , SKapplyInfoNodataCelldidClickViewDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , assign)NSInteger type;
@end

@implementation SKApplyconfiyViewController
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
        [tab registerNib:[UINib nibWithNibName:@"SKApplycationConfigerCell" bundle:nil] forCellReuseIdentifier:@"SKApplycationConfigerCell"];
         [tab registerNib:[UINib nibWithNibName:@"SKapplyInfoNodataCell" bundle:nil] forCellReuseIdentifier:@"SKapplyInfoNodataCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 0;
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi zhaiyueZhuiBaoNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.datas removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKapplycationfiguratModel *model = [SKapplycationfiguratModel initWithDictionary:dict];
                [weakSelf.datas addObject:model];
            }
        }else{
            weakSelf.type = 1;
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
    if (self.type == 0) {
    SKApplycationConfigerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKApplycationConfigerCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.vDelegate = self;
    SKapplycationfiguratModel *model = self.datas[indexPath.section];
    [cell setupViewWithModel:model index:indexPath];
    return cell;
    }else{
        SKapplyInfoNodataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKapplyInfoNodataCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
       cell.vDelegate = self;
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
    if (self.type == 1) {
        return 0;
    }else{
    return self.datas.count;
    }
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == 0) {
        return 210;
    }else{
        return kScreenHeight - Knavheight;
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
- (void)SKApplycationConfigerCellClick:(NSInteger)tag index:(NSIndexPath *)index
{
    SKRenewcontractViewController *renewVC = [[SKRenewcontractViewController alloc] init];
    renewVC.title = @"钱程优顾";
    SKapplycationfiguratModel *model = self.datas[index.section];
    renewVC.uid = model.cid;
    if (tag == 10) {
        renewVC.type = 1;
    }else{
        renewVC.type = 2;
    }
    [self.navigationController pushViewController:renewVC animated:YES];
}
- (void)SKapplyInfoNodataCellClick
{
    NSLog(@"点击开始申请配置");
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

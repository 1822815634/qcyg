//
//  SKWithDrawHistoryViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKWithDrawHistoryViewController.h"
#import "SKTradeHistoryModel.h"
#import "SKTransactionCell.h"
@interface SKWithDrawHistoryViewController ()< UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *sources1;
@property (nonatomic , weak)UITableView *mainTableView;

@end

@implementation SKWithDrawHistoryViewController

- (NSMutableArray *)sources1
{
    if (!_sources1) {
        _sources1 = [NSMutableArray new];
    }
    return _sources1;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.rowHeight = 80;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKTransactionCell" bundle:nil] forCellReuseIdentifier:@"SKTransactionCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi withdrawWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSArray *list = [JSON objectForKey:@"data"];
            [weakSelf.sources1 removeAllObjects];
            for (NSDictionary *dict in list) {
                SKTradeHistoryModel *model = [SKTradeHistoryModel initWithDictionary:dict];
                [weakSelf.sources1 addObject:model];
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
    } path:@"log"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKTransactionCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
        [cell setTransactionWithTag:3 model:self.sources1[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.sources1.count;
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

@end

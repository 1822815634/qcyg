//
//  SKLastAwardViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/16.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKLastAwardViewController.h"
#import "SKRankingInfoTableViewCell.h"
#import "SKLastAwardModel.h"
@interface SKLastAwardViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKLastAwardViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Knavheight ) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.rowHeight = 50;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerNib:[UINib nibWithNibName:@"SKRankingInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKRankingInfoTableViewCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi lastAwardWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKLastAwardModel *model = [SKLastAwardModel initWithDictionary:dict];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SKRankingInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRankingInfoTableViewCell" forIndexPath:indexPath];
    SKLastAwardModel *model = self.sources[indexPath.row];
    [cell setupViewWithlastAardModel:model index:indexPath];
        cell.selectionStyle = 0;
        return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sources.count;
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

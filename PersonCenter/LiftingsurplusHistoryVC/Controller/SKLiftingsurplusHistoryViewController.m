//
//  SKLiftingsurplusHistoryViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKLiftingsurplusHistoryViewController.h"
#import "SKLiftingsurplusHistoryTopCell.h"
#import "SKSKLiftingsurplusHistoryInfoCell.h"
#import "SKLiftingsurplusmodel.h"
@interface SKLiftingsurplusHistoryViewController ()<UITableViewDelegate , UITableViewDataSource >
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *source;
@end

@implementation SKLiftingsurplusHistoryViewController
- (NSMutableArray *)source
{
    if (!_source) {
        _source = [NSMutableArray new];
    }
    return _source;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
         tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKLiftingsurplusHistoryTopCell" bundle:nil] forCellReuseIdentifier:@"SKLiftingsurplusHistoryTopCell"];
         [tab registerNib:[UINib nibWithNibName:@"SKSKLiftingsurplusHistoryInfoCell" bundle:nil] forCellReuseIdentifier:@"SKSKLiftingsurplusHistoryInfoCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi historyTiyingWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        NSLog(@"时间转化有问题");
        if (code == 0) {
             [weakSelf.source removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKLiftingsurplusmodel *model = [SKLiftingsurplusmodel initWithDictionary:dict];
                [weakSelf.source addObject:model];
            }
        }
        [weakSelf.mainTableView reloadData];
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
    } andfail:^(NSError *error) {
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKLiftingsurplusHistoryTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLiftingsurplusHistoryTopCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKSKLiftingsurplusHistoryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKSKLiftingsurplusHistoryInfoCell" forIndexPath:indexPath];
        SKLiftingsurplusmodel *model = self.source[indexPath.row - 1];
        cell.model = model;
        cell.selectionStyle = 0;
        return cell;
    }
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.source.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    }else{
        return 55;
    }
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

//
//  SKMyCouponViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMyCouponViewController.h"
#import "SKCouponModel.h"
#import "SKMycouponCell.h"
@interface SKMyCouponViewController ()<UITableViewDelegate , UITableViewDataSource >
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *datas;
@end

@implementation SKMyCouponViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
         tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKMycouponCell" bundle:nil] forCellReuseIdentifier:@"SKMycouponCell"];
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
    [SVCCommunityApi CouponListWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.datas removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKCouponModel *model = [SKCouponModel initWithDictionary:dict];
                [weakSelf.datas addObject:model];
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
    SKMycouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMycouponCell" forIndexPath:indexPath];
    SKCouponModel *model = self.datas[indexPath.row];
    cell.model = model;
    cell.selectionStyle = 0;
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
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

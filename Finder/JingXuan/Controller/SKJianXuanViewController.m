//
//  SKJianXuanViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJianXuanViewController.h"
#import "SKUserCenterViewController.h"
#import "SKViewPointDetailViewController.h"
#import "SKPointDetailViewController.h"
#import "SKJingXuanCell.h"
#import "SKHasFocusCell.h"
#import "SKviewPointModel.h"
#import "SKReportView.h"
@interface SKJianXuanViewController ()<UITableViewDelegate , UITableViewDataSource , SKJingXuanCellClickViewDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKJianXuanViewController
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
        CGFloat height = [self.uid isEqualToString:@"4"]?kScreenHeight - kTabbarHeight- Knavheight:kScreenHeight - kTabbarHeight - Knavheight - 164;
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, height) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.estimatedRowHeight = 100;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
         tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKJingXuanCell" bundle:nil] forCellReuseIdentifier:@"SKJingXuanCell"];
          [tab registerNib:[UINib nibWithNibName:@"SKHasFocusCell" bundle:nil] forCellReuseIdentifier:@"SKHasFocusCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainTableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(loginSuccessful) name:@"loginSuccessful" object:nil];
}
- (void)loginSuccessful
{
    [self configData];
}
- (void)configData{
    WS(weakSelf);
    if ([SKUserInfoModel userToken].length < 6) {
        [self.view toastShow:@"请先到我的页面去登录"];
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
        return;
    }
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"type":self.uid,@"timeformat":@"Y-m-d H:m:s",@"limit":@"10000"};
    [SVCCommunityApi questionListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKviewPointModel *model = [SKviewPointModel initWithDictionary:dict];
                [weakSelf.sources addObject:model];
            }
        }else if (code == 400){
        [weakSelf logout];
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
    } path:@"lists"];
}- (void)logout{
       SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
       logVC.title = @"登录";
       SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
       [SKUserInfoModel deleteModel];
       [self presentViewController:nav animated:YES completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.uid isEqualToString:@"4"]) {
        SKHasFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKHasFocusCell" forIndexPath:indexPath];
         SKviewPointModel *model = self.sources[indexPath.row];
        cell.model = model;
        cell.selectionStyle = 0;
        return cell;
    }else{
    SKJingXuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJingXuanCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    SKviewPointModel *model = self.sources[indexPath.row];
    [cell setviewPointModel:model index:indexPath type:0];
    cell.vDelegate = self;
    return cell;
    }
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sources.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKviewPointModel *model = self.sources[indexPath.row];
    
    if (![self.uid isEqualToString:@"4"]) {
        [self gotoViewPointVC:model];
    } else {
        [self attentionClick:indexPath];
    }
}
- (void)gotoViewPointVC:(SKviewPointModel *)model
{
    SKPointDetailViewController *pointVC = [[SKPointDetailViewController alloc] init];
    pointVC.title = @"钱程优顾";
    pointVC.content = model.content;
    pointVC.TXtitle = model.title;
    pointVC.right = model.create_time;
    pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
    [self.navigationController pushViewController:pointVC animated:YES];
}

- (void)poinViewtouchEndClick:(NSIndexPath *)index
{
    WS(weakSelf);
    SKviewPointModel *model = self.sources[index.row];
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":[NSString stringWithFormat:@"%ld",(long)model.uid]};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
            [weakSelf configData];
        }else if (code == 400){
        [weakSelf logout];
        }
    } andfail:^(NSError *error) {
        
    } path:@"attention"];
}

- (void)reoprtBtnClick {
    //举报
    SKReportView *sk = [[SKReportView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:sk];
}

- (void)userimagellTouchClick:(NSIndexPath *)index
{
    SKviewPointModel *model = self.sources[index.row];
    SKUserCenterViewController *userVC = [[SKUserCenterViewController alloc] init];
    userVC.block = ^{
        model.active = model.active == 1?2:1;
    };
    userVC.title = @"个人中心";
    userVC.uid = [NSString stringWithFormat:@"%ld",(long)model.uid];
    userVC.nickName = model.author;
    userVC.imagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,model.imgurl];
    userVC.active = model.active;
    [self.navigationController pushViewController:userVC animated:YES];
}

- (void)attentionClick:(NSIndexPath *)index {
    SKviewPointModel *model = self.sources[index.row];
    SKUserCenterViewController *userVC = [[SKUserCenterViewController alloc] init];
//    userVC.block = ^{
//        model.active = model.active == 1?2:1;
//    };
    userVC.title = @"个人中心";
    userVC.uid = model.att_id;
    userVC.nickName = model.nickname;
    userVC.imagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,model.imgurl];
    userVC.active = 1;
    [self.navigationController pushViewController:userVC animated:YES];
}

- (void)zanOrreplyClickWithTag:(NSInteger)tag index:(NSInteger)index
{
    SKviewPointModel *model = self.sources[index];
    if (tag == 105) {
        WS(weakSelf);
        NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":[NSString stringWithFormat:@"%ld",(long)model.guandian_id]};
        [SVCCommunityApi giveZsumWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf.view toastShow:msg];
            if (code == 0) {
                model.z_sum = [[JSON objectForKey:@"nums"] integerValue];
                [weakSelf.mainTableView reloadData];
            }

        } andfail:^(NSError *error) {
            
        }];
    }else{
        [self gotoViewPointVC:model];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

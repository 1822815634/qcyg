//
//  SKQuestionViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/25.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKQuestionViewController.h"
#import "SKquestionAndAswerCell.h"
#import "SKUserCenterViewController.h"
#import "SKQuestionModel.h"
#import "SKQuestionDetailViewController.h"
@interface SKQuestionViewController ()<UITableViewDelegate , UITableViewDataSource ,SKquestionAndAswerCellDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;

@end

@implementation SKQuestionViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - kTabbarHeight - Knavheight - 164) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.estimatedRowHeight = 44;
        tab.rowHeight = UITableViewAutomaticDimension;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
         tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKquestionAndAswerCell" bundle:nil] forCellReuseIdentifier:@"SKquestionAndAswerCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSDictionary *paras = @{@"token":[SKUserInfoModel userToken],@"type":@"5",@"timeformat":@"Y-m-d H:m:s",@"limit":@"10000"};
    [SVCCommunityApi questionListWithNSDictionary:paras BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKQuestionModel *model = [SKQuestionModel initWithDictionary:dict];
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
    } path:@"lists"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SKQuestionDetailViewController *sk = [SKQuestionDetailViewController new];
    SKQuestionModel *model = self.sources[indexPath.row];
    sk.questionId = model.question_id;
    [self.navigationController pushViewController:sk animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKquestionAndAswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKquestionAndAswerCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.vDelegate = self;
    SKQuestionModel *model = self.sources[indexPath.row];
    cell.index = indexPath.row;
    cell.model = model;
    return cell;
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sources.count;
}
- (void)touchHeaderImagellClick:(NSInteger)tag
{
       SKQuestionModel *model = self.sources[tag];
       SKUserCenterViewController *userVC = [[SKUserCenterViewController alloc] init];
       userVC.title = @"个人中心";
       userVC.uid = [NSString stringWithFormat:@"%@",model.uid];
       userVC.nickName = model.hd_nickname;
       userVC.imagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,model.imgurl];
       userVC.active = 1;
       [self.navigationController pushViewController:userVC animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

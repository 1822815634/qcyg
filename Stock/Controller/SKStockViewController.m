//
//  SKStockViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKStockViewController.h"
#import "SKRaceResultView.h"
#import "SKRaceRuleViewController.h"
#import "SKLastAwardViewController.h"
#import "SKAnalogdiskViewController.h"
#import "BSWKwebViewController.h"
#import "SKMyAwardRuleCell.h"
#import "SKMyRanklistTopCell.h"
#import "SKMyawardInfoCell.h"
#import "SKOperaHeaderView.h"
#import "SKLastAwardModel.h"
#import "SKBullracewCell.h"
#import "SKrankModel.h"
#import "SKStockModel.h"
#import "SKRankingListTableViewCell.h"
#import "SKRankingInfoTableViewCell.h"
#import "SKTopDaSaiTableViewCell.h"
#import "SKTopListTableViewCell.h"
@interface SKStockViewController ()<UITableViewDelegate , UITableViewDataSource ,SKOperaHeaderViewTypeViewDelegate , SKBullracewCellViewDelegate , SKMyawardInfoCellDelegate,SKTopDaSaiTableViewCellViewDelegate>
{
    NSInteger _currentIndex;
    NSString *_earnings;//收益
    NSString *_rowno;//排名
    NSString *_realName;//名字
    NSString *_uimage;//头像
    __block NSInteger _page;
    __block NSInteger _maxPage;
    __block NSInteger _otherPage;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , weak)SKRaceResultView *resultView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *homeSources;
@property (nonatomic , weak)SKOperaHeaderView *headerView;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , strong)NSMutableArray *awardSources;
@property (nonatomic , strong)NSMutableArray *resultArr;
@end

@implementation SKStockViewController
- (NSMutableArray *)resultArr
{
    if (!_resultArr) {
        _resultArr = [NSMutableArray new];
    }
    return _resultArr;
}
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}

- (NSMutableArray *)homeSources
{
    if (!_homeSources) {
        _homeSources = [NSMutableArray new];
    }
    return _homeSources;
}

- (NSMutableArray *)awardSources
{
    if (!_awardSources) {
        _awardSources = [NSMutableArray new];
    }
    return _awardSources;
}
- (SKRaceResultView *)resultView
{
    if (!_resultView) {
        SKRaceResultView *view = [SKRaceResultView instanceSKRaceResultView];
        view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight); [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        _resultView = view;
    }
    return _resultView;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight - Knavheight - 44 - kTabbarHeight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        WS(weakSelf);
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (_currentIndex == 2) {
                _page = 1;
                [weakSelf request2:nil];
            } else {
                _otherPage = 1;
                [weakSelf configData];
            }
        }];
        tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (_currentIndex == 2) {
                _page++;
                [weakSelf request2:nil];
            }
            else {
//                _otherPage++;
//                [weakSelf configData];
                [self endRefresh];
            }
        }];
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerCell:@"SKBullracewCell" withTab:tab];
        [self registerCell:@"SKRankingInfoTableViewCell" withTab:tab];
        [self registerCell:@"SKRankingListTableViewCell" withTab:tab];
         [self registerCell:@"SKMyRanklistTopCell" withTab:tab];
         [self registerCell:@"SKMyawardInfoCell" withTab:tab];
         [self registerCell:@"SKMyAwardRuleCell" withTab:tab];
        [self registerCell:@"SKTopDaSaiTableViewCell" withTab:tab];
        [self registerCell:@"SKTopListTableViewCell" withTab:tab];
        [tab registerNib:[UINib nibWithNibName:@"SKPersonInfoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SKPersonInfoHeaderView"];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KBlueColor]
     
                                                 forBarPosition:UIBarPositionAny
     
                                                     barMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 21]};
    self.navigationItem.title = @"钱程优顾";
    _currentIndex = 1;
    _page = 1;
    _otherPage = 1;
    [self.headerView setupView:_currentIndex titleArr:@[@"比赛大厅",@"比赛排名",@"往期赛事",@"我的获奖"]];
    [self configData];
    [self initConstactButtton];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(loginSuccessful) name:@"loginSuccessful" object:nil];
}

- (void)loginSuccessful{
    _otherPage = 1;
    [self configData];
}

- (void)initConstactButtton
{
    UIButton *constactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [constactBtn setImage:showImage(@"在线客服") forState:0];
    [self.view addSubview:constactBtn];
    [constactBtn addTarget:self action:@selector(constractUS) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    [constactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(- 13);
        make.height.width.equalTo(@(60));
    }];
}
- (void)constractUS
{
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = [[NSUserDefaults standardUserDefaults]objectForKey:@"kefu"];
    [self.navigationController pushViewController:constactVC animated:YES];
}

- (void)configData{
    WS(weakSelf);
//    if ([SKUserInfoModel userToken].length < 6) {
//        [self.view toastShow:@"请到我的界面去登录"];
//        return;
//    }
    dispatch_group_t group = dispatch_group_create();
    [self request1:group];
//    [self request2:group];
    [self request5:group];
    [self request3:group];
    [self request4:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf endRefresh];
        [weakSelf.mainTableView reloadData];
    });
}

- (void)endRefresh {
    WS(weakSelf);
    if ([weakSelf.mainTableView.mj_footer isRefreshing]) {
        [weakSelf.mainTableView.mj_footer endRefreshing];
    }
    if ([weakSelf.mainTableView.mj_header isRefreshing]) {
        [weakSelf.mainTableView.mj_header endRefreshing];
    }
}

- (void)footReflash
{
      WS(weakSelf);
      if (_page >= _maxPage) {
          if ([weakSelf.mainTableView.mj_footer isRefreshing]) {
          [weakSelf.mainTableView.mj_footer endRefreshing];
          }
          return;
      }
      if ([SKUserInfoModel userToken].length < 6) {
      [self.view toastShow:@"请到我的界面去登录"];
      return;
      }
      dispatch_group_t group = dispatch_group_create();
      [self request1:group];
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
      if ([weakSelf.mainTableView.mj_footer isRefreshing]) {
      [weakSelf.mainTableView.mj_footer endRefreshing];
      }
      [weakSelf.mainTableView reloadData];
      });
}

- (void)logout{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [SKUserInfoModel deleteModel];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark --> 大厅请求数据
- (void)request1:(dispatch_group_t)group {
       WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi TournamentWithNSDictionary:@{@"token":[SKUserInfoModel userToken]?[SKUserInfoModel userToken]:@"",@"timeformat":@"Y-m-d H:m:s",@"current":@(_otherPage),@"limit":@(500)} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     dispatch_group_leave(group);
        if (code == 0) {
            if (_otherPage ==1) {
                [weakSelf.datas removeAllObjects];
            }
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *Dict in list) {
                SKStockModel * oldmodel = [SKStockModel initWithDictionary:Dict];
                [weakSelf.datas addObject:oldmodel];
            }
            }else if (code == 400){
            [weakSelf logout];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
        dispatch_group_leave(group);
    } path:@"home"];
}

#pragma mark --》首页排行榜请求数据
- (void)request5:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi TournamentWithNSDictionary:@{@"token":[SKUserInfoModel userToken]?[SKUserInfoModel userToken]:@"",@"timeformat":@"Y-m-d H:m:s",@"current":@(_otherPage),@"limit":@"6"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf endRefresh];
        if (code == 0) {
            [weakSelf.homeSources removeAllObjects];
            dispatch_group_leave(group);
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKrankModel *model = [SKrankModel initWithDictionary:dict];
                [weakSelf.homeSources addObject:model];
            }
            [weakSelf.mainTableView reloadData];
        }else if (code == 400){
            [weakSelf logout];
        }
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
        [weakSelf endRefresh];
    } path:@"ranking"];
}

#pragma mark --》排行榜请求数据
- (void)request2:(dispatch_group_t)group {
    WS(weakSelf);
//    dispatch_group_enter(group);
    [SVCCommunityApi TournamentWithNSDictionary:@{@"token":[SKUserInfoModel userToken]?[SKUserInfoModel userToken]:@"",@"timeformat":@"Y-m-d H:m:s",@"current":@(_page),@"limit":@"10"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf endRefresh];
        if (code == 0) {
            if (_page == 1) {
                [weakSelf.sources removeAllObjects];
            }
//            dispatch_group_leave(group);
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKrankModel *model = [SKrankModel initWithDictionary:dict];
                [weakSelf.sources addObject:model];
            }
            [weakSelf.mainTableView reloadData];
        }else if (code == 400){
        [weakSelf logout];
        }
    } andfail:^(NSError *error) {
         dispatch_group_leave(group);
        [weakSelf endRefresh];
    } path:@"ranking"];
}

#pragma mark --> 获取个人排名和盈利
- (void)request3:(dispatch_group_t)group {
    dispatch_group_enter(group);
    [SVCCommunityApi TournamentWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            _rowno = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"top"]];
            _earnings = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"earnings"]];
            _realName = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"realname"]];
            _uimage = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"u_img"]];
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
    } path:@"my_ranking"];
}

#pragma mark 我的获奖
- (void)request4:(dispatch_group_t)group {
    dispatch_group_enter(group);
    WS(weakSelf);
    [SVCCommunityApi lastAwardWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.awardSources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKLastAwardModel *model = [SKLastAwardModel initWithDictionary:dict];
                [weakSelf.awardSources addObject:model];
            }
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}
- (void)onClickedOKbtn {
    SKLastAwardViewController *lastAwardVC = [[SKLastAwardViewController alloc] init];
    lastAwardVC.title = @"上期获奖";
    [self.navigationController pushViewController:lastAwardVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 1) {
        if (indexPath.section == 0) {
            SKTopDaSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKTopDaSaiTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            [cell setupBullraceCellWithmodel:self.datas[indexPath.section]];
            if (_earnings) {
                CGFloat earns = [_earnings floatValue];
                earns = earns * 100;
                cell.currentMyRaceLabel.text = [NSString stringWithFormat:@"当前我的排名:%@ 月收益:%.1f%%",_rowno,earns];
            } else {
                cell.currentMyRaceLabel.text = [NSString stringWithFormat:@"当前我的排名:请登陆后查看 月收益:请登陆后查看"];
            }
            cell.vDelegate = self;
            return cell;
        }
            SKTopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKTopListTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            [cell setDataWithModel:self.homeSources[indexPath.section-1] Section:indexPath.section];
        return cell;
        return nil;
    }else if(_currentIndex == 2){
        if (indexPath.section == 1) {
            SKRankingInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRankingInfoTableViewCell" forIndexPath:indexPath];
            SKrankModel *model = self.sources[indexPath.row];
            [cell setupViewWithrankModel:model index:indexPath];
            cell.selectionStyle = 0;
            return cell;
        }else{
            SKRankingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRankingListTableViewCell" forIndexPath:indexPath];
            [cell setupViewWithrowNo:_rowno earnings:_earnings];
            cell.selectionStyle = 0;
            return cell;
        }
    }else{
        if (_currentIndex == 3) {
            SKBullracewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKBullracewCell" forIndexPath:indexPath];
            cell.vDelegate = self;
            SKStockModel *model = self.datas[indexPath.section];
            [cell setupBullraceCellWithmodel:model index:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            cell.selectionStyle = 0;
            return cell;
        } else {
            if (indexPath.section == 1) {
                SKMyawardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyawardInfoCell" forIndexPath:indexPath];
                SKLastAwardModel *model = self.awardSources[indexPath.row];
                cell.vDelegate = self;
                [cell setModel:model index:indexPath.row];
                cell.selectionStyle = 0;
                return cell;
            }else if(indexPath.section == 0){
                SKMyRanklistTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyRanklistTopCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                return cell;
            }else{
                SKMyAwardRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyAwardRuleCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                return cell;
            }
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_currentIndex == 1) {
        if (_earnings) {
            if (section == 6) {
                return [self createFooterView];
            }
        } else {
            if (section == 6) {
                return [self createFooterView];
            }
        }
    }
    return nil;
}

- (UIView *)createFooterView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    [moreBtn setTitle:@"查看更多排名" forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(morebtnclick) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [moreBtn setTitleColor:[UIColor hexStringToColor:@"333333"] forState:UIControlStateNormal];
    [view addSubview:moreBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 10)];
    lineView.backgroundColor = [UIColor whiteColor];
    [view addSubview:lineView];
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openBtn setFrame:CGRectMake(0, lineView.tx_bottom, kScreenWidth, 50)];
    [openBtn setBackgroundColor:KBlueColor];
    if (self.datas.count) {
        SKStockModel *model = self.datas[0];
        if (model.cuid !=0) {
            [openBtn setTitle:@"进入比赛" forState:0];
            openBtn.tag = 2;
        } else {
            [openBtn setTitle:@"立即报名比赛" forState:0];
            openBtn.tag = 1;
        }
    }
    [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    openBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:openBtn];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_currentIndex == 1) {
        if (self.datas.count && _earnings && self.homeSources.count) {
            return 1+self.homeSources.count;
        }
        if (self.datas.count && !_earnings && self.homeSources.count) {
            return 1+self.homeSources.count;
        }
        return 0;
    }else if(_currentIndex == 2){
        return 2;
    }else if(_currentIndex ==3){
        return self.datas.count;
    } else if (_currentIndex ==4) {
        return 3;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex == 1) {
        return 1;
    }else if(_currentIndex == 2){
        if (section == 0) {
          return self.sources.count > 0 ? 1:0;
        }else{
            return self.sources.count;
        }
    }else if(_currentIndex ==3){
        return 1;
    } else {
        if (section == 0 || section == 2) {
            return 1;
        }else{
            return self.awardSources.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 1) {
        if (indexPath.section == 0) {
            return UITableViewAutomaticDimension;
        }
        return 60;
    }else if(_currentIndex == 2){
        if (indexPath.section == 0) {
            return 40;
        }else{
            return 50;
        }
    }else if(_currentIndex ==3){
        SKStockModel *model = self.datas[indexPath.section];
        if (model.status == 0) {
            if (model.cuid != 0) {
                return 280;
            }
        }
        return 240;
    } else {
        if (indexPath.section == 1) {
            return 50;
        }else if(indexPath.section == 2){
            return 240;
        }else{
            return 40;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_currentIndex == 4) {
        if (section == 0) {
            return 10;
        }else{
            return 0.01f;
        }
    }else{
        
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_currentIndex == 1) {
        if (_earnings) {
            if (section == 6) {
                return 95;
            }
        } else {
            if (section == 6) {
                return 95;
            }
        }
    }
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)SKBullracewCellTypeViewClick:(NSInteger)tag index:(NSIndexPath *)index
{
    if (tag == 1) {
        [self applyRace:index];
    }else if(tag == 2){
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/tournament/rule?appType=1"];
    constactVC.title = @"钱程优顾";
        [self.navigationController pushViewController:constactVC animated:YES];
    }else{
        [self joinRace];
    }
}
#pragma mark -->  进入比赛
- (void)joinRace{
    SKAnalogdiskViewController *snlogdiskVC = [[SKAnalogdiskViewController alloc] init];
    snlogdiskVC.title = @"模拟操盘";
    [self.navigationController pushViewController:snlogdiskVC animated:YES];
}
#pragma mark --> 加入比赛
- (void)applyRace:(NSIndexPath *)index{
    SKStockModel *model = self.datas[index.section];
    if (model.status  == 0) {
      [self JoingameOroutRance:@"apply" model:model];
    }else if (model.status == 2){
        [self JoingameOroutRance:@"game_result" model:model];
    }else if(model.status ==1){
        
    }
}

#pragma mark --> 退出比赛
- (void)outRace:(NSIndexPath *)index{
    SKStockModel *model = self.datas[index.section];
    if (model.status  == 0) {
        [self JoingameOroutRance:@"quit" model:model];
    }else if (model.status == 2){
        [self JoingameOroutRance:@"game_result" model:model];
    }else if(model.status ==1){
        
    }
}


#pragma mark --> 加入、退出比赛
- (void)JoingameOroutRance:(NSString *)path model:(SKStockModel *)model
{
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken]?[SKUserInfoModel userToken]:@"",@"id":model.game_id};
    [SVCCommunityApi applyRaceWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            if ([path isEqualToString:@"game_result"]) {
                NSArray *list = [JSON objectForKey:@"data"];
                [weakSelf.resultArr removeAllObjects];
                for (NSDictionary *dict in list) {
                    SKrankModel *model = [SKrankModel initWithDictionary:dict];
                    [weakSelf.resultArr addObject:model];
                }
                weakSelf.resultView.sources = weakSelf.resultArr;
            }else{
                if ([path isEqualToString:@"apply"]) {
                    model.cuid = 1206;
                }else{
                    model.cuid = 0;
                }
                [weakSelf.mainTableView reloadData];
            }
        }else if (code == 400){
        [weakSelf logout];
        }
        [weakSelf.view toastShow:msg];
    } andfail:^(NSError *error) {
        
    } path:path];
}

- (void)SKOperaHeaderViewTypeViewClick:(NSInteger)tag
{
    if (tag == 1) {
        _currentIndex = tag;
        [self.mainTableView reloadData];
    } else {
        if ([SKUserInfoModel userToken].length < 5) {
            [self SKoutLogoutCellClick];
        }
        _currentIndex = tag;
        if (_currentIndex == 2) {
            [self request2:nil];
        }
        [self.mainTableView reloadData];
    }
}

- (void)SKBullracewCellTypeViewClick:(NSInteger)tag {
    switch (tag) {
        case 1: {
            //报名比赛
            [self applyRace:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
            break;
        case 2: {
            //进入比赛
            [self joinRace];
        }
            break;
        case 3: {
            //查看更多奖项
            BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
            constactVC.url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/tournament/rule?appType=1"];
            constactVC.title = @"钱程优顾";
            [self.navigationController pushViewController:constactVC animated:YES];
        }
            break;
        case 4: {
            //退出比赛
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"您确定要退出比赛?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不，我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                
            }];
            WS(weakSelf);
            UIAlertAction *camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self outRace:[NSIndexPath indexPathForRow:0 inSection:0]];
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:camera];
            [self presentViewController:alertVc animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

- (void)SKoutLogoutCellClick{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark --> 立即领取奖励
- (void)awardredemption:(NSInteger)tag{
      SKLastAwardModel *model = self.awardSources[tag];
      if ([model.status integerValue] == 0) {
      WS(weakSelf);
      NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":model.hj_id};
      [SVCCommunityApi TournamentWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
      [weakSelf.view toastShow:msg];
      if (code == 0) {
      model.status = @"1";
      [weakSelf.mainTableView reloadData];
      }else if (code == 400){
      [weakSelf logout];
      }
      } andfail:^(NSError *error) {

      } path:@"redemption"];
          
      }
}

- (void)morebtnclick {
    self.headerView.selectedIndex = 2;
}

- (void)openBtnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 1: {
            //报名比赛
            [self applyRace:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
            break;
        case 2: {
            //进入比赛
            [self joinRace];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

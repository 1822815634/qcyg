//
//  SKMainHomeViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKMainHomeViewController.h"
#import "SKProductViewController.h"
#import "SKLoginViewController.h"
#import "SKRegisterViewController.h"
#import "SVCTabBarController.h"
#import "BSWKwebViewController.h"
#import "SKStockCommunityViewController.h"
#import "SKAnnouncementmessageViewController.h"
#import "SKPromotemoneyViewController.h"
#import "SKResultRaceViewController.h"
#import "SKLimitRaceViewController.h"
#import "SKQuestionViewController.h"
#import "SKAnnouncementmessageModel.h"
#import "SKBannerHeaderView.h"
#import "SKStrategyHeaderView.h"
#import "SKMainFootView.h"
#import "SKMainTypeTableViewCell.h"
#import "SKStrategyCell.h"
#import "SKMegagameCell.h"
#import "SKConstractCell.h"
#import "SKMainShowView.h"
@interface SKMainHomeViewController ()<UITableViewDelegate , UITableViewDataSource , SKMainTypeTableViewCellDelegate , SKStrategyCellDelegate , SKMegagameCellDelegate , SKBannerHeaderViewDidselectedDelegate , SKMainShowViewRegisterAndloginDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , strong)NSMutableArray *bulletinSources;
@property (nonatomic , strong)NSMutableArray *ConstractList;
@property (nonatomic , weak)SKMainShowView *showView;
@end

@implementation SKMainHomeViewController
#pragma mark --> 初始化、懒加载
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (NSMutableArray *)bulletinSources
{
    if (!_bulletinSources) {
        _bulletinSources = [NSMutableArray new];
    }
    return _bulletinSources;
}
- (NSMutableArray *)ConstractList
{
    if (!_ConstractList) {
        _ConstractList = [NSMutableArray new];
    }
    return _ConstractList;
}
- (SKMainShowView *)showView
{
    if (!_showView) {
        SKMainShowView *View = [SKMainShowView instanceSKMainShowView];
        View.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
        View.vDelegate = self;
        [[[UIApplication sharedApplication] keyWindow] addSubview:View];
        _showView = View;
    }
    return _showView;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, -kstatueHeight, kScreenWidth, kScreenHeight - kTabbarHeight + kstatueHeight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerCell:@"SKStrategyCell" withTab:tab];
        [self registerCell:@"SKMainTypeTableViewCell" withTab:tab];
        [self registerCell:@"SKMegagameCell" withTab:tab];
        [self registerCell:@"SKConstractCell" withTab:tab];
         [tab registerClass:[SKBannerHeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
        [tab registerNib:[UINib nibWithNibName:@"SKStrategyHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SKStrategyHeaderView"];
        [tab registerClass:[SKMainFootView class] forHeaderFooterViewReuseIdentifier:@"SKMainFootView"];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainTableView.mj_header beginRefreshing];
    [self initConstactButtton];
    // Do any additional setup after loading the view.
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
#pragma mark --> 点击在线客服
- (void)constractUS{
    [self initWebWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:@"kefu"] title:@"在线客服"];
}
#pragma mark -->  跳转H5
- (void)initWebWithPath:(NSString *)path title:(NSString *)title
{
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = path;
    constactVC.title = title;
    [self.navigationController pushViewController:constactVC animated:YES];
}
#pragma mark --> 请求数据
- (void)configData
{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    [self request1:group];
    [self request2:group];
    [self request3:group];
    [self request4:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([weakSelf.mainTableView.mj_header isRefreshing]) {
            [weakSelf.mainTableView.mj_header endRefreshing];
        }
        [weakSelf.mainTableView reloadData];
    });
    if ([SKUserInfoModel userToken].length < 6) {
       [self showView];
    }
}
#pragma mark --> 首页banner图数据
- (void)request1:(dispatch_group_t)group {
WS(weakSelf);
     dispatch_group_enter(group);
    [SVCCommunityApi GetcarouselWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.datas removeAllObjects];
            NSArray *listArr = [JSON objectForKey:@"data"];
            for (NSDictionary *listDict in listArr) {
                [weakSelf.datas addObject:listDict];
            }
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
         dispatch_group_leave(group);
    }];
}
#pragma mark --> 牛人大赛请求数据
- (void)request2:(dispatch_group_t)group {
     WS(weakSelf);
      dispatch_group_enter(group);
    [SVCCommunityApi GethotNewsWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            [weakSelf.sources addObject:JSON];
            NSString *str =[self.sources[0] objectForKey:@"kf_url"];
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"kefu"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
         dispatch_group_leave(group);
    }];
}
#pragma mark --> 公告信息请求
- (void)request3:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi AnnouncementinformationWithNSDictionary:@{@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.bulletinSources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                NSString *title = [dict objectForKey:@"title"];
                [weakSelf.bulletinSources addObject:title];
            }
        }
          dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
          dispatch_group_leave(group);
    } path:@"bulletin"];
}
#pragma mark --> 设置相关
- (void)request4:(dispatch_group_t)group {
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi abouthelpNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.ConstractList removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                [weakSelf.ConstractList addObject:dict];
            }
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
         dispatch_group_leave(group);
    }];
}
#pragma mark --> tableView的代理以及数据源的代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SKMainTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMainTypeTableViewCell" forIndexPath:indexPath];
        cell.vDelegate = self;
        cell.selectionStyle = 0;
        return cell;
    }else if (indexPath.section == 1){
        SKStrategyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKStrategyCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        if (indexPath.row == 0) {
            [cell initTypeLab:@"利息更低 | 最高可配2000万元" index:indexPath.row];
        }else{
            [cell initTypeLab:@"操作灵活 | 最高可配2000万元" index:indexPath.row];
        }
        cell.vDelegate = self;
        return cell;
    }else if (indexPath.section == 2)
    {
        SKMegagameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMegagameCell" forIndexPath:indexPath];
        cell.vDelegate = self;
        if (self.sources.count > 0) {
            [cell setUpViewWithDic:self.sources[0]];
        }
        cell.selectionStyle = 0;
        return cell;
    }else{
    SKConstractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKConstractCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    return cell;
    }
}
#pragma mark --> tablview代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SKBannerHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
        headerView.vDelegate = self;
        if (self.bulletinSources.count > 0) {
             [headerView setupViewWithimageList:[self imagellArr] txString:[self.bulletinSources componentsJoinedByString:@"  "]];
        }
        return headerView;
    }else if (section == 3){
        return nil;
    }else{
        SKStrategyHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKStrategyHeaderView"];
        if (section == 1) {
            [header setupTile:@"牛人策略" detailInfo:@"-按天按月随心配"];
        }else{
             [header setupTile:@"牛人大赛" detailInfo:@"-拿千元大奖"];
        }
        return header;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        SKMainFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKMainFootView"];
        [footView setupFootView];
        return footView;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}
#pragma mark -->拼接获取首页banner图
- (NSArray *)imagellArr{
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    if (self.datas.count > 0) {
        for (NSDictionary *dict in self.datas) {
            [imageArr addObject:[NSString stringWithFormat:@"%@%@",ServerPath,[dict objectForKey:@"imgUrl"]]];
        }
    }
    return imageArr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2)
    {
        return 170;
    }
    else{
        return 84;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kScreenWidth * 220 / 375;
    }else if (section == 3){
        return 0.01f;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 60;
    }else{
    return 10.0f;
    }
}
#pragma mark --> type样式cell点击的代理
- (void)SKMainTypeTableViewCellTypeClickDelegate:(NSInteger)tag
{
    switch (tag) {
        case 1:
            [self question];
            break;
        case 2:
            [self hlperCenter];
            break;
        case 3:
            [self skBullraceViewController];
            break;
        case 4:
            [self Community];
            break;
        case 5:
            [self limitRace];
            break;
        case 6:
            [self ResultOfrace];
            break;
            case 7:
            [self prmotemoney];
            break;
        case 8:
        [self constractAbout];
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (indexPath.section == 3) {
       NSString *url = [self.ConstractList[4] objectForKey:@"url"];
       [self initWebWithPath:url title:@"帮助中心"];
       }
}
- (void)constractAbout{
    if (self.ConstractList.count > 0) {
    [self initWebWithPath:[self.ConstractList[3] objectForKey:@"url"] title:@"联系我们"];
    }
}
#pragma mark --> 帮助中心
- (void)hlperCenter
{
    [self tabbarItemselected:1 index:2];
}
#pragma mark --> 在线问答
- (void)question{
    [self tabbarItemselected:1 index:1];
}
#pragma mark --> 进入牛人大赛
- (void)skBullraceViewController
{
    [self tabbarItemselected:2 index:1];
}
#pragma mark --> 跳转tabbar
- (void)tabbarItemselected:(NSInteger)tag index:(NSInteger)index
{
    SVCTabBarController *tabbar = [[SVCTabBarController alloc] init];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    keyWindow.rootViewController = tabbar;
    tabbar.selectedIndex = tag;
    if (index == 2) {
        SKProductViewController *VC = tabbar.selectedViewController.childViewControllers[0];
        VC.indexTag = index;
    }
}
#pragma mark --> 首页弹框
- (void)registerAndLogin:(NSInteger)tag
{
   if (tag ==1006) {
   [self limitRace];
   }else{
   SKRegisterViewController *registerVC = [[SKRegisterViewController alloc] init];
   registerVC.title = @"注册";
   SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:registerVC];
   registerVC.type = 2;
   [self presentViewController:nav animated:YES completion:nil];
   }
}
#pragma mark --> 新手注册
- (void)limitRace
{
     if ([SKUserInfoModel userToken].length < 6) {
        SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
        logVC.title = @"登录";
        SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
        [SKUserInfoModel deleteModel];
        [self presentViewController:nav animated:YES completion:nil];
     }else{
        [self tabbarItemselected:4 index:1];
     }
}
#pragma mark --> 安全保障
- (void)ResultOfrace
{
    if (self.ConstractList.count > 0) {
        NSDictionary *dict = self.ConstractList[2];
        [self initWebWithPath:[dict objectForKey:@"url"] title:@"安全保障"];
    }
}
#pragma mark --> 股票社区
- (void)Community
{
    if ([SKUserInfoModel userToken].length < 5) {
        [self SKoutLogoutCellClick];
    } else {
        [self.tabBarController setSelectedIndex:3];
    }
//    [self tabbarItemselected:3 index:1];
}
#pragma mark --> 推广赚钱
- (void)prmotemoney
{
    SKPromotemoneyViewController *promotemoneyVC = [[SKPromotemoneyViewController alloc] init];
    promotemoneyVC.title = @"推广赚钱";
    [self.navigationController pushViewController:promotemoneyVC animated:YES];
}
#pragma mark --> 公告消息
- (void)SKAnnouncementmessage
{
    SKAnnouncementmessageViewController *messageVC = [[SKAnnouncementmessageViewController alloc] init];
    messageVC.title = @"公告消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}
#pragma mark -->牛人策略加入点击的代理
- (void)SKStrategyCellJoinClickDelegateindex:(NSInteger)tag
{
    [self tabbarItemselected:1 index:tag + 1];
}
#pragma mark -->牛人大赛加入点击的代理
- (void)SKMegagameCellJoinClickDelegate
{
    [self tabbarItemselected:2 index:1];
}

#pragma mark --> banner点击
- (void)SKBannerHeaderViewDidselectedAtindex:(NSInteger)tag
{
    if (tag == 1206) {
        [self SKAnnouncementmessage];
    }else{
        if (self.datas.count > 0) {
//            NSString *url = [self.datas[tag] objectForKey:@"url"];
//            [self initWebWithPath:url title:@"钱程无忧"];
            switch (tag) {
                case 0: {
                    if ([SKUserInfoModel userToken].length < 5) {
                        [self SKoutLogoutCellClick];
                    } else {
                        [self.tabBarController setSelectedIndex:4];
                    }
                }
                    break;
                case 1: {
                    [self.tabBarController setSelectedIndex:2];
                }
                    break;
                case 2: {
                    [self.tabBarController setSelectedIndex:1];
                }
                    break;
                default: {
                    NSString *url = [self.datas[tag] objectForKey:@"url"];
                    [self initWebWithPath:url title:@"钱程无忧"];
                }
                    break;
            }
        }
    }
}

- (void)SKoutLogoutCellClick
{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
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

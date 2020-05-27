//
//  SKProductViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKProductViewController.h"
#import "SKRaceRuleViewController.h"
#import "BSWKwebViewController.h"
#import "BSWKwebViewController.h"
#import "SKBullraceheaderView.h"
#import "SKBullracewCell.h"
#import "SKRankingListTableViewCell.h"
#import "SKRankingInfoTableViewCell.h"
#import "SKJunirowmangerFeeCell.h"
#import "SKJuniorcowCell.h"
#import "SKselectedMonthView.h"
#import "SKJuniorcowCountTypeCell.h"
#import "SKJuniorAgreeProtocolCell.h"
#import "SKSelectedCouponView.h"
#import "SKAgreetRiskstatementView.h"
#import "RaiseFree.h"
@interface SKProductViewController ()<UITableViewDelegate , UITableViewDataSource ,SKBullraceheaderViewDelegate , SKBullracewCellViewDelegate , SKJuniorcowCellClickViewDelegate , SKselectedMonthViewDelegate , SKJuniorAgreeProtocolCellDelegate , SKSelectedCouponViewDelegate , SKAgreetRiskstatementViewDelegate >
{
    NSInteger _currentIndex;//初级牛人 1 天天策略 2切换
    NSInteger _changeType;//自动按钮 1、手动输入 2切换
    NSInteger _buttonType;//倍数按钮切换
    NSInteger _scale;
    CGFloat _yushu;
    NSString *_balance;//余额
    NSString *_acoutAoumt;//手动输入金额
    NSInteger _currentMonth;//当前选择月份
    NSInteger _McouponIndex;//初级牛人选择优惠下标
    NSInteger _DcouponIndex;//天天策略选择优惠下标
    CGFloat _mangerFee;//天天策略管理费
    double _fee;//初级牛人管理费
    long _Myouhu;//月份优惠
    NSInteger _Dyouhu;//日优惠
    BOOL _Mbool;//初级牛人同意协议标识符
    BOOL _Dbool;//天天策略同意协议标识符
    BOOL _isAgreet;//风险协议同意标识符
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *MonthCouponList;//初级牛人优惠数据源
@property (nonatomic , strong)NSMutableArray *DayCouponList;//天天策略优惠数据源
@property (nonatomic , weak)SKBullraceheaderView *headerView;
@property (nonatomic , weak)SKselectedMonthView *selectedView;
@property (nonatomic , weak)SKSelectedCouponView *resultView;
@property (nonatomic , weak)SKAgreetRiskstatementView *riskView;
@end

@implementation SKProductViewController

- (SKSelectedCouponView *)resultView
{
    if (!_resultView) {
        SKSelectedCouponView *view = [SKSelectedCouponView instanceSKSelectedCouponView];
        view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight); [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        view.vDelegate = self;
        _resultView = view;
    }
    return _resultView;
}
#pragma mark --> 风险提示图
- (SKAgreetRiskstatementView *)riskView
{
    if (!_riskView) {
    SKAgreetRiskstatementView *view = [SKAgreetRiskstatementView instanceSKAgreetRiskstatementView];
    view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight); [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    view.vDelegate = self;
    _riskView = view;
}
   return _riskView;
}
- (NSMutableArray *)MonthCouponList
{
    if (!_MonthCouponList) {
        _MonthCouponList = [NSMutableArray new];
    }
    return _MonthCouponList;
}
- (NSMutableArray *)DayCouponList
{
    if (!_DayCouponList) {
        _DayCouponList = [NSMutableArray new];
    }
    return _DayCouponList;
}
#pragma mark --> 月份选择器
- (SKselectedMonthView *)selectedView
{
    if (!_selectedView) {
        SKselectedMonthView *View = [SKselectedMonthView instanceSKselectedMonthView];
        View.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
        View.vDelegate = self;
        [[[UIApplication sharedApplication] keyWindow] addSubview:View];
        _selectedView = View;
    }
    return _selectedView;
}
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight - Knavheight - 44 - kTabbarHeight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        [self registerCell:@"SKBullracewCell" withTab:tab];
//        [self registerCell:@"SKRankingInfoTableViewCell" withTab:tab];
//        [self registerCell:@"SKRankingListTableViewCell" withTab:tab];
//        [tab registerNib:[UINib nibWithNibName:@"SKPersonInfoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SKPersonInfoHeaderView"];
        [self registerCell:@"SKJunirowmangerFeeCell" withTab:tab];
        [self registerCell:@"SKJuniorcowCell" withTab:tab];
        [self registerCell:@"SKJuniorcowCountTypeCell" withTab:tab];
         [self registerCell:@"SKJuniorAgreeProtocolCell" withTab:tab];
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
#pragma mark --> 头部初级牛人、天天策略视图
- (SKBullraceheaderView *)headerView
{
    if (!_headerView) {
        SKBullraceheaderView *view = [[SKBullraceheaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 44);
        view.vDelegate = self;
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _Mbool = YES;
    _Dbool = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KBlueColor]
        forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]]; self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 21]};
    self.navigationItem.title = @"钱程优顾";
     _currentIndex = 1;
    if (self.indexTag == 2) {
        _currentIndex = 2;
    }
    _changeType = 1;
    _scale = 1;
    _yushu = 0;
    _buttonType = 1;
    _currentMonth = 1;
    _DcouponIndex = 0;
    _McouponIndex = 0;
    [self.headerView setupView:_currentIndex titleArr:@[@"初级牛人",@"天天策略"]];
    [self configData];
    [self initConstactButtton];
      [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(loginSuccessful) name:@"loginSuccessful" object:nil];
}
- (void)loginSuccessful
{
    [self configData];
}
- (void)configData{
    WS(weakSelf);
    if ([SKUserInfoModel userToken].length < 6) {
        [weakSelf.view toastShow:@"请先到我的界面去登录"];
        [weakSelf.mainTableView reloadData];
        return;
    }
    dispatch_group_t group = dispatch_group_create();
   [self getBalanceWithgroup:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.mainTableView reloadData];
    });
   if (_isAgreet) {
   }else{
   [self riskView];
   }
}
#pragma mark -->  获取余额
- (void)getBalanceWithgroup:(dispatch_group_t)group{
   NSDictionary *params = @{@"token":[SKUserInfoModel userToken]};
   dispatch_group_enter(group);
   WS(weakSelf);
   [SVCCommunityApi getBalanceWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
    dispatch_group_leave(group);
   if (code == 0) {
   _balance = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"balance"]];
   }else if (code == 400){
   [weakSelf logout];
   }else{
   
   }
   } andfail:^(NSError *error) {
    dispatch_group_leave(group);
   }];
}
#pragma mark -->  重新登录
- (void)logout{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [SKUserInfoModel deleteModel];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark --> 同意风险提示协议
- (void)aggretRisk
{
    _isAgreet = !_isAgreet;
}
- (void)getCouponListWithType:(NSInteger)type
{
     WS(weakSelf);
     if ([SKUserInfoModel userToken].length < 6) {
     [weakSelf.view toastShow:@"请先到我的界面去登录"];
     [weakSelf.mainTableView reloadData];
     return;
     }else{
     
     }

    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"type":@(type>1?0:1),@"lever":@(_currentIndex >1?_scale+2:_scale),@"money":[NSString stringWithFormat:@"%.lf", [self calumNum:_buttonType] * 10000]};
    [SVCCommunityApi futuresCouponWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
    
        if (code == 0) {
         NSArray *list = [[JSON objectForKey:@"data"] objectForKey:@"list"];
        [weakSelf.DayCouponList removeAllObjects];
        [weakSelf.MonthCouponList removeAllObjects];
            for (NSDictionary *dict in list) {
                if (type == 2) {
                    [weakSelf.DayCouponList addObject:dict];
                }else{
                    [weakSelf.MonthCouponList addObject:dict];
                }
            }
        if (_currentIndex == 1) {
        [weakSelf showResultView:weakSelf.MonthCouponList index:_McouponIndex];
        }else{
         [weakSelf showResultView:weakSelf.DayCouponList index:_DcouponIndex];
        }
        }else if (code == 400){
        [weakSelf logout];
        [weakSelf.view toastShow:msg];
        }else{
         [weakSelf.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
    }];
}
#pragma mark --> 展示优惠券
- (void)showResultView:(NSMutableArray *)arr index:(NSInteger)tag
{
   if (arr.count > 0) {
    [self.resultView setSources:arr index:tag];
   }else{
   [self.view toastShow:@"当前没有可用优惠券"];
   }
}
#pragma mark -->  在线客服
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
#pragma mark --> tableview的代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            SKJuniorcowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJuniorcowCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.vDelegate = self;
            [cell changeType:_changeType buttonType:_buttonType scale:_scale yushu:_yushu currentIndx:_currentIndex balance:_balance];
            return cell;
        }else{
            if (indexPath.section == 2 && indexPath.row == 1) {
                SKJunirowmangerFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJunirowmangerFeeCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                if (_currentIndex == 1) {
                    _fee = [RaiseFree mymoney:[[[self caopanMonney:_buttonType scale:_scale zoom:100 type:1] substringToIndex:[self caopanMonney:_buttonType scale:_scale zoom:100 type:1].length - 1] integerValue] mycycle:_currentMonth mylever:_scale fixRate:0.0];
                    double rate = [RaiseFree  myRate:[[[self caopanMonney:_buttonType scale:_scale zoom:100 type:1] substringToIndex:[self caopanMonney:_buttonType scale:_scale zoom:100 type:1].length - 1] integerValue] mycycle:_currentMonth mylever:_scale fixRate:0.0];
                    NSString *title = [NSString stringWithFormat:@"单月利息%.2f元,总利息%.2f元",_fee/_currentMonth,_fee];
                    [cell setJunirowMangerFeeCellwithfree:[NSString stringWithFormat:@"%.1f分/每月",rate] msg:title];
                }else{
                    [cell setJunirowMangerFeeCellwithfree:[NSString stringWithFormat:@"%.2f元/每天",_mangerFee] msg:@"按天收取，周末节假日免费"];
                }
                return cell;
            }else if (indexPath.section == 4 && indexPath.row == 1){
                SKJuniorAgreeProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJuniorAgreeProtocolCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                cell.vDelegate = self;
                if (_currentIndex == 1) {
                     [cell changeCommitBtntitle:_currentIndex ret:_Mbool];
                }else{
                     [cell changeCommitBtntitle:_currentIndex ret:_Dbool];
                }
                return cell;
            }else{
             SKJuniorcowCountTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJuniorcowCountTypeCell" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 0:
                        [self settitle:@"总操盘金额" content:[self allCounMoney:_buttonType scale:_scale] type:2 cell:cell];
                        break;
                    case 1:
                        [self settitle:@"亏损警戒线" content:[self caopanMonney:_buttonType scale:_scale zoom:115 type:1] type:2 cell:cell];
                        break;
                    case 2:
                        [self settitle:@"亏损平仓线" content:[self caopanMonney:_buttonType scale:_scale zoom:110 type:1] type:1 cell:cell];
                        break;
                    default:
                        break;
                }
            }else if (indexPath.section == 2){
                if (_currentIndex == 1) {
                    if (indexPath.row == 2) {
                            [self setCouponContent:self.MonthCouponList index:_McouponIndex cell:cell];
                    }else{
                    [self settitle:@"资金使用期限" content:[NSString stringWithFormat:@"%ld个月",(long)_currentMonth] type:3 cell:cell];
                    }
                }else{
                if (indexPath.row == 2) {
                 [self setCouponContent:self.DayCouponList index:_DcouponIndex cell:cell];
                }else{
                   [self settitle:@"资金使用期限" content:@"2-30天" type:1 cell:cell];
                }
                }
            }else if(indexPath.section == 4){
                NSString * string = [self caopanMonney:_buttonType scale:1 zoom:100 type:2];
                NSInteger sum =  [[string substringToIndex:(string.length - 1)] integerValue];
                if (_currentIndex == 1) {
                    [self settitle:@"共计应支付" content: [NSString stringWithFormat:@"%.2f元",sum + _fee + (- _Myouhu)] type:1 cell:cell];
                    
                }else{
                    [self settitle:@"共计应支付" content: [NSString stringWithFormat:@"%.2f元",sum + _mangerFee + (- _Dyouhu)] type:1 cell:cell];
                }
               
            }else{
                switch (indexPath.row) {
                    case 0:
                        [self settitle:@"开始交易时间" content:@"今天" type:2 cell:cell];
                        break;
                    case 1:
                        [self settitle:@"支付风险保障金" content:[NSString stringWithFormat:@"%.2f元", [self calumNum:_buttonType] * 10000] type:2 cell:cell];
                        break;
                    default:
                        break;
                }
            }
          
            cell.selectionStyle = 0;
            return cell;
            }
        }
}
#pragma mark --> 设置优惠券
- (void)setCouponContent:(NSMutableArray *)couList index:(NSInteger)dex cell:(SKJuniorcowCountTypeCell *)cell
{
    NSString *content;
    if (_currentIndex == 1) {
        if (_McouponIndex == couList.count) {
            content = @" 优惠券";
        _Myouhu = 0;
        }else{
            NSDictionary *dict = couList[dex];
        _Myouhu = [[dict objectForKey:@"money"] integerValue];
            content = [NSString stringWithFormat:@"使用%@元优惠券",[dict objectForKey:@"money"]];
        }
    }else{
        if (_DcouponIndex == couList.count) {
            content = @" 优惠券";
        _Dyouhu = 0;
        }else{
            NSDictionary *dict = couList[dex];
         _Dyouhu = [[dict objectForKey:@"money"] integerValue];
            content = [NSString stringWithFormat:@"使用%@元优惠券",[dict objectForKey:@"money"]];
        }
    }
    [self settitle:@"优惠券" content:content type:3 cell:cell];
}
#pragma mark -->  cell 设置文字
- (void)settitle:(NSString *)title content:(NSString *)content type:(NSInteger)type cell:(SKJuniorcowCountTypeCell *)cell
{
    [cell setupViewWithTX:title content:content type:type];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 0 ) {
            return 1;
        }else if ( section == 4 || section == 3){
            return 2;
        }else if(section == 2){
        return 3;
        }else{
        return 3;
        }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            if (_changeType == 1) {
                 return 385 - 45;
            }else{
                return 385 - 113;
            }
        }else{
            if(indexPath.section == 2 && indexPath.row == 1){
                return 80;
            }else if(indexPath.section == 4 && indexPath.row == 1){
                return 120;
            }else{
        return 46;
            }
        }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2 && indexPath.row == 0 && _currentIndex == 1) {
        [self.selectedView show:_currentMonth];
    }
    if (indexPath.section == 2 && indexPath.row == 2 ) {
    [self getCouponListWithType:_currentIndex];
    }
}
#pragma mark --> 比赛规则
- (void)SKBullracewCellTypeViewClick:(NSInteger)tag index:(NSIndexPath *)index
{
    if (tag == 1) {
        NSLog(@"加入比赛");
    }else{
        SKRaceRuleViewController *resuVC = [[SKRaceRuleViewController alloc] init];
        resuVC.title = @"比赛规则";
        [self.navigationController pushViewController:resuVC animated:YES];
    }
}
#pragma mark --> 计算操盘金额
- (NSString *)caopanMonney:(NSInteger)buttonTag scale:(NSInteger)scale zoom:(NSInteger)zoom type:(NSInteger)type
{
     if (_currentIndex == 2 && type == 1) {
       scale +=2;
     }
    CGFloat sum = scale * [self calumNum:buttonTag] * zoom * 100;
    return [NSString stringWithFormat:@"%.2f元",sum];
}
#pragma mark --> 计算总资金
- (NSString *)allCounMoney:(NSInteger)buttonTag scale:(NSInteger)scale
{
    CGFloat num = [self calumNum:buttonTag];
    if (_currentIndex == 2 ) {
        scale += 2.0;
        if(scale > 4){
            _mangerFee = [[NSString stringWithFormat:@"%.2f",10000 * num * (scale) * 0.0018] floatValue];
        }else{
            _mangerFee = [[NSString stringWithFormat:@"%.2f",10000 * num * ( scale) * 0.0015] floatValue];
        }
    }
   
    return [NSString stringWithFormat:@"%.2lf元",10000 * num * (1 + scale)];
}
#pragma mark --> 计算管理费用
- (CGFloat)mangerfee
{
    CGFloat fee = 0;
    CGFloat money = [self calumNum:_buttonType] * 10000;
    CGFloat interst = 210;
    BOOL discount = NO;
    if(money > 1000000){
        if (_buttonType >= 3) {
            interst = 180;
        }else if(_buttonType >= 1){
            interst = 190;
        }
    }else if(money >= 100000){
        if (_buttonType >= 3) {
            interst = 190;
        }else if(_buttonType >=1){
            interst = 210;
        }
    }
    if (_buttonType <= 2) {
        discount = YES;
        interst = interst - (5 - _buttonType) * 10;
    }
    return fee;
}
#pragma mark --> 计算非手动输入当前选定按钮内容
- (CGFloat)calumNum:(NSInteger)buttonTag
{
    CGFloat num = 0;
    if (_currentIndex == 1) {
        switch (buttonTag) {
            case 1:
                num = 1;
                break;
            case 2:
                num = 5;
                break;
            case 3:
                num = 10;
                break;
            case 4:
                num = 20;
                break;
            case 5:
                num = 50;
                break;
            case 6:
                num = 100;
                break;
            case 7:
                num = 200;
                break;
            default:
                break;
        }
    }else{
        switch (buttonTag) {
            case 1:
                num = 0.2;
                break;
            case 2:
                num = 0.5;
                break;
            case 3:
                num = 1;
                break;
            case 4:
                num = 2;
                break;
            case 5:
                num = 5;
                break;
            case 6:
                num = 10;
                break;
            case 7:
                num = 20;
                break;
            default:
                break;
        }
    }
    
    if (_yushu > 0) {
        num = _yushu;
    }
    return num;
}
- (void)SKBullraceheaderViewTypeViewClick:(NSInteger)tag
{
    _currentIndex = tag;
    [self.mainTableView reloadData];
}
#pragma mark --> 点击切换
- (void)SKJuniorcowCellchangTypeClick:(NSInteger)type
{
    if (type > 3) {
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/home/stocklist?appType=1"];
    constactVC.title = @"限制个股";
    [self.navigationController pushViewController:constactVC animated:YES];
    }else{
        if (_changeType == 1) {
            _changeType = 2;
        }else{
            _yushu = 0;
            _changeType = 1;
        }
        [self.mainTableView reloadData];
    }
}
#pragma mark --> 文本框输入
- (void)countTFValuechangTypeClick:(NSString *)text type:(NSString *)type
{
    _acoutAoumt = text;
    if ([type isEqualToString:@"1"]) {
    [self checkValue:text];
    }
}
- (void)checkValue:(NSString *)text
{
    if ([text integerValue] % 1000 == 0||[text integerValue] % 100 == 0) {
        if (_currentIndex == 1) {
            if ([text integerValue] < 10000 || [text integerValue] > 5000000) {
                [self.view toastShow:@"输入金额最小为10000，最大为5000000"];
            }else{
                _yushu = [text floatValue] / 10000.0;
                [self.mainTableView reloadData];
            }
        }else{
            if ([text integerValue] < 2000 || [text integerValue] > 2000000) {
                [self.view toastShow:@"输入金额最小为2000，最大为2000000"];
            }else{
                _yushu = [text floatValue] / 10000.0;
                [self.mainTableView reloadData];
            }
        }
    }else{
        if (_currentIndex == 1) {
            [self.view toastShow:@"请输入1000的整数倍"];
        } else {
            [self.view toastShow:@"请输入100的整数倍"];
        }
    }
}

#pragma mark --> 月份更改
- (void)changeMonth:(NSInteger)month
{
    _currentMonth = month;
    [self.mainTableView reloadData];
}
#pragma mark --> 倍数按钮点击
- (void)typeButtonchangTypeClick:(NSInteger)type senderTag:(NSInteger)senderTag
{
    [self.view endEditing:YES];
    if (_changeType == 2) {
      [self checkValue:_acoutAoumt];
    }
    if (senderTag > 200) {
        _scale = senderTag - 200;
    }else{
        _buttonType = senderTag - 100;
    }
    [self.mainTableView reloadData];
}

#pragma mark --> 点击同意协议、阅读协议、提交牛人大赛或者天天策略
- (void)selectedbButtonType:(NSInteger)type
{
    if (_currentIndex == 1) {
        if (type == 1) {
            _Mbool = !_Mbool;
            [self.mainTableView reloadData];
        }else if (type == 2){
            [self bsWebVC:@"home/home/protocol?appType=1"];
        }else if(type == 4) {
            [self bsWebVC:@"home/home/riskbook?appType=1"];
        }else{
            if(_Mbool){
            [self commitFutureMonthAndDay:@"month_add"];
            }else{
                [self.view toastShow:@"请先同意初级牛人合作协议"];
            }
        }
    }else{
        if (type == 1) {
            _Dbool = !_Dbool;
             [self.mainTableView reloadData];
        }else if (type == 2){
             [self bsWebVC:@"home/home/protocol2?appType=1"];
        }else if(type ==4) {
            [self bsWebVC:@"home/home/riskbook?appType=1"];
        }else{
            if(_Dbool){
                [self commitFutureMonthAndDay:@"day_add"];
            }else{
                [self.view toastShow:@"请先同意天天策略合作协议"];
            }
        }
    }
}
#pragma mark --> 提交天天策略、初级牛人
- (void)commitFutureMonthAndDay:(NSString *)path
{
    if ([SKUserInfoModel userToken].length < 6) {
        [self.view toastShow:@"请先到我的界面去登录"];
        return;
    }
   if ([_acoutAoumt integerValue] % 1000 != 0&& _currentIndex == 1) {
        [self.view toastShow:@"请输入1000的整数倍"];
       return;
       }
    if ([_acoutAoumt integerValue] % 100 != 0 && _currentIndex == 2){
        [self.view toastShow:@"请输入100的整数倍"];
        return;
    }
    NSString *baseString = [self caopanMonney:_buttonType scale:_scale zoom:100 type:1];
    NSInteger benjin = [[baseString substringToIndex:(baseString.length - 1)] integerValue];
    NSDictionary *params;
    if ([path isEqualToString:@"day_add"]) {
        NSString *cid = @"";
        if (self.DayCouponList.count > 0 && _DcouponIndex < self.DayCouponList.count) {
            NSDictionary *dict = self.DayCouponList[_DcouponIndex];
            cid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cid"]];
        }
   NSInteger Dben = benjin/ (_scale + 2);
        params = @{@"token":[SKUserInfoModel userToken],@"withMoney":@(Dben * (_scale + 2)),@"money1":@(Dben),@"money2":@(Dben * (_scale + 3)),@"money3":@(benjin/100  * 115),@"money4":@(benjin / 100 * 110),@"money5":@(_mangerFee),@"lever":@(_scale + 2),@"tradeDate":@"0",@"cycle":@(_currentMonth),@"cid":cid,@"Tday":@"5"};
    }else{
        NSString *cid = @"";
     NSInteger Dben = benjin/ (_scale);
        if (self.MonthCouponList.count > 0 && _McouponIndex < self.MonthCouponList.count) {
            NSDictionary *dict = self.MonthCouponList[_McouponIndex];
            cid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cid"]];
        }
        params = @{@"token":[SKUserInfoModel userToken],@"withMoney":@(Dben),@"money1":@(Dben),@"money2":@(Dben * (_scale + 1)),@"money3":@(benjin * 1.15),@"money4":@(benjin * 1.10),@"money5":@(_fee),@"lever":@(_scale),@"tradeDate":@"0",@"cycle":@(_currentMonth),@"cid":cid};
    }
    WS(weakSelf);
    [SVCCommunityApi CommitfuturesWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf.view toastShow:msg];
    if (code == 400) {
    [weakSelf logout];
    }
    } andfail:^(NSError *error) {
        
    } path:path];
}
#pragma mark --> 选择优惠券的回调
- (void)indexDidselected:(NSInteger)type
{
    if (_currentIndex == 1) {
        _McouponIndex = type;
    }else{
        _DcouponIndex = type;
    }
    [self.mainTableView reloadData];
}
#pragma mark --> 跳转web页面
- (void)bsWebVC:(NSString *)url
{
    BSWKwebViewController *webVC = [[BSWKwebViewController alloc] init];
    webVC.title = @"协议";
    webVC.url = [NSString stringWithFormat:@"%@%@",ServerUrl,url];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

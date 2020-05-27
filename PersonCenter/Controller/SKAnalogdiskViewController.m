//
//  SKAnalogdiskViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/15.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAnalogdiskViewController.h"
#import "SKAnalogdiskHeaderView.h"
#import "SKanalogdiskPurchaseCell.h"
#import "SKSelectedShareViewController.h"
#import "SKchicangTypeChnageCell.h"
#import "WSProgressHUD.h"
#import "SKchengjiaoCell.h"
#import "SKchetuoCell.h"
#import "SKchicangCell.h"
#import "SKshareTypeModel.h"
#import "SKStockDataInfoCell.h"
#import "SKAnalogdiskTypeCell.h"
#import "SKShareselectModel.h"
@interface SKAnalogdiskViewController ()<UITableViewDelegate , UITableViewDataSource , SKAnalogdiskTypeCellDelegate , SKanalogdiskPurchaseCellDelegate , SKshareSelectedViewDelegate , SKchicangTypeChnageCellDelegate , SKchicangCellSellorBuyClickViewDelegate>
{
    NSInteger _currentIndex;//切换 （1 股票买入 2股票c卖出 3股票持仓）
    NSString *_assets;
    NSString *_market;
    NSString *_balance;//余额
    NSString *_earnings;
    NSString *_dayearnings;
    NSString *_weekearnings;
    NSString *_currentcode;//股票编码
    NSInteger _changType;
    NSString *_price;
    NSString *_countNum;//最大可买入股数
    NSString *_currentgid;
    NSString *_Maxamount;//最大可卖出股数
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *tradeSources;
@property (nonatomic , strong)NSMutableArray *chicangsources;
@property (nonatomic , strong)NSMutableArray *weituosources;
@property (nonatomic , strong)NSMutableArray *chengjiaosources;
@end

@implementation SKAnalogdiskViewController
- (NSMutableArray *)tradeSources
{
    if (!_tradeSources) {
        _tradeSources = [NSMutableArray new];
    }
    return _tradeSources;
}
- (NSMutableArray *)chicangsources
{
    if (!_chicangsources) {
        _chicangsources = [NSMutableArray new];
    }
    return _chicangsources;
}
- (NSMutableArray *)chengjiaosources
{
    if (!_chengjiaosources) {
        _chengjiaosources = [NSMutableArray new];
    }
    return _chengjiaosources;
}
- (NSMutableArray *)weituosources
{
    if (!_weituosources) {
        _weituosources = [NSMutableArray new];
    }
    return _weituosources;
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
       tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerClass:[SKAnalogdiskTypeCell class] forCellReuseIdentifier:@"SKAnalogdiskTypeCell"];
        [self registerCell:@"SKanalogdiskPurchaseCell" withTab:tab];
        [self registerCell:@"SKchengjiaoCell" withTab:tab];
        [self registerCell:@"SKchetuoCell" withTab:tab];
        [self registerCell:@"SKchicangCell" withTab:tab];
        [self registerCell:@"SKStockDataInfoCell" withTab:tab];
                [self registerCell:@"SKchicangTypeChnageCell" withTab:tab];
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [tab registerNib:[UINib nibWithNibName:@"SKAnalogdiskHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SKAnalogdiskHeaderView"];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _currentIndex = 1;
    [self.mainTableView.mj_header beginRefreshing];
    _currentcode = @"请输入股票代码/简拼";
    _changType = 1;
    // Do any additional setup after loading the view.
}
#pragma mark --> 数据请求
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi simulateAnalogdiskWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            _assets = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"assets"]];
            _market = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"market"]];
            _balance = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"balance"]];
            _earnings = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"earnings"]];
            _dayearnings = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"dayearnings"]];
            _weekearnings = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"weekearnings"]];
        }else{
            [weakSelf.view toastShow:msg];
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SKAnalogdiskTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKAnalogdiskTypeCell" forIndexPath:indexPath];
            [cell setupViewwithTag:_currentIndex titleArr:@[@"股票买入",@"股票卖出",@"股票持仓"]];
            cell.vDelegate = self;
            cell.selectionStyle = 0;
            return cell;
        }else{
            if (_currentIndex == 3) {
                SKchicangTypeChnageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKchicangTypeChnageCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                cell.Vdelegate = self;
                [cell skchangeType:_changType];
                return cell;
            }else{
            SKanalogdiskPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKanalogdiskPurchaseCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.vDelegate = self;
                [cell.NumTF addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
                 [cell.priceTF addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
            [cell setupBussinessButtonType:_currentIndex code:_currentcode price:_price countNum:_countNum];
            return cell;
            }
        }
    }else{
        if (_currentIndex == 3) {
            if (_changType == 1) {
                SKchicangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKchicangCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                SKshareTypeModel *model = self.chicangsources[indexPath.row];
            cell.vDelegate = self;
                [cell setShareTypeModel:model index:indexPath.row];
                return cell;
            }else if (_changType == 2){
                SKchetuoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKchetuoCell" forIndexPath:indexPath];
                SKshareTypeModel *model = self.weituosources[indexPath.row];
                cell.model = model;
                cell.selectionStyle = 0;
                return cell;
            }else{
                SKchengjiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKchengjiaoCell" forIndexPath:indexPath];
                cell.selectionStyle = 0;
                SKshareTypeModel *model = self.chengjiaosources[indexPath.row];
                cell.model = model;
                return cell;
            }
        }else{
        SKStockDataInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"SKStockDataInfoCell" forIndexPath:indexPath];
        infoCell.selectionStyle = 0;
        if (self.tradeSources.count > 0) {
            [infoCell setshareInfoWithDict:self.tradeSources[0]];
        }
        return infoCell;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SKAnalogdiskHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKAnalogdiskHeaderView"];
        [headerView setupViewwithassets:_assets market:_market balance:_balance earnings:_earnings dayearnings:_dayearnings weekearnings:_weekearnings];
        return headerView;
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        if (_currentIndex == 3) {
            if (_changType == 1) {
                return self.chicangsources.count;
            }else if (_changType == 2){
              return self.weituosources.count;
            }else{
            return self.chengjiaosources.count;
            }
        }else{
    return 1;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            return 44;
        }else{
            if (_currentIndex == 3) {
                return 60;
            }else{
            return 295;
            }
        }
    }else{
        if (_currentIndex == 3) {
            if (_changType == 1) {
                return 88;
            }else if (_changType == 2){
                return 170;
            }else{
                return 145;
            }
        }else{
        return 199;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 198;
    }else{
        return 0.01f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (_currentIndex == 3) {
            return 0.01;
        }else{
        return 10.0f;
        }
    }else{
    return 0.01f;
    }
}
#pragma mark --> 点击切换选股/查看股票交易/购买按钮
- (void)SKanalogdiskPurchaseCellClick:(NSString *)shareNum type:(NSString*)type
{
    WS(weakSelf);
     NSDictionary *params;
    if ([shareNum isEqualToString:@"Y-Y"]) {
    params = @{@"token":[SKUserInfoModel userToken],@"code":_currentcode,@"type":type};
        [SVCCommunityApi SimulateInfoNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if(code == 0){
                [weakSelf.tradeSources removeAllObjects];
                NSDictionary *dataDict = [JSON objectForKey:@"data"];
                [weakSelf.tradeSources addObject:dataDict];
                _Maxamount = [dataDict objectForKey:@"maxNum"];
            _countNum = _Maxamount;
            _price = [dataDict objectForKey:@"nowPri"];
            }else{
                [weakSelf.view toastShow:msg];
            }
            [weakSelf.mainTableView reloadData];
        } andfail:^(NSError *error) {
            [weakSelf.view toastShow:netFailString];
        } path:@"info"];
    }else if ([shareNum isEqualToString:@"Y-X"]){
        if (_currentIndex == 1) {
            [self nowBuy:@"buy" curretnIndex:_currentIndex];
        }else{
             [self nowBuy:@"sell" curretnIndex:_currentIndex];
        }
    }else{
        SKSelectedShareViewController *slectedVC = [[SKSelectedShareViewController alloc] init];
        slectedVC.title = @"钱程优顾";
        slectedVC.code = _currentcode;
        slectedVC.type = _currentIndex - 1;
        slectedVC.Vdelegate = self;
        [self.navigationController pushViewController:slectedVC animated:NO];
    }
}
- (void)SKchicangTypeChnageCellTypeClickTag:(NSInteger)tag
{
    _changType = tag;
    NSString *path;
    if (tag == 1) {
        path = @"position";
    }else if (tag == 2){
        path = @"entrust";
    }else{
        path = @"recode";
    }
    [self SimulateInfoshare:tag path:path];
}
- (void)SKshareSelectedViewTypeClickWithcode:(NSString *)code gid:(NSString *)gid amount:(NSString *)amount type:(NSString *)type
{
    _currentcode = code;
    _currentgid = gid;
    if ([type isEqualToString:@"1"]) {
    [self SKanalogdiskPurchaseCellClick:@"Y-Y" type:@"2"];
    }else{
        [self SKanalogdiskPurchaseCellClick:@"Y-Y" type:@"1"];
    }
}
- (void)changAmountClickType:(NSInteger)tape
{
    if ([_Maxamount integerValue] > 99) {
        _countNum = [NSString stringWithFormat:@"%d",[_Maxamount integerValue]/(tape)];
    if ([_countNum integerValue] < 100) {
     [self.view toastShow:@"操作数目小于100"];
    }else{
    if (tape != 1) {
    if ([_countNum integerValue] % 100 != 0) {
    _countNum = [NSString stringWithFormat:@"%d",([_countNum integerValue] /100 + 1) * 100];
    }
    }else{
        
    }
        [self.mainTableView reloadData];
    }
    }else{
        [self.view toastShow:@"暂无可操作数量"];
    }
}
- (void)SKAnalogdiskTypeCellTypeViewClick:(NSInteger)tag
{
    _currentIndex = tag;
    if (_changType == 1 && _currentIndex == 3) {
       [self SimulateInfoshare:1 path:@"position"];
    }
    _currentcode = @"请输入股票代码/简拼";
    _price = 0;
    _countNum = 0;
    [self.mainTableView reloadData];
}
#pragma mark --> 请求股票信息
- (void)SimulateInfoshare:(NSInteger)type path:(NSString *)path
{
    [WSProgressHUD show];
    WS(weakSelf);
    [SVCCommunityApi SimulateInfoNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [WSProgressHUD dismiss];
        if (code == 0) {
            [weakSelf.chengjiaosources removeAllObjects];
            [weakSelf.weituosources removeAllObjects];
            [weakSelf.chicangsources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
                for (NSDictionary *dict in list) {
                 SKshareTypeModel *model = [SKshareTypeModel initWithDictionary:dict];
                    if (type == 2) {
                        [weakSelf.weituosources addObject:model];
                    }else if(type == 3){
                        [weakSelf.chengjiaosources addObject:model];
                    }else{
                        [weakSelf.chicangsources addObject:model];
                    }
                }
        }
        [weakSelf.mainTableView reloadData];
    } andfail:^(NSError *error) {
        [WSProgressHUD dismiss];
        [weakSelf.view toastShow:netFailString];
    } path:path];
}
#pragma mark --> 检测textfield文本内容改变
- (void)valueChange:(UITextField *)sender
{
    if (sender.tag == 1206) {
        _price = sender.text;
    }else{
        _countNum = sender.text;
    }
}
#pragma mark --> 增减价格和数量
- (void)changevalue:(NSString *)price count:(NSString *)count
{
    _countNum = count;
    _price = price;
}
#pragma mark --> 买入/卖出股票
- (void)nowBuy:(NSString *)path curretnIndex:(NSInteger)index
{
    if ([_countNum integerValue] % 100 != 0) {
        [self.view toastShow:@"请输入数量为100的整数倍"];
        return;
    }
    if ([_price floatValue] < 0.1) {
        [self.view toastShow:@"请输入价格"];
        return;
    }
    if ([_currentcode isEqualToString:@"请输入股票代码/简拼"]) {
        [self.view toastShow:@"请先选择股票"];
        return;
    }
    NSDictionary *params ;
    if (index == 1) {
       params = @{@"token":[SKUserInfoModel userToken],@"code":_currentcode,@"price":_price,@"amount":_countNum};
    }else{
        params =  @{@"token":[SKUserInfoModel userToken],@"code":_currentcode,@"price":_price,@"amount":_countNum,@"id":_currentgid};
    }
    WS(weakSelf);
    [SVCCommunityApi BuyinWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
             [weakSelf.view toastShow:msg];
    if (code == 0) {
    [weakSelf configData];
    }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:path];
}
#pragma mark --> 股票持仓切换去买卖股票
- (void)SellOrBuyType:(NSInteger)type index:(NSInteger)index
{
    NSString *sellType;
    if (type == 71) {
    _currentIndex = 1;
    sellType = @"1";
    }else{
    _currentIndex = 2;
    sellType = @"2";
    }
     SKshareTypeModel *model = self.chicangsources[index];
    _currentcode = model.code;
    _currentgid = model.gid;
    _Maxamount = [NSString stringWithFormat:@"%@",model.amount];
    [self SKanalogdiskPurchaseCellClick:@"Y-Y" type:sellType];
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

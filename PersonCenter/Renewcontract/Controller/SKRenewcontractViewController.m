//
//  SKRenewcontractViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKRenewcontractViewController.h"
#import "SKJuniorcowCountTypeCell.h"
#import "SKSelectAccountView.h"
#import "SKRenwerTFCell.h"
#import "SKCashoutbuttonViewCell.h"
@interface SKRenewcontractViewController ()<UITableViewDelegate , UITableViewDataSource , SKCashouShowdidClickViewDelegate >
{
    NSInteger _currentIndex;
    NSString *_currentCount;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSArray *list;
@property (nonatomic , strong)NSArray *monthList;
@property (nonatomic,strong) SKSelectAccountView *SelectView;

@property (nonatomic,strong) UIView *bgView;
@end

@implementation SKRenewcontractViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [self registerCell:@"SKRenwerTFCell" withTab:tab];
        [self registerCell:@"SKCashoutbuttonViewCell" withTab:tab];
        [self registerCell:@"SKJuniorcowCountTypeCell" withTab:tab];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)registerCell:(NSString *)cellName withTab:(UITableView *)tab
{
    [tab registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
      self.list = @[@"总操盘资金",@"亏损警戒线",@"亏损平仓线",@"初始风险保障金",@"到期日期",@"借款管理费"];
    }else{
       self.list = @[@"总操盘资金",@"亏损警戒线",@"亏损平仓线",@"初始风险保障金",@"账户余额"];
    }
    self.monthList = @[@"一个月",@"两个月",@"三个月",@"四个月",@"五个月",@"六个月",@"终止交易"];
    _currentIndex = 6;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainTableView.mj_header beginRefreshing];
}
- (void)configData
{
    NSDictionary *param = @{@"type":@"2",@"id":self.uid,@"token":[SKUserInfoModel userToken]};
    WS(weakSelf);
    NSString *path = @"detail";
    if (self.type == 1) {
        path = @"renewal_info";
    }
    [SVCCommunityApi renewaldetailWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            [weakSelf.sources addObject:JSON];
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
    } path:path];
}
-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.list.count) {
        SKJuniorcowCountTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJuniorcowCountTypeCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        if (self.sources.count > 0) {
            [cell setupViewWithtitle:self.list[indexPath.row] content:self.sources[0] type:2 index:indexPath];
        }
        return cell;
    }else if(indexPath.row == self.list.count){
         if (self.type == 1) {
            SKJuniorcowCountTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJuniorcowCountTypeCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
             if (self.sources.count > 0) {
                 NSString *type = [self.sources[0] objectForKey:@"type"];
                 if ([type integerValue] == 0) {
                     _currentIndex = 6;
                 }
             }
           [self settitle:@"续约/终止（0表示终止）" content:self.monthList[_currentIndex] type:3 cell:cell];
            return cell;
        }else{
        SKRenwerTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRenwerTFCell" forIndexPath:indexPath];
            [cell.countTF addTarget:self action:@selector(countTFValueChange:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = 0;
        return cell;
        }
    }else{
        SKCashoutbuttonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKCashoutbuttonViewCell" forIndexPath:indexPath];
        [cell setbuttontile:@"提交" type:1];
        cell.vDelegate = self;
        cell.selectionStyle = 0;
        return cell;
    }
}
- (void)settitle:(NSString *)title content:(NSString *)content type:(NSInteger)type cell:(SKJuniorcowCountTypeCell *)cell
{
    [cell setupViewWithTX:title content:content type:type];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.list.count) {
        return 50;
    }else if (indexPath.row == self.list.count){
        return 60;
    }else{
        return 100;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count + 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.list.count && self.type == 1) {
        if (self.sources.count > 0) {
            NSString *type = [self.sources[0] objectForKey:@"type"];
            if ([type integerValue] != 0) {
                [self selectAccountButtonClick];
            }else{
            
            }
        }
    }
}
- (void)senderDidClick
{
    WS(weakSelf);
    if ([_currentCount integerValue] >= 0) {
     NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"cycle":@(_currentIndex + 1)};
    if (_currentIndex == 6) {
    params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"cycle":@(0)};
    }
        NSString *path = @"renewal_add";
        if (self.type == 2) {
            params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"money":_currentCount};
            path = @"add";
        }
        [SVCCommunityApi renewalWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            //        if (code == 0) {
            [weakSelf.view toastShow:msg];
            //        }
        } andfail:^(NSError *error) {
            
        } path:path];
    }else{
        [self.view toastShow:@"请输入正确的金额"];
    }
}
-(void)selectAccountButtonClick{
    UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.6;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    SKSelectAccountView *view = [[SKSelectAccountView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 350)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.dataArray = self.monthList;
    WS(weakSelf);
    [view setCellClickIndexPath:^(NSString *StockAccount ,NSInteger tag) {
        _currentIndex = tag;
        [weakSelf.mainTableView reloadData];
        [weakSelf bgViewClick];
    }];
    self.SelectView = view;
}
-(void)bgViewClick{
    [self.bgView removeFromSuperview];
    [self.SelectView removeFromSuperview];
}
- (void)countTFValueChange:(UITextField *)tf
{
    _currentCount = tf.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self.view endEditing:YES];
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

//
//  SKLiftibgsurplusViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/25.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKLiftibgsurplusViewController.h"
#import "SKLiftingsurplusHistoryViewController.h"
#import "SKLiftingsurplusCell.h"
#import "SKCashoutbuttonViewCell.h"
#import "SKCashoutShowInfoCell.h"
#import "SKSelectAccountView.h"
@interface SKLiftibgsurplusViewController ()<UITableViewDelegate , UITableViewDataSource , SKCashouShowdidClickViewDelegate>
{
    NSString *_amount;
    NSString *_balance;
    SKLiftingsurplusCell *_OneCell;
}
@property (nonatomic , weak)UITableView *mainTableView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) SKSelectAccountView *SelectView;

@property (nonatomic,strong) UIView *bgView;
@end

@implementation SKLiftibgsurplusViewController
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKLiftingsurplusCell" withTab:tab];
        [self registerCell:@"SKCashoutbuttonViewCell" withTab:tab];
        [self registerCell:@"SKCashoutShowInfoCell" withTab:tab];
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
[self addRightBtn];
    [self getstockMessage];
    [self getBalanceWithgroup];
    // Do any additional setup after loading the view.
}
- (void)getBalanceWithgroup{
       NSDictionary *params = @{@"token":[SKUserInfoModel userToken]};
       WS(weakSelf);
       [SVCCommunityApi getBalanceWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
       if (code == 0) {
       _balance = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"data"] objectForKey:@"balance"]];
       }else if (code == 400){
       [weakSelf logout];
       }else{

       }
       [weakSelf.mainTableView reloadData];
       } andfail:^(NSError *error) {

       }];
}
- (void)logout{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [SKUserInfoModel deleteModel];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)addRightBtn {
       UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
       but.frame =CGRectMake(0,0, 60, 35);
       but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
       [but setTitle:@"提盈记录"forState:UIControlStateNormal];
       [but addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
       self.navigationItem.rightBarButtonItem = barBut;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKLiftingsurplusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKLiftingsurplusCell" forIndexPath:indexPath];
    cell.banlance = _balance;
         [cell.acountTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
        WS(weakSelf);
        [cell setSelectButtonClick:^{
            [weakSelf selectAccountButtonClick];
        }];
        _OneCell = cell;
        cell.selectionStyle = 0;
        return cell;
    }else if(indexPath.row == 1){
        SKCashoutbuttonViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SKCashoutbuttonViewCell" forIndexPath:indexPath];
        [cell setbuttontile:@"提交" type:2];
        cell.vDelegate = self;
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKCashoutShowInfoCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SKCashoutShowInfoCell" forIndexPath:indexPath];
                [cell settitleLab:@"温馨提示" dec:@"您的单个账户符合以下条件时,初级牛人(月)有权按10000元的整数倍申请提取盈利，钱程优顾在下个交易日将您的提盈转到您的钱程优顾账户，账户总资产超过初始申请资金110%且有现金的，可以每天提盈一次。 例如: 10万元领投本金申请50万元跟投资金的该合同，总资产60万元 提盈:600000x110%=660000之.上 部分可以提取，当账户总资产达到67万时可以提取1万元盈利，小于110%部分，即660000里60000的部分可以缴纳利息。(天天 策略不受该110%提盈标准限制)，当天的提盈截止时间15:00，盈利金额以当天收盘后的资产净值为准。"];
        cell.selectionStyle = 0;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 240;
    }else if(indexPath.row == 1){
        return 100;
    }else{
        return 266;
    }
}
- (void)changedTextField:(UITextField *)tf {
    _amount = tf.text;
    
}
-(void)selectAccountButtonClick{
    if (self.dataArray.count < 1) {
    [self.view toastShow:@"当前账号暂无可操作股票"];
    return;
    }
    UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.6;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    SKSelectAccountView *view = [[SKSelectAccountView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 250)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.dataArray = self.dataArray;
    WS(weakSelf);
    [view setCellClickIndexPath:^(NSString *StockAccount,NSInteger tag) {
        _OneCell.accountNum = StockAccount;
        [weakSelf.mainTableView reloadData];
        [weakSelf bgViewClick];
    }];
    self.SelectView = view;
}

-(void)bgViewClick{
    [self.bgView removeFromSuperview];
    [self.SelectView removeFromSuperview];
}


- (void)senderDidClick
{
    if ([_amount integerValue] > 0) {
        [self commitTiying];
    }else{
        [self.view toastShow:@"请输入提盈金额"];
    }
}
- (void)commitTiying{
    if (_OneCell.accountNum == nil) {
        [self.view toastShow:@"请选择股票账户"];
        return;
    }
    WS(weakSelf);
   NSDictionary *param = @{@"token":[SKUserInfoModel userToken],@"account":_OneCell.accountNum,@"amount":@([_amount floatValue])};
    [SVCCommunityApi commitTiyingWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.view toastShow:msg];
            [weakSelf onClickedOKbtn];
        }
    } andfail:^(NSError *error) {
        
    }];
}
- (void)onClickedOKbtn {
    SKLiftingsurplusHistoryViewController *LiftingsurplusHistoryVC = [[SKLiftingsurplusHistoryViewController alloc] init];
    LiftingsurplusHistoryVC.title = @"提盈记录";
    [self.navigationController pushViewController:LiftingsurplusHistoryVC animated:YES];
}
/** 获取股票信息 */
-(void)getstockMessage{
       NSDictionary *param = @{@"token":[SKUserInfoModel userToken]};
    [SVCCommunityApi getStockMessageWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        self.dataArray = [JSON objectForKey:@"data"];
    } andfail:^(NSError *error) {
    
    }];
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

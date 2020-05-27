//
//  SKBankMangerViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBankMangerViewController.h"
#import "SKBankInfoCell.h"
#import "SKaddBankCardTableViewCell.h"
#import "SKAddBankCradTwoViewController.h"
@interface SKBankMangerViewController ()<UITableViewDelegate , UITableViewDataSource , SKBankCardmoveClickViewDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *source;
@end

@implementation SKBankMangerViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKBankInfoCell" withTab:tab];
        [self registerCell:@"SKaddBankCardTableViewCell" withTab:tab];
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
    // Do any additional setup after loading the view.
}
- (void)config
{
    WS(weakSelf);
    [SVCCommunityApi getBankInfoWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
        NSString *bankcode = [JSON objectForKey:@"bankcode"] ;
        if ( bankcode.length > 4) {
         [weakSelf.source addObject:JSON];
        }
        }
        [weakSelf.mainTableView reloadData];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.source.count) {
        SKBankInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKBankInfoCell" forIndexPath:indexPath];
        [cell setBankInfoWithDict:self.source[0]];
        cell.vDelegate = self;
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKaddBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKaddBankCardTableViewCell" forIndexPath:indexPath];
    if (indexPath.section < 1) {
    [cell settitle:@"添加银行卡"];
    }else{
    [cell settitle:@"修改银行卡"];
    }
        cell.selectionStyle = 0;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.source.count) {
        return 200;
    }else{
        return 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.source.count+1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == self.source.count) {
        SKAddBankCradTwoViewController *bankVC = [[SKAddBankCradTwoViewController alloc] init];
    if (indexPath.section < 1) {
    bankVC.title =  @"添加银行卡";
    }else{
  bankVC.title = @"修改银行卡";
    }        [self.navigationController pushViewController:bankVC animated:YES];
    }
}
- (void)SKbankCardmoveClick
{
    [self creatAlertController_sheet:@"您要解绑当前银行卡"];
}
-(void)creatAlertController_sheet:(NSString *)msg {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self movebank];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [actionSheet addAction:action2];
     [actionSheet addAction:action1];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)movebank
{
    WS(weakSelf);
    [SVCCommunityApi moveBankCardWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.view toastShow:@"银行卡解绑成功"];
            [weakSelf.source removeAllObjects];
            [weakSelf.mainTableView reloadData];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
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

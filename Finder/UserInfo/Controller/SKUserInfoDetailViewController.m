//
//  SKUserInfoDetailViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/21.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKUserInfoDetailViewController.h"
#import "SKPersonImagellCell.h"
#import "SKPersonInfoTypeCell.h"
#import "SKoutLoginCell.h"
#import "SKMainFootView.h"
@interface SKUserInfoDetailViewController ()<UITableViewDelegate , UITableViewDataSource >
{
    NSString *_nickName;
NSString *_company;
NSString *_zyzg;
NSString *_zgzs;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;

@end

@implementation SKUserInfoDetailViewController

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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKPersonImagellCell" withTab:tab];
        [self registerCell:@"SKPersonInfoTypeCell" withTab:tab];
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
_nickName = [[self.userInfoDict objectForKey:@"info"] objectForKey:@"realname"];
_company = [[self.userInfoDict objectForKey:@"info"] objectForKey:@"company"];
_zyzg = [[self.userInfoDict objectForKey:@"info"] objectForKey:@"zyzg"];
//NSArray *zgzsList = [self.userInfoDict objectForKey:@"zgzs"];
//if (zgzsList.count > 0) {
//_zgzs = zgzsList[0];
//}
[self.mainTableView reloadData];
//    [self config];
    // Do any additional setup after loading the view.
}
- (void)config{

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            SKPersonImagellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonImagellCell" forIndexPath:indexPath];
            cell.headImagellPath = self.userImagellPath;
            cell.selectionStyle = 0;
            return cell;
        }else{
            SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
            if (indexPath.row == 1) {
                [cell setTypeLab:@"昵称" des:_nickName];
            }else{
                [cell setTypeLab:@"个性签名" des:@"风险第一，收益第二"];
            }
            cell.selectionStyle = 0;
            return cell;
        }
    }else{
        SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTypeLab:@"单位" des:_company];
        }else if(indexPath.row == 1){
            [cell setTypeLab:@"职业资格" des:_zyzg];
        }else{
            [cell setTypeLab:@"证书编号" des:_zgzs];
        }
        cell.selectionStyle = 0;
        return cell;
    }
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }else{
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return kScreenHeight - Knavheight - 40 - 70 - 45 * 7;
    }
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)setNicknameSuccessful:(NSString *)nickName
{
    _nickName = nickName;
    [self.mainTableView reloadData];
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

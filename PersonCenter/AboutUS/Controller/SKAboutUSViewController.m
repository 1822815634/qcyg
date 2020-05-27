//
//  SKAboutUSViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAboutUSViewController.h"
#import "SKInvitationViewController.h"
#import "BSWKwebViewController.h"
#import "SKPersonInfoTypeCell.h"
@interface SKAboutUSViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *ConstractList;
@end

@implementation SKAboutUSViewController
- (NSMutableArray *)ConstractList
{
    if (!_ConstractList) {
        _ConstractList = [NSMutableArray new];
    }
    return _ConstractList;
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
    [self configData];
    // Do any additional setup after loading the view.
}
- (void)configData {
    WS(weakSelf);
    [SVCCommunityApi abouthelpNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.ConstractList removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                [weakSelf.ConstractList addObject:dict];
            }
        }
        [weakSelf.mainTableView reloadData];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
        [self.mainTableView reloadData];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                 [cell setTypeLab:@"关于我们" des:@""];
                break;
            case 1:
                [cell setTypeLab:@"安全保障" des:@""];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
         [cell setTypeLab:@"邀请好友" des:@""];
    }else if (indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
                 [cell setTypeLab:@"联系我们" des:@""];
                break;
            case 1:
                [cell setTypeLab:@"帮助中心" des:@""];
                break;
            default:
                break;
        }
    }else{
        [cell setTypeLab:@"版本号 1.0.0" des:@""];
    }
    return cell;
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
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 2){
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 45;
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
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self webChange:0 title:@"关于我们"];
                break;
            case 1:
                [self webChange:2 title:@"安全保障"];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
    [self inviteFriends];
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                [self webChange:3 title:@"联系我们"];
                break;
            case 1:
                [self webChange:4 title:@"帮助中心"];
                break;
            default:
                break;
        }
    }
}
#pragma mark --> 跳转判断
- (void)webChange:(NSInteger)tag title:(NSString *)title
{
    if (self.ConstractList.count > 0) {
        NSDictionary *dict = self.ConstractList[tag];
        [self initWebWithPath:[dict objectForKey:@"url"] title:title];
    }
}
#pragma mark -->  跳转H5
- (void)initWebWithPath:(NSString *)path title:(NSString *)title
{
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = path;
    constactVC.title = title;
    [self.navigationController pushViewController:constactVC animated:YES];
}
- (void)inviteFriends
{
  SKInvitationViewController *invatationVC = [[SKInvitationViewController alloc] init];
  invatationVC.title = @"我的邀请";
 invatationVC.type = 1;
 [self.navigationController pushViewController:invatationVC animated:YES];
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

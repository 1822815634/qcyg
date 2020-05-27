//
//  SKAuthenticationViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAuthenticationViewController.h"
#import "SKMyAnswerViewController.h"
#import "SKUserInfoDetailViewController.h"
#import "SKMyAuthenticationViewController.h"
#import "SKViewPointDetailViewController.h"
#import "SKUserCenterHeaderView.h"
#import "SKUserAcountMessageCell.h"
#import "SKuserInfoTypeChangeHeaderView.h"
#import "SKSQestionInfoCell.h"
#import "SKviewPointModel.h"
#import "SKJingXuanCell.h"
#import "SKviewPointModel.h"
#import "SKquestionAndAswerCell.h"
#import "SKQuestionModel.h"
#import "SKPointDetailViewController.h"
#import "SKQuestionDetailViewController.h"
@interface SKAuthenticationViewController ()<UITableViewDelegate , UITableViewDataSource ,SKuserInfoTypeChangeHeaderViewDelegate , SKUserCenterHeaderViewanswerClickDelegate , SKSQestionInfoCellDelegate , SKJingXuanCellClickViewDelegate>
{
     NSInteger _currentInde;//切换 （1 我的观点  2 我的提问 3 我的回答）
     UIButton *_rightButton;
     NSDictionary *infoDict;//信息字典
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *userInfoSources;//用户信息数据源
@property (nonatomic , strong)NSMutableArray *pointSources;//观点数据源
@property (nonatomic , strong)NSMutableArray *answerSources;//回答数据源
@property (nonatomic , strong)NSMutableArray *questionSources;//提问数据源
@end

@implementation SKAuthenticationViewController
- (NSMutableArray *)questionSources
{
    if (!_questionSources) {
        _questionSources = [NSMutableArray new];
    }
    return _questionSources;
}
- (NSMutableArray *)userInfoSources
{
    if (!_userInfoSources) {
        _userInfoSources = [NSMutableArray new];
    }
    return _userInfoSources;
}
- (NSMutableArray *)pointSources
{
    if (!_pointSources) {
        _pointSources = [NSMutableArray new];
    }
    return _pointSources;
}
- (NSMutableArray *)answerSources
{
    if (!_answerSources) {
        _answerSources = [NSMutableArray new];
    }
    return _answerSources;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.estimatedRowHeight = 100;
        [tab registerNib:[UINib nibWithNibName:@"SKUserAcountMessageCell" bundle:nil] forCellReuseIdentifier:@"SKUserAcountMessageCell"];
        [tab registerNib:[UINib nibWithNibName:@"SKquestionAndAswerCell" bundle:nil] forCellReuseIdentifier:@"SKquestionAndAswerCell"];
        [tab registerNib:[UINib nibWithNibName:@"SKJingXuanCell" bundle:nil] forCellReuseIdentifier:@"SKJingXuanCell"];
     [tab registerNib:[UINib nibWithNibName:@"SKSQestionInfoCell" bundle:nil] forCellReuseIdentifier:@"SKSQestionInfoCell"];
        [tab registerClass:[SKuserInfoTypeChangeHeaderView class] forHeaderFooterViewReuseIdentifier:@"SKuserInfoTypeChangeHeaderView"];
        [tab registerClass:[SKUserCenterHeaderView class] forHeaderFooterViewReuseIdentifier:@"SKUserCenterHeaderView"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _currentInde = 1;
    [self addRightBtn];
    [self requestData];
    // Do any additional setup after loading the view.
}
- (void)requestData{
    WS(weakSelf);
    [WSProgressHUD show];
    dispatch_group_t group = dispatch_group_create();
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"uid":[SKUserInfoModel userUid]} path:@"statistics" type:1];
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"uid":[SKUserInfoModel userUid],@"type":@"2"} path:@"lists" type:2];
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"type":@"0"} path:@"type" type:3];
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"type":@"1"} path:@"type" type:4];
    [weakSelf getAdvancetise:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       [WSProgressHUD dismiss];
        [weakSelf.mainTableView reloadData];
    });
}
#pragma mark -->  type 1: 个人中心  type2 ：观点  type 3 ：问列表 4 ：答列表
- (void)request1:(dispatch_group_t)group params:(NSDictionary *)params path:(NSString *)path type:(NSInteger)type{
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi questionListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            if(type == 1){
                NSDictionary *dataDic = [JSON objectForKey:@"data"];
                [weakSelf.userInfoSources addObject:dataDic];
            }else{
                NSArray *list = [JSON objectForKey:@"data"];
                for (NSDictionary *dict in list) {
                    if (type == 2) {
                        SKviewPointModel *model = [SKviewPointModel initWithDictionary:dict];
                        [weakSelf.pointSources addObject:model];
                    }else{
                        SKQuestionModel *model = [SKQuestionModel initWithDictionary:dict];
                        if (type == 3) {
                           [weakSelf.questionSources addObject:model];
                        }else{
                        [weakSelf.answerSources addObject:model];
                        }
                    }
                }
            }
        }
        if (code == -1) {
            [weakSelf.view toastShow:JSON[@"msg"]];
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
        dispatch_group_leave(group);
    } path:path];
}
#pragma mark --> 获取认证状态
- (void)getAdvancetise:(dispatch_group_t)group
{
       dispatch_group_enter(group);
       [SVCCommunityApi getadviserInfoNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
       if (code == 0) {
       NSDictionary *dict = [JSON objectForKey:@"data"];
       infoDict = dict;
       NSDictionary *info = [dict objectForKey:@"info"];
       NSString *isren = [NSString stringWithFormat:@"%@",[info objectForKey:@"isren"]];
       if ([isren isEqualToString:@"1"]) {
       [_rightButton setTitle:@"已认证" forState:0];
       }
       }
       dispatch_group_leave(group);
       } andfail:^(NSError *error) {
       dispatch_group_leave(group);
       } path:@"adviser"];
}
#pragma mark --> 我要认证
- (void)addRightBtn {
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame =CGRectMake(0,0, 60, 35);
    _rightButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [_rightButton setTitle:@"我要认证"forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SKUserAcountMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKUserAcountMessageCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        if (self.userInfoSources.count > 0) {
            [cell setuserAcountInfoWithDic:self.userInfoSources[0]];
        }
        return cell;
    }else{
        if (_currentInde == 1) {
            SKJingXuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKJingXuanCell" forIndexPath:indexPath];
            cell.selectionStyle = 0;
            SKviewPointModel *model = self.pointSources[indexPath.row];
        cell.vDelegate = self;
            [cell setviewPointModel:model index:indexPath type:1];
            return cell;
        }else{
            if (_currentInde == 3) {
                SKQuestionModel *model = self.answerSources[indexPath.row];
            if (model.hdcontent.length > 2) {
            return [self setcellModel:model tab:tableView index:indexPath];
            }else{
            return [self infoCellWithModel:model tab:tableView index:indexPath type:@"1"];
            }
            }else{
                SKQuestionModel *model = self.questionSources[indexPath.row];
            if (model.hdcontent.length > 2) {
             return [self setcellModel:model tab:tableView index:indexPath];
            }else{
            return [self infoCellWithModel:model tab:tableView index:indexPath type:@"2"];
            }
            }
        }
    }
}
- (SKquestionAndAswerCell *)setcellModel:(SKQuestionModel *)model tab:(UITableView *)tableView index:(NSIndexPath *)index
{
      SKquestionAndAswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKquestionAndAswerCell" forIndexPath:index];
      cell.selectionStyle = 0;
      cell.model = model;
      return cell;
}
- (SKSQestionInfoCell *)infoCellWithModel:(SKQuestionModel *)model tab:(UITableView *)tableView index:(NSIndexPath *)index type:(NSString *)type
{
       SKSQestionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKSQestionInfoCell" forIndexPath:index];
       cell.selectionStyle = 0;
     cell.vDelegate = self;
     [cell setType:type index:index];
       cell.model = model;
       return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SKUserCenterHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKUserCenterHeaderView"];
        headerView.vDelegate = self;
        if (self.userInfoSources.count > 0) {
            [headerView setupUserInfoHeaderViewWithdic:self.userInfoSources[0] nickName:self.nickName imagePath:self.imagellPath type:1 active:3];
        } else {
            //不是投顾
            [headerView setupUserInfoHeaderViewWithdic:nil nickName:self.nickName imagePath:self.imagellPath type:1 active:3];
        }
        return headerView;
    }else{
        SKuserInfoTypeChangeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKuserInfoTypeChangeHeaderView"];
        headerView.vDelegate = self;
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        [headerView infoTypeChangeHeaderView:_currentInde title:@[@"我的观点",@"我的提问",@"我的回答"]];
        return headerView;
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
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        if (_currentInde == 1) {
            return self.pointSources.count;
        }else if (_currentInde == 2){
            return self.questionSources.count;
        }else{
            return self.answerSources.count;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return;
    }
    if ( _currentInde == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SKviewPointModel *model = self.pointSources[indexPath.row];
        SKPointDetailViewController *pointVC = [[SKPointDetailViewController alloc] init];
        pointVC.title = @"钱程优顾";
        pointVC.content = model.content;
        pointVC.TXtitle = model.title;
        pointVC.right = model.create_time;
        pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
        [self.navigationController pushViewController:pointVC animated:YES];
    } else if(_currentInde == 3) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SKQuestionDetailViewController *sk = [SKQuestionDetailViewController new];
        SKQuestionModel *model = self.answerSources[indexPath.row];
        if ([model.hd_status isEqualToString:@"1"]) {
            sk.questionId = model.question_id;
            [self.navigationController pushViewController:sk animated:YES];
        }
    }
}
- (void)gotoViewPointVC:(SKviewPointModel *)model
{
    SKPointDetailViewController *pointVC = [[SKPointDetailViewController alloc] init];
    pointVC.title = @"钱程优顾";
    pointVC.content = model.content;
    pointVC.TXtitle = model.title;
    pointVC.right = model.create_time;
    pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
    [self.navigationController pushViewController:pointVC animated:YES];
    
//    SKViewPointDetailViewController *pointVC = [[SKViewPointDetailViewController alloc] init];
//    pointVC.title = @"钱程策略";
//    pointVC.content = model.content;
//    pointVC.TXtitle = model.title;
//    pointVC.right = model.create_time;
//    pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
//    [self.navigationController pushViewController:pointVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 255;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }else{
        return 0.01f;
    }
}
- (void)infoChangeinfoChangeHeadertype:(NSInteger)type
{
    _currentInde = type;
    [self.mainTableView reloadData];
}
- (void)onClickedOKbtn
{
      if (![_rightButton.currentTitle isEqualToString:@"已认证"]) {
      SKMyAuthenticationViewController *authenVC = [[SKMyAuthenticationViewController alloc] init];
      authenVC.title = @"投顾认证";
      authenVC.userInfoDict = infoDict;
      [self.navigationController pushViewController:authenVC animated:YES];
      }
}
#pragma mark --> 我的个人中心
- (void)questionClick:(NSInteger)type
{
    SKUserInfoDetailViewController *detailVC = [[SKUserInfoDetailViewController alloc] init];
    detailVC.userInfoDict = infoDict;
    detailVC.title = @"我的中心";
    if (self.userInfoSources.count > 0) {
    NSDictionary *dict = self.userInfoSources[0];
    detailVC.userImagellPath = [dict objectForKey:@"imgurl"];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark --> 点赞、回复的点击回调
- (void)zanOrreplyClickWithTag:(NSInteger)tag index:(NSInteger)index
{
     SKviewPointModel *model = self.pointSources[index];
     if (tag == 105) {
     WS(weakSelf);
     NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":[NSString stringWithFormat:@"%ld",(long)model.guandian_id]};
     [SVCCommunityApi giveZsumWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
     model.z_sum = [[JSON objectForKey:@"nums"] integerValue];
     [weakSelf.mainTableView reloadData];
     }
     [weakSelf.view toastShow:msg];
     } andfail:^(NSError *error) {

     }];
     }else{
     [self gotoViewPointVC:model];
     }
}
#pragma mark --> 进入我的问答
- (void)questionSKClick:(NSIndexPath *)index
{
     SKMyAnswerViewController *myanstionVC = [[SKMyAnswerViewController alloc] init];
     myanstionVC.title = @"我来问答";
      SKQuestionModel *model = self.answerSources[index.row];
     myanstionVC.content = model.content;
     myanstionVC.hid = model.question_id;
     [self.navigationController pushViewController:myanstionVC animated:YES];
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

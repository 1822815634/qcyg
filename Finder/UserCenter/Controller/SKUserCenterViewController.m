//
//  SKUserCenterViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKUserCenterViewController.h"
#import "SKUserCenterHeaderView.h"
#import "SKUserAcountMessageCell.h"
#import "SKGivingOpinionsViewController.h"
#import "SKuserInfoTypeChangeHeaderView.h"
#import "SKViewPointDetailViewController.h"
#import "SKUserInfoDetailViewController.h"
#import "SKAuthenticationViewController.h"
#import "SKviewPointModel.h"
#import "SKJingXuanCell.h"
#import "SKviewPointModel.h"
#import "SKquestionAndAswerCell.h"
#import "SKQuestionModel.h"
#import "SKPointDetailViewController.h"
#import "SKQuestionDetailViewController.h"
@interface SKUserCenterViewController ()<UITableViewDelegate , UITableViewDataSource , SKUserCenterHeaderViewanswerClickDelegate , SKuserInfoTypeChangeHeaderViewDelegate , SKJingXuanCellClickViewDelegate>
{
    NSInteger _currentInde;
    NSDictionary *infoDict;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *userInfoSources;
@property (nonatomic , strong)NSMutableArray *pointSources;
@property (nonatomic , strong)NSMutableArray *answerSources;

@end

@implementation SKUserCenterViewController
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
        tab.estimatedRowHeight = 88;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerNib:[UINib nibWithNibName:@"SKUserAcountMessageCell" bundle:nil] forCellReuseIdentifier:@"SKUserAcountMessageCell"];
        [tab registerNib:[UINib nibWithNibName:@"SKquestionAndAswerCell" bundle:nil] forCellReuseIdentifier:@"SKquestionAndAswerCell"];
        [tab registerNib:[UINib nibWithNibName:@"SKJingXuanCell" bundle:nil] forCellReuseIdentifier:@"SKJingXuanCell"];
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
    [self addRightBtn];
    _currentInde = 1;
    [self config];
    // Do any additional setup after loading the view.
}
#pragma mark --> 设置自定义导航栏和右侧按钮
- (void)addRightBtn {
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,Knavheight)];
    backview.layer.backgroundColor =  [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    [self.navigationController.navigationBar setBackgroundImage:[self convertViewToImage:backview]
     forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:kFont(18)};
    UIButton *leftCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftCustomButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    leftCustomButton.frame = CGRectMake(2, 5, 18, 32);
    [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
    [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateHighlighted];
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftCustomButton];
    [self.navigationItem setLeftBarButtonItem:leftButtonItem];
   
}
- (void)config{
      WS(weakSelf);
     [WSProgressHUD show];
     dispatch_group_t group = dispatch_group_create();
     [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"uid":self.uid} path:@"statistics" type:1];
     [weakSelf getAdvancetise:group];
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"uid":self.uid,@"type":@"2"} path:@"lists" type:2];
    [weakSelf request1:group params:@{@"token":[SKUserInfoModel userToken],@"uid":self.uid,@"type":@"6"} path:@"lists" type:3];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    [WSProgressHUD dismiss];
    [weakSelf.mainTableView reloadData];
    });
}
- (void)getAdvancetise:(dispatch_group_t)group
{
      dispatch_group_enter(group);
      [SVCCommunityApi getadviserInfoNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
      if (code == 0) {
      NSDictionary *dict = [JSON objectForKey:@"data"];
      infoDict = dict;
      }
      dispatch_group_leave(group);
      } andfail:^(NSError *error) {
      dispatch_group_leave(group);
      } path:@"adviser"];
}
#pragma mark -->  type 1: 个人中心  type2 ：问答列表  type 3 ：个人观点
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
                        [weakSelf.answerSources addObject:model];
                    }
                }
            }
        }
        dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
       dispatch_group_leave(group);
    } path:path];
}
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
        [cell setviewPointModel:model index:indexPath type:1];
        cell.vDelegate = self;
        return cell;
    }else{
        SKquestionAndAswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKquestionAndAswerCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        SKQuestionModel *model = self.answerSources[indexPath.row];
        cell.model = model;
        return cell;
    }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SKUserCenterHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKUserCenterHeaderView"];
        headerView.vDelegate = self;
        if (self.userInfoSources.count > 0) {
            [headerView setupUserInfoHeaderViewWithdic:self.userInfoSources[0] nickName:self.nickName imagePath:self.imagellPath type:0 active:self.active];
        }
        return headerView;
    }else{
        SKuserInfoTypeChangeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKuserInfoTypeChangeHeaderView"];
        headerView.vDelegate = self;
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        [headerView infoTypeChangeHeaderView:_currentInde title:@[@"TA的观点",@"TA的问答"]];
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
        }else{
          return self.answerSources.count;
        }
    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{     if(indexPath.section == 0) {
            return;
      }
      if ( _currentInde == 1) {
          [tableView deselectRowAtIndexPath:indexPath animated:YES];
          SKviewPointModel *model = self.pointSources[indexPath.row];
          [self gotoViewPointVC:model];
      } else {
          [tableView deselectRowAtIndexPath:indexPath animated:YES];
          SKQuestionDetailViewController *sk = [SKQuestionDetailViewController new];
          SKQuestionModel *model = self.answerSources[indexPath.row];
          sk.questionId = model.question_id;
          [self.navigationController pushViewController:sk animated:YES];
      }
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)questionClick:(NSInteger)type
{
    if (type == 2) {
    SKUserInfoDetailViewController *detailVC = [[SKUserInfoDetailViewController alloc] init];
    detailVC.title = @"我的中心";
    detailVC.userInfoDict = infoDict;
    if (self.userInfoSources.count > 0) {
    detailVC.userImagellPath = [self.userInfoSources[0] objectForKey:@"imgurl"];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
    }else{
    if (type == 55) {
    SKGivingOpinionsViewController *publicVC = [[SKGivingOpinionsViewController alloc] init];
    publicVC.type = 1;
    publicVC.tid = self.uid;
    publicVC.title = @"向TA提问";
    [self.navigationController pushViewController:publicVC animated:YES];
    }else{
    [self poinViewtouchEndClick];
    }
    }
}
- (void)poinViewtouchEndClick
{
      WS(weakSelf);
      NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid};
      [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
          if(code == 0){
              if (self.block) {
                  self.block();
              }
          if (weakSelf.active == 1) {
              weakSelf.active = 2;
          }else{
              weakSelf.active = 1;
          }
          [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
          [weakSelf.mainTableView reloadData];
      }
      } andfail:^(NSError *error) {

      } path:@"attention"];
}
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
- (void)gotoViewPointVC:(SKviewPointModel *)model
{
    SKPointDetailViewController *pointVC = [[SKPointDetailViewController alloc] init];
    pointVC.title = @"钱程优顾";
    pointVC.content = model.content;
    pointVC.TXtitle = model.title;
    pointVC.right = model.create_time;
    pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
    [self.navigationController pushViewController:pointVC animated:YES];
    
//      SKViewPointDetailViewController *pointVC = [[SKViewPointDetailViewController alloc] init];
//      pointVC.title = @"钱程策略";
//      pointVC.content = model.content;
//      pointVC.TXtitle = model.title;
//      pointVC.right = model.create_time;
//      pointVC.uid = [NSString stringWithFormat:@"%ld",(long)model.guandian_id];
//      [self.navigationController pushViewController:pointVC animated:YES];
}
- (void)infoChangeinfoChangeHeadertype:(NSInteger)type
{
    _currentInde = type;
    [self.mainTableView reloadData];
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

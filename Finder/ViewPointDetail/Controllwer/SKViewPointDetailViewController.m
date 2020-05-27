//
//  SKViewPointDetailViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKViewPointDetailViewController.h"
#import "SKpointTitleCell.h"
#import "SKViewPointReplyInfoCell.h"
#import "SKviewPointInfoModel.h"
#import "SKPointContentCell.h"
#import "SKPointContentWebTableViewCell.h"
#import "SKPointReplyView.h"
#import "SKCommitPointReplyView.h"
#import "SKPublicShareView.h"
@interface SKViewPointDetailViewController ()<UITableViewDelegate , UITableViewDataSource , SKPointReplyViewDelegate , SKCommitPointReplyViewDelegate>
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , weak)SKPointReplyView *replyView;
@property (nonatomic , weak)SKCommitPointReplyView *comitPointView;
@property (nonatomic , weak)SKPublicShareView *shareView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , strong)NSMutableArray *list;
@property (nonatomic , copy)NSString *htmlContent;

@property (nonatomic , assign)CGFloat height;

@end

@implementation SKViewPointDetailViewController
- (NSMutableArray *)datas
{
   if (!_datas) {
   _datas = [NSMutableArray new];
   }
   return _datas;
}
- (NSMutableArray *)list
{
     if (!_list) {
         _list = [NSMutableArray new];
     }
    return _list;
}
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (SKPublicShareView *)shareView
{
    if (!_shareView) {
        SKPublicShareView *view = [SKPublicShareView instanceSKPublicShareView];
        view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight); [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        _shareView = view;
    }
    return _shareView;
}
- (SKCommitPointReplyView *)comitPointView
{
    if (!_comitPointView) {
        SKCommitPointReplyView *View = [SKCommitPointReplyView instanceSKCommitPointReplyView];
        View.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
        View.vDelegate = self;
        [[[UIApplication sharedApplication] keyWindow] addSubview:View];
        _comitPointView = View;
    }
    return _comitPointView;
}
- (SKPointReplyView *)replyView
{
    if (!_replyView) {
        SKPointReplyView *view = [SKPointReplyView instanceSKPointReplyView];
        view.vDelegate = self;
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(0);
            make.height.equalTo(@(50));
        }];
        _replyView = view;
    }
    return _replyView;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight - 50) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.estimatedRowHeight = 60;
        tab.rowHeight = UITableViewAutomaticDimension;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerNib:[UINib nibWithNibName:@"SKpointTitleCell" bundle:nil] forCellReuseIdentifier:@"SKpointTitleCell"];//顶部cell
        [tab registerNib:[UINib nibWithNibName:@"SKViewPointReplyInfoCell" bundle:nil] forCellReuseIdentifier:@"SKViewPointReplyInfoCell"];
        [tab registerNib:[UINib nibWithNibName:@"SKPointContentCell" bundle:nil] forCellReuseIdentifier:@"SKPointContentCell"];// 内容
         [tab registerNib:[UINib nibWithNibName:@"SKPointContentWebTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKPointContentWebTableViewCell"];// 内容
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.tag == 1) {
        self.mainTableView.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight);
          [self configData];
    }else{
        [self getCommentList];
        [self replyView];
        [self getData];
        [self addRightBtn];
        [self getDetail];
    }
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)addRightBtn {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0,50, 35);
    but.titleLabel.font = kFont(14);
    [but setTitle:@"分享"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(ShareClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}

- (void)getDetail  {
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
        if(code == 0){
            self.htmlContent = [[JSON objectForKey:@"data"] objectForKey:@"content"];
            [self.mainTableView reloadData];
        }
    } andfail:^(NSError *error) {
        
    } path:@"info"];
}

- (void)getData
{
    WS(weakSelf);
    [SVCCommunityApi questionListWithNSDictionary:@{@"id":self.uid,@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
    if (code == 0) {
    NSDictionary *dict = [JSON objectForKey:@"data"];
    [weakSelf.list addObject:dict];
    }
    } andfail:^(NSError *error) {

    } path:@"share"];
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi AnnouncementinformationWithNSDictionary:@{@"id":self.uid} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            [weakSelf.sources addObject:[JSON objectForKey:@"data"]];
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
    } path:@"bult_info"];
}
- (void)getCommentList{
        WS(weakSelf);
        [SVCCommunityApi pointFocusNSDictionary:@{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
        NSArray *list = [JSON objectForKey:@"data"];
        for (NSDictionary *dict in list) {
        SKviewPointInfoModel *model = [SKviewPointInfoModel initWithDictionary:dict];
        [weakSelf.datas addObject:model];
        }
        [weakSelf.mainTableView reloadData];
        }else if (code == 400){
        [weakSelf logout];
        }
        } andfail:^(NSError *error) {

        } path:@"comment"];
}
- (void)logout{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [SKUserInfoModel deleteModel];
    [self presentViewController:nav animated:YES completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKpointTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKpointTitleCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        if (self.tag == 1) {
            if (self.sources.count >= 1) {
            NSString *time;
            if (self.right.length > 0) {
            time = self.right;
            }else{
            time = [self.sources[0] objectForKey:@"cre_time"];
            }
                [cell setPointTitleCell:[self.sources[0] objectForKey:@"title"] leftLab:@"钱程优顾" rightLab:time];
            }
        }else{
           [cell setPointTitleCell:self.TXtitle leftLab:@"钱程优顾" rightLab:self.right];
        }
        return cell;
    }else if(indexPath.row == 1){
//        SKPointContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPointContentCell" forIndexPath:indexPath];
        SKPointContentWebTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SKPointContentWebTableViewCell" forIndexPath:indexPath];
//        cell.selectionStyle = 0;
        cell1.selectionStyle = 0;
//        if (self.tag == 1) {
//            if (self.sources.count >= 1) {
//            [cell setcontentLabtext:[self flattenHTML:[self.sources[0] objectForKey:@"content"]]];
//            }
//        }else{
//            if (self.htmlContent) {
                [cell1 setDataWithHtmlString:self.htmlContent];
//            }
            return cell1;
//        }
//        return cell1;
    }else{
    SKViewPointReplyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKViewPointReplyInfoCell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    SKviewPointInfoModel *model = self.datas[indexPath.row - 2];
    cell.model = model;
    return cell;
    }
}
//过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }
    return html;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 200;
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
if (self.tag == 1) {
return 2;
}else{
return 2 + self.datas.count;
}
}
- (void)replayClick
{
    [self.comitPointView show];
}
- (void)commitReplycontent:(NSString *)text
{
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"content":text};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.comitPointView dissmiss];
        }
          [weakSelf.view toastShow:msg];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:@"comment_add"];
}
//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    self.comitPointView.Y -= height;
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
     self.comitPointView.Y += height;
}
- (void)ShareClick
{
   if (self.list.count > 0) {
     [self.shareView show:self.list[0]];
   }else{
   [self.view toastShow:@"未获取到分享信息"];
   }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

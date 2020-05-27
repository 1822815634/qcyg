//
//  SKPointDetailViewController.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/12.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKPointDetailViewController.h"
#import "SKPointDetailModel.h"
#import "SKPointDetailListModel.h"
#import "SKPointDetailListTableViewCell.h"
#import "SKPointReplyView.h"
#import "SKCommitPointReplyView.h"
#import "SKPublicShareView.h"
#import "SKUserCenterViewController.h"
@interface SKPointDetailViewController()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,SKPointReplyViewDelegate,SKCommitPointReplyViewDelegate> {
    UIView *headView;
    UILabel *titleLabel;
    UIImageView *iconImageView;
    UILabel *nameLabel;
    UILabel *timeLabel;
    UIButton *gzBtn;//关注
    UIWebView *webView;
    UIButton *zanBtn;//点赞
    UILabel *zanLabel;
}
@property (nonatomic , weak)SKPointReplyView *replyView;

@property (nonatomic , weak)SKCommitPointReplyView *comitPointView;

@property (nonatomic , weak)SKPublicShareView *shareView;

@property(nonatomic,strong)UITableView *tableView;//整个视图

@property (nonatomic , strong)SKPointDetailModel *topData;

@property (nonatomic , strong)SKPointDetailListModel *listData;

@property (nonatomic , strong)NSDictionary *shardDic;



@end

@implementation SKPointDetailViewController

- (SKPublicShareView *)shareView
{
    if (!_shareView) {
        SKPublicShareView *view = [SKPublicShareView instanceSKPublicShareView];
        view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight); [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        _shareView = view;
    }
    return _shareView;
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


- (UITableView *)tableView {
    if (_tableView == nil) {
        WS(weakSelf);
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(weakSelf.view);
//            make.width.mas_equalTo(kScreenWidth);
//            make.height.mas_equalTo(kScreenHeight-Knavheight-kSecrityHeight);
            make.bottom.mas_equalTo(weakSelf.view).offset(-50);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
    [self requestData];
    [self addRightBtn];
    [self getShareData];
    // Do any additional setup after loading the view.
}

- (void)getShareData {
    WS(weakSelf);
    [SVCCommunityApi questionListWithNSDictionary:@{@"id":self.uid,@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            self.shardDic = [JSON objectForKey:@"data"];
        }
    } andfail:^(NSError *error) {
        
    } path:@"share"];
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

- (void)makeUI {
    WS(weakSelf);
    headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headView;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.tableView);
        make.width.mas_equalTo(weakSelf.tableView);
    }];
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor hexStringToColor:@"333333"];
    titleLabel.numberOfLines = 0;
    titleLabel.preferredMaxLayoutWidth = kScreenWidth - 20;
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [headView addSubview:titleLabel];
    
    [titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(10);
        make.top.mas_equalTo(headView).offset(10);
        make.right.mas_equalTo(headView).offset(-10);
        
    }];
    
    iconImageView = [[UIImageView alloc]init];
    iconImageView.layer.cornerRadius = 25;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.userInteractionEnabled = YES;
    [headView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.width.height.mas_equalTo(50);
    }];
    
    UIControl *control = [[UIControl alloc]init];
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:control];
    
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(iconImageView);
    }];
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor hexStringToColor:@"999999"];
    nameLabel.font = [UIFont systemFontOfSize:12];
    [headView addSubview:nameLabel];
    
    [nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(iconImageView);
        make.height.mas_equalTo(25);
    }];
    
    timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor hexStringToColor:@"#999999"];
    timeLabel.font = [UIFont systemFontOfSize:10];
    [headView addSubview:timeLabel];
    
    [timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(iconImageView).offset(25);
        make.height.mas_equalTo(25);
    }];
    
    gzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gzBtn setBackgroundColor:KBlueColor];
    gzBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [gzBtn setTitle:@"+关注" forState:UIControlStateNormal];
    gzBtn.layer.cornerRadius = 15;
    gzBtn.layer.masksToBounds = YES;
    [gzBtn addTarget:self action:@selector(gzBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:gzBtn];
    
    [gzBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_right).offset(-80);
        make.centerY.mas_equalTo(iconImageView.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    webView = [[UIWebView alloc]init];
    webView.delegate = self;
    [headView addSubview:webView];

    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(10);
        make.right.mas_equalTo(headView).offset(-10);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(25);
    }];

    zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanBtn addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
    [headView addSubview:zanBtn];

    [zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_centerX).offset(-25);
        make.top.mas_equalTo(webView.mas_bottom).offset(30);
        make.height.width.mas_equalTo(50);
    }];

    zanLabel = [[UILabel alloc]init];
    zanLabel.textColor = [UIColor hexStringToColor:@"#999999"];
    zanLabel.font = [UIFont systemFontOfSize:10];
    zanLabel.text = @"给作者点个赞";
    zanLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:zanLabel];

    [zanLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView);
        make.top.mas_equalTo(zanBtn.mas_bottom).offset(5);
        make.right.mas_equalTo(headView);
        make.bottom.mas_equalTo(headView).offset(-20);
    }];
    
    [self replyView];
    
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

- (void)gzBtnClick:(UIButton *)btn {
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.topData.data.uid};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
            [self requestData];
        }
    } andfail:^(NSError *error) {
        
    } path:@"attention"];
}

- (void)zanBtnClick:(UIButton *)btn {
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.topData.data.guandian_id};
    [SVCCommunityApi giveZsumWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [self requestData];
        }
        [weakSelf.view toastShow:msg];
    } andfail:^(NSError *error) {
        
    }];
}

- (void)requestData {
    WS(weakSelf);
    //请求列表
    [SVCCommunityApi pointFocusNSDictionary:@{@"token":[SKUserInfoModel userToken],@"id":self.uid,@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            self.listData = [SKPointDetailListModel mj_objectWithKeyValues:JSON];
            [self.tableView reloadData];
        }else if (code == 400){

        }
    } andfail:^(NSError *error) {
        
    } path:@"comment"];
    //请求内容
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            self.topData = [SKPointDetailModel mj_objectWithKeyValues:JSON];
            [self upDateUI];
        }
    } andfail:^(NSError *error) {
        
    } path:@"info"];
}

- (void)upDateUI {
    titleLabel.text = self.topData.data.title;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,self.topData.data.u_img]]];
    nameLabel.text = self.topData.data.author;
    timeLabel.text = [self getOvertime:self.topData.data.create_time];
    [gzBtn setTitle:[self.topData.data.is_gz isEqualToString:@"1"]?@"取消关注":@"+关注" forState:UIControlStateNormal];
    [zanBtn setImage:[UIImage imageNamed:[self.topData.data.is_zan isEqualToString:@"0"]?@"zan1":@"zan2"] forState:UIControlStateNormal];
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:15px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",self.topData.data.content];
    [webView loadHTMLString:htmlString baseURL:nil];
}

- (NSString*)getOvertime:(NSString*)mStr{
    
    NSTimeInterval interval    =[mStr doubleValue];
    
    NSDate *date              = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *dateString      = [formatter stringFromDate: date];
    
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    
    return dateString;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //修改网页高度
    NSString *height_str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    //document.body.offsetHeight获取页面高度信息
    int temp = (int)height_str.integerValue + 10;
    [webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(temp);
    }];
    webView.scrollView.scrollEnabled = NO;  //禁止滚动
    //下面这部分很关键,重新布局 重新设置head
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
//    CGSize size = [self.tableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGRect headerFrame = self.tableView.frame;
//    headerFrame.size.height = size.height;
//    self.tableView.frame = headerFrame;
    self.tableView.tableHeaderView = headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 58;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 58)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    lineView.backgroundColor = TableViewBGColor;
    [view addSubview:lineView];
    UILabel *pjLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 8, kScreenWidth, 50)];
    pjLabel.font = [UIFont systemFontOfSize:16];
    pjLabel.textColor = [UIColor hexStringToColor:@"333333"];
    pjLabel.text = [NSString stringWithFormat:@"全部评论%@",self.topData.data.w_sum];
    [view addSubview:pjLabel];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"cell";
    SKPointDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[SKPointDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataWithModel:self.listData.data[indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    return view;
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
            [weakSelf requestData];
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
    if (self.shardDic) {
        [self.shareView show:self.shardDic];
    }else{
        [self.view toastShow:@"未获取到分享信息"];
    }
}

- (void)controlClick {
    SKUserCenterViewController *userVC = [[SKUserCenterViewController alloc] init];
    userVC.title = @"个人中心";
    userVC.uid = self.topData.data.uid;
    userVC.nickName = self.topData.data.author;
    userVC.imagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,self.topData.data.u_img];
    userVC.active = [self.topData.data.is_gz integerValue];
    [self.navigationController pushViewController:userVC animated:YES];
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

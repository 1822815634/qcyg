//
//  SKConsultViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//
#import "SKConsultViewController.h"
#import "SKUserCenterViewController.h"
#import "SKQuestionViewController.h"
#import "SKJianXuanViewController.h"
#import "BSWKwebViewController.h"
#import "SKGivingOpinionsViewController.h"
#import "SKAuthenticationViewController.h"
@interface SKConsultViewController ()<UIScrollViewDelegate> {
    NSString *_nickName;
}

@property (nonatomic , copy)NSString *headerImagellPath;
@property (nonatomic , strong)NSMutableArray *itemListArr;
@property (nonatomic , weak)UIScrollView *scrollerViewll;
@property (nonatomic , weak)UIScrollView *itemscrollView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic , strong)UIView *lineView;

//@property (nonatomic, strong)UIImageView *topImageView;
@end

@implementation SKConsultViewController
- (NSMutableArray *)itemListArr
{
    if (!_itemListArr) {
        _itemListArr = [NSMutableArray new];
    }
    return _itemListArr;
}
- (UIScrollView *)scrollerViewll
{
    if (!_scrollerViewll) {
        UIScrollView *scroviewll = [[UIScrollView alloc] init];
        scroviewll.showsHorizontalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        scroviewll.showsVerticalScrollIndicator = NO;
        scroviewll.bounces = NO;
        scroviewll.delegate = self;
        scroviewll.pagingEnabled = YES;
//        [self.view addSubview:scroviewll];
        [self.view insertSubview:scroviewll atIndex:0];
        [scroviewll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
            make.top.equalTo(self.view.mas_top).with.offset(164);
        }];
        _scrollerViewll = scroviewll;
    }
    return _scrollerViewll;
}
- (UIScrollView *)itemscrollView
{
    if (!_itemscrollView) {
        UIScrollView *scroviewll = [[UIScrollView alloc] init];
        scroviewll.backgroundColor = [UIColor whiteColor];
        scroviewll.showsHorizontalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        scroviewll.showsVerticalScrollIndicator = NO;
        scroviewll.bounces = NO;
        scroviewll.delegate = self;
        scroviewll.pagingEnabled = YES;
        [self.view addSubview:scroviewll];
        [scroviewll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.height.equalTo(@44);
            make.top.equalTo(self.view.mas_top).with.offset(120);
        }];
        _itemscrollView = scroviewll;
    }
    return _itemscrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KBlueColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 21]};
//    self.navigationItem.title = @"社区";
//    [self addRightBtn];
    [self addTopviewWithitemArr:@[@"精选",@"所有观点",@"问答中心"]];
    [self initWithScrollerView];
    [self initConstactButtton];
    [self requestBanner];
    [self requestUserInfo];
}

- (void)requestUserInfo {
    [SVCCommunityApi getUserNicknameNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            _nickName = [JSON objectForKey:@"nickname"];
        }
    } andfail:^(NSError *error) {
    
    }];
    
    WS(weakSelf);
    [SVCCommunityApi userInfoWithNSDictionary:@{@"token":[SKUserInfoModel userToken],@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        NSDictionary *dict = [JSON objectForKey:@"data"];
        if (code == 0) {
            self.headerImagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,[dict objectForKey:@"avatar"]];
//            [weakSelf.sources addObject:dict];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    }];
}

- (void)requestBanner {
    [SVCCommunityApi bannerWithDictionary:[NSDictionary dictionary] BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
//            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,JSON[@"data"][@"imgUrl"]]]];
        }
    } andfail:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}


- (void)initConstactButtton
{
    UIButton *constactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [constactBtn setImage:showImage(@"在线客服") forState:0];
    [self.view addSubview:constactBtn];
    [constactBtn addTarget:self action:@selector(constractUS) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    [constactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(- 13);
        make.height.width.equalTo(@(60));
    }];
    
}
- (void)constractUS
{
    BSWKwebViewController *constactVC = [[BSWKwebViewController alloc] init];
    constactVC.url = [[NSUserDefaults standardUserDefaults]objectForKey:@"kefu"];
    [self.navigationController pushViewController:constactVC animated:YES];
}
#pragma mark -->自定义导航栏
- (void)addTopviewWithitemArr:(NSArray *)arr{
    //添加顶部视图
    WS(weakSelf);
    UIView *topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    topBackView.backgroundColor = TableViewBGColor;
    [self.view addSubview:topBackView];

    UIView *siftBackView = [[UIView alloc]init];
    siftBackView.backgroundColor = [UIColor whiteColor];
    [topBackView addSubview:siftBackView];
    [siftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackView.mas_left).offset(0);
        make.right.equalTo(topBackView.mas_right).offset(0);
        make.top.equalTo(topBackView.mas_top).offset(0);
        make.height.equalTo(@(110));
    }];
    
    NSArray *titleArray = @[@"发布观点",@"投顾中心",@"我的关注",@"我要提问"];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Group%d",i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(kScreenWidth/4*i, 10, kScreenWidth/4, 56);
        btn.tag = i;
        [siftBackView addSubview:btn];
        [btn addTarget:self action:@selector(siftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4*i, btn.tx_bottom +5, kScreenWidth/4, 15)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor hexStringToColor:@"333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArray[i];
        [siftBackView addSubview:label];
    }
    
    __weak typeof(self) Weakself = self;
    CGFloat buttonWidth = kScreenWidth/arr.count;
    Weakself. itemscrollView.contentSize = CGSizeMake(buttonWidth * arr.count, 0);
    for (NSInteger i = 0; i < arr.count; i ++) {
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.backgroundColor = [UIColor whiteColor];
        topButton.tag = 1025 + i;
        [topButton addTarget:self action:@selector(topBtnDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [topButton setTitleColor:BlackbgColor forState:0];
        topButton.titleLabel.font =kFont(16);
        topButton.titleLabel.numberOfLines = 0;
        topButton.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 40);
        [Weakself.itemscrollView addSubview:topButton];
        [topButton setTitle:arr[i] forState:0];
        if (i == 0) {
            topButton.enabled = NO;
            [topButton setTitleColor:KBlueColor forState:0];
            self.selectedButton = topButton;
        }else{
        }
    }
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, 60, 3)];
    self.lineView.backgroundColor = KBlueColor;
    self.lineView.centerX = self.selectedButton.centerX;
    [self.itemscrollView addSubview:self.lineView];
}
- (void)addRightBtn {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60, 35);
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [but setTitle:@"发表观点"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}

- (void)siftBtnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0: {
            [self onClickedOKbtn];
        }
            break;
        case 1: {
            //投顾中心
            SKAuthenticationViewController *authenVC = [[SKAuthenticationViewController alloc] init];
            authenVC.title = @"投顾中心";
            authenVC.imagellPath = self.headerImagellPath;
            authenVC.nickName = _nickName;
            [self.navigationController pushViewController:authenVC animated:YES];
        }
            break;
        case 2: {
            //我的关注
            SKJianXuanViewController *VC = [[SKJianXuanViewController alloc] init];
            VC.uid = @"4";
            VC.title = @"我的关注";
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3: {
            //我要提问
            SKGivingOpinionsViewController *publicVC = [[SKGivingOpinionsViewController alloc] init];
            publicVC.title = @"提问";
            publicVC.tid = @"142";
            publicVC.type = 1;
            [self.navigationController pushViewController:publicVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark -->添加自控制器
- (void)initWithScrollerView
{
    for (NSInteger i = 0; i < 4; i ++) {
        if (i == 2) {
            SKQuestionViewController *questionVC = [[SKQuestionViewController alloc] init];
           [self addChildViewController:questionVC];
        }else{
            SKJianXuanViewController *VC = [[SKJianXuanViewController alloc] init];
            if (i == 0) {
                VC.uid = @"3";
            }else if(i == 1){
                VC.uid = @"1";
            }else{
                VC.uid = @"4";
            }
            [self addChildViewController:VC];
        }
    }
    self.scrollerViewll.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    [self scrollViewDidEndScrollingAnimation:self.scrollerViewll];
}

#pragma mark -->按钮的点击选择
- (void)topBtnDidSelected:(UIButton *)button
{
    [self.selectedButton setTitleColor:BlackbgColor forState:0];
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [button setTitleColor:KBlueColor forState:0];
    NSInteger index = button.tag - 1025;
    WS(weakSelf);
    [UIView animateWithDuration:0.15 animations:^{
        [weakSelf menuScrollViewContentOffsetHandleWithCenterX:button.centerX];
        [weakSelf.scrollerViewll setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
        weakSelf.lineView.centerX = weakSelf.selectedButton.centerX;
    } completion:^(BOOL finished) {
        
    }];
   
}
#pragma mark - 滚动视图偏移量的处理
- (void)menuScrollViewContentOffsetHandleWithCenterX:(CGFloat)centerX
{
    CGFloat xOffset = centerX - self.itemscrollView.frame.size.width/2;
    if (centerX < self.itemscrollView.frame.size.width/2)
    {
        xOffset = 0;
    }
    else if (centerX > self.itemscrollView.contentSize.width - self.itemscrollView.frame.size.width/2)
    {
        xOffset = self.itemscrollView.contentSize.width - self.itemscrollView.frame.size.width;
    }
    [self.itemscrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}
-(void)BtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollerViewll) {
        NSInteger index = scrollView.contentOffset.x / kScreenWidth;
        UIViewController *vc = self.childViewControllers[index];
        vc.view.X = scrollView.contentOffset.x;
        vc.view.Y = 0;
        vc.view.height = scrollView.height;
        [scrollView addSubview:vc.view];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollerViewll) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        // 点击按钮
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        UIButton *btn = [self.itemscrollView viewWithTag:1025 + index];
        [self topBtnDidSelected:btn];
    }
}
- (void)onClickedOKbtn
{
    if ([SKUserInfoModel userToken].length < 6) {
    [self.view toastShow:@"请先到我的界面去登录"];
    return;
    }
    SKGivingOpinionsViewController *publicVC = [[SKGivingOpinionsViewController alloc] init];
    publicVC.title = @"发表观点";
    [self.navigationController pushViewController:publicVC animated:YES];
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

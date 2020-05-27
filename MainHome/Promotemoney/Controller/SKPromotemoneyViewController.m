//
//  SKPromotemoneyViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPromotemoneyViewController.h"
#import "SKInvitationViewController.h"
#import "SKPromotemoneyErweimaCell.h"
@interface SKPromotemoneyViewController ()<UITableViewDelegate , UITableViewDataSource >
{
    NSString *_link;
    NSString *_imgurl;
}
@property (nonatomic , weak)UITableView *mainTableView;

@end

@implementation SKPromotemoneyViewController
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.estimatedRowHeight = 44;
        [self registerCell:@"SKPromotemoneyErweimaCell" withTab:tab];
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
    [self config];
    [self.mainTableView reloadData];
    // Do any additional setup after loading the view.
}
- (void)config{
    WS(weakSelf);
    [SVCCommunityApi expandmoneyWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            _link = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"link"]];
             _imgurl = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"imgurl"]];
            [weakSelf.mainTableView reloadData];
        }
    } andfail:^(NSError *error) {
        
    } path:@"expandmoney"];
}
- (void)addRightBtn {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60, 35);
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [but setTitle:@"我的邀请"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKPromotemoneyErweimaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPromotemoneyErweimaCell" forIndexPath:indexPath];
    [cell setlink:_link image:_imgurl];
    cell.selectionStyle = 0;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (void)onClickedOKbtn {
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

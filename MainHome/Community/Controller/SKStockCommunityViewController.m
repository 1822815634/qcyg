//
//  SKStockCommunityViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKStockCommunityViewController.h"
#import "SKBullraceheaderView.h"
#import "SKCommityCell.h"
@interface SKStockCommunityViewController ()<UITableViewDelegate , UITableViewDataSource ,SKBullraceheaderViewDelegate>
{
    NSInteger _currentIndex;
}
@property (nonatomic , weak)SKBullraceheaderView *headerView;
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKStockCommunityViewController
- (SKBullraceheaderView *)headerView
{
    if (!_headerView) {
        SKBullraceheaderView *view = [[SKBullraceheaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 44);
        view.vDelegate = self;
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight - Knavheight- 44) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.estimatedRowHeight = 44;
        [self registerCell:@"SKCommityCell" withTab:tab];
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
    [self.headerView setupView:_currentIndex titleArr:@[@"观点",@"在线问答"]];
    [self.mainTableView reloadData];
    // Do any additional setup after loading the view.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKCommityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKCommityCell" forIndexPath:indexPath];
//    [cell setcompanyName:self.datas[indexPath.row] Info:self.sources[indexPath.row]];
    cell.selectionStyle = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (void)SKBullraceheaderViewTypeViewClick:(NSInteger)tag
{
    _currentIndex = tag;
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

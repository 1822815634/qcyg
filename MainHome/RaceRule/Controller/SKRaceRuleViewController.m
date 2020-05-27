//
//  SKRaceRuleViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRaceRuleViewController.h"
#import "SKRuleContentCell.h"
#import "SKRuleInfoCell.h"
@interface SKRaceRuleViewController ()<UITableViewDelegate , UITableViewDataSource >
{
    NSString *_msg;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@property (nonatomic , strong)NSMutableArray *datas;
@end

@implementation SKRaceRuleViewController
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.estimatedRowHeight = 44;
        [self registerCell:@"SKRuleContentCell" withTab:tab];
        [self registerCell:@"SKRuleInfoCell" withTab:tab];
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
   self.datas = [NSMutableArray arrayWithObjects:@"第1名", @"第2名",@"第3名",@"第4名",@"第5名",@"第6名",nil];
    self.sources = [NSMutableArray arrayWithObjects:@"3000", @"2000",@"1000",@"800",@"500",@"200",nil];
    [self configData];
    // Do any additional setup after loading the view.
}
- (void)configData
{
    WS(weakSelf);
    [SVCCommunityApi TournamentWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            _msg = [[JSON objectForKey:@"data"] objectForKey:@"msg"];
        }
           [weakSelf.mainTableView reloadData];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:@"rule"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKRuleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRuleContentCell" forIndexPath:indexPath];
        [cell setContentLabtext:_msg];
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKRuleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRuleInfoCell" forIndexPath:indexPath];
        [cell setNumlab:self.datas[indexPath.row - 1] money:self.sources[indexPath.row - 1]];
        cell.selectionStyle = 0;
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sources.count + 1;
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

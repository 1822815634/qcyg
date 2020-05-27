//
//  SKAnnouncementmessageViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAnnouncementmessageViewController.h"
#import "SKViewPointDetailViewController.h"
#import "SKAnnounceMessageCell.h"
#import "SKAnnouncementmessageModel.h"
@interface SKAnnouncementmessageViewController ()<UITableViewDelegate , UITableViewDataSource >
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKAnnouncementmessageViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        tab.estimatedRowHeight = 80;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
        [tab registerNib:[UINib nibWithNibName:@"SKAnnounceMessageCell" bundle:nil] forCellReuseIdentifier:@"SKAnnounceMessageCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)configData{
    WS(weakSelf);
    [SVCCommunityApi AnnouncementinformationWithNSDictionary:@{@"timeformat":@"Y-m-d H:m:s"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.sources removeAllObjects];
            NSArray *list = [JSON objectForKey:@"data"];
            for (NSDictionary *dict in list) {
                SKAnnouncementmessageModel *model = [SKAnnouncementmessageModel initWithDictionary:dict];
                [weakSelf.sources addObject:model];
            }
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
    } path:@"bulletin"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   SKAnnounceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKAnnounceMessageCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
    SKAnnouncementmessageModel *model = self.sources[indexPath.row];
    cell.model = model;
        return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sources.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKViewPointDetailViewController *newsVC = [[SKViewPointDetailViewController alloc] init];
    SKAnnouncementmessageModel *model = self.sources[indexPath.row];
    newsVC.uid = model.but_id;
    newsVC.right = model.cre_time;
    newsVC.title = @"消息详情";
    newsVC.tag = 1;
    [self.navigationController pushViewController:newsVC animated:YES];
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

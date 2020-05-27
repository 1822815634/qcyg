//
//  SKIntegralruleViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKIntegralruleViewController.h"
#import "SKIntegralruleCell.h"
@interface SKIntegralruleViewController ()<UITableViewDelegate , UITableViewDataSource >
{
    NSString *_content;
}
@property (nonatomic , weak)UITableView *mainTableView;
@end

@implementation SKIntegralruleViewController
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
    tab.estimatedRowHeight = 66;
        tab.backgroundColor = [UIColor whiteColor];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confingData];
    // Do any additional setup after loading the view.
}
- (void)confingData
{
     WS(weakSelf);
     [SVCCommunityApi signInWithNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
    _content = [JSON objectForKey:@"content"];
     }
      [weakSelf.mainTableView reloadData];
     } andfail:^(NSError *error) {
     [weakSelf.view toastShow:netFailString];
     } path:@"IntegralRule"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = 0;
    cell.selectionStyle = 0;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = kFont(14);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
     cell.textLabel.text = _content;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

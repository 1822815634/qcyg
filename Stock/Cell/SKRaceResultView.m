//
//  SKRaceResultView.m
//  Stockallocation
//
//  Created by SoWhat on 2019/4/18.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKRaceResultView.h"
#import "SKResultCell.h"
#import "SKResultDetailInfoCell.h"
@interface SKRaceResultView ()<UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic , strong)NSMutableArray *datas;
@end

@implementation SKRaceResultView
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;                        _mainTable.showsVerticalScrollIndicator = NO;
    [self registerCell:@"SKResultCell" withTab:_mainTable];
    [self registerCell:@"SKResultDetailInfoCell" withTab:_mainTable];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;                        _mainTable.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKResultCell" withTab:_mainTable];
        [self registerCell:@"SKResultDetailInfoCell" withTab:_mainTable];
    }
    return self;
}
#pragma mark --> 注册cell
- (void)registerCell:(NSString *)cellName withTab:(UITableView *)tab
{
    [tab registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
}
+ (SKRaceResultView *)instanceSKRaceResultView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKRaceResultView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)setSources:(NSMutableArray *)sources
{
    _sources = sources;
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:sources];
    [_mainTable reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SKResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKResultCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKResultDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKResultDetailInfoCell" forIndexPath:indexPath];
        SKrankModel *model = self.datas[indexPath.row - 1];
        cell.model = model;
        cell.selectionStyle = 0;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            return 35;
        }else{
            return 46.0f;
        }
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count + 1;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

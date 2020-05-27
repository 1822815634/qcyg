//
//  SKSelectedCouponView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSelectedCouponView.h"

@interface SKSelectedCouponView ()<UITableViewDelegate , UITableViewDataSource>
{
NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic , strong)NSMutableArray *datas;
@end

@implementation SKSelectedCouponView
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
    [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;                        _mainTable.showsVerticalScrollIndicator = NO;
    }
    return self;
}
+ (SKSelectedCouponView *)instanceSKSelectedCouponView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKSelectedCouponView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)setSources:(NSMutableArray *)sources index:(NSInteger)index
{
_currentIndex = index;
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:sources];
    [_mainTable reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
if (indexPath.row == _currentIndex) {
cell.textLabel.textColor = KBlueColor;
}else{
cell.textLabel.textColor = [UIColor hexStringToColor:@"333333"];
}
    cell.selectionStyle = 0;
    if (indexPath.row < self.datas.count) {
        NSDictionary *dict = self.datas[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"使用%@元优惠券",[dict objectForKey:@"money"]];
    }else{
        cell.textLabel.text = @"不使用优惠券";
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count + 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(indexDidselected:)]) {
        [_vDelegate indexDidselected:indexPath.row];
    }
    [self removeFromSuperview];
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

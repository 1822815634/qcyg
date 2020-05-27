//
//  SKIntegralmallViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKIntegralmallViewController.h"
#import "SKExchangerecordsViewController.h"
#import "SKAddressViewController.h"
#import "SKIntegralruleViewController.h"
#import "SKGoodsInfoViewController.h"
#import "SKIntegralCouponCell.h"
#import "SKSmallintagraCollectionCell.h"
#import "SKfictitiousGoodsCell.h"
#import "SKrealityGoodsCell.h"
#import "SKIntegralTypeCell.h"
#import "SKrealityGoodsModel.h"
@interface SKIntegralmallViewController ()<UICollectionViewDelegate , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource ,SKSmallintagraCollectionCellDelegate, SKIntegralTypeCellDelegate , SKGoodsInfoViewControllerExchangeSuccessDelegate>
@property (nonatomic , weak) UICollectionView *mainCollectionView;
@property (nonatomic , strong)NSMutableArray *fictitiousSources;
@property (nonatomic , strong)NSMutableArray *realitySources;
@property (nonatomic , strong)NSMutableArray *ScoreSources;
@end

@implementation SKIntegralmallViewController
- (NSMutableArray *)ScoreSources
{
    if (!_ScoreSources) {
        _ScoreSources = [NSMutableArray new];
    }
    return _ScoreSources;
}
- (NSMutableArray *)fictitiousSources
{
    if (!_fictitiousSources) {
        _fictitiousSources = [NSMutableArray new];
    }
    return _fictitiousSources;
}
- (NSMutableArray *)realitySources
{
    if (!_realitySources) {
        _realitySources = [NSMutableArray new];
    }
    return _realitySources;
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        UICollectionView * View = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - Knavheight) collectionViewLayout:layout];
        View.backgroundColor = [UIColor whiteColor];
        View.showsVerticalScrollIndicator = NO;
         [self registerCell:@"SKfictitiousGoodsCell" withCollectionView:View];
         [self registerCell:@"SKrealityGoodsCell" withCollectionView:View];
        [self registerCell:@"SKIntegralCardCell" withCollectionView:View];
        [self registerCell:@"SKIntegralTypeCell" withCollectionView:View];
        [View registerClass:[SKIntegralCouponCell class] forCellWithReuseIdentifier:@"SKIntegralCouponCell"];
        [View registerClass:[SKSmallintagraCollectionCell class] forCellWithReuseIdentifier:@"SKSmallintagraCollectionCell"];
        View.delegate = self;
        View.dataSource = self;
        [self.view addSubview:View];
        _mainCollectionView = View;
    }
    return _mainCollectionView;
}
#pragma mark --> 注册cell
- (void)registerCell:(NSString *)cellName withCollectionView:(UICollectionView *)colletion
{
     [colletion registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:cellName];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self addRightBtn];
    // Do any additional setup after loading the view.
}
- (void)addRightBtn {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60, 35);
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [but setTitle:@"我的商城"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(onClickedOKbtn)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (void)configData{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    [self request1:group type:@"1"];
      [self request1:group type:@"2"];
    [self request2:group];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.mainCollectionView reloadData];
    });
}
- (void)request1:(dispatch_group_t)group type:(NSString *)type
{
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"type":type};
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi GoodsListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        NSArray *list = [JSON objectForKey:@"data"];
        if (code == 0) {
            if ([type isEqualToString:@"1"]) {
                [weakSelf.fictitiousSources removeAllObjects];
            }else{
                [weakSelf.realitySources removeAllObjects];
            }
            for (NSDictionary *dict in list) {
                SKrealityGoodsModel *model = [SKrealityGoodsModel initWithDictionary:dict];
                if ([type isEqualToString:@"1"]) {
                    [weakSelf.fictitiousSources addObject:model];
                }else{
                    [weakSelf.realitySources addObject:model];
                }
            }
            
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
         dispatch_group_leave(group);
    } path:@"getGoodsList"];
}
- (void)request2:(dispatch_group_t)group
{
    WS(weakSelf);
    dispatch_group_enter(group);
    [SVCCommunityApi signInWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.ScoreSources removeAllObjects];
            [weakSelf.ScoreSources addObject:JSON];
        }
         dispatch_group_leave(group);
    } andfail:^(NSError *error) {
        dispatch_group_leave(group);
    } path:@"info"];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        SKSmallintagraCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKSmallintagraCollectionCell" forIndexPath:indexPath];
        cell.vDelegate = self;
        if (self.ScoreSources.count > 0) {
            NSDictionary *dict = self.ScoreSources[0];
[cell setupSignLab:[NSString stringWithFormat:@"已连续签到：%@ 天",[dict objectForKey:@"checkin_num"]] Num:[dict objectForKey:@"integral"]];
        }
        
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 3){
        SKIntegralTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKIntegralTypeCell" forIndexPath:indexPath];
        [cell initWithType:indexPath.section realArray:self.realitySources moniArray:self.fictitiousSources];
        cell.vDelegate = self;
        return cell;
    }else if(indexPath.section == 2){
        SKfictitiousGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKfictitiousGoodsCell" forIndexPath:indexPath];
        SKrealityGoodsModel *model = self.realitySources[indexPath.row];
        cell.model = model;
        return cell;
    }else{
        SKrealityGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKrealityGoodsCell" forIndexPath:indexPath];
        SKrealityGoodsModel *model = self.fictitiousSources[indexPath.row];
        cell.model = model;
        return cell;
    }
}
#pragma mark -->  每个section 中有多少个items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) {
        return self.fictitiousSources.count;
    }else if (section == 4){
        return self.realitySources.count;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kScreenWidth,220);
            break;
        case 2:
            return CGSizeMake((kScreenWidth  - 10)/2,86);
            break;
        case 1:
        case 3:
            return CGSizeMake(kScreenWidth, 50);
            break;
        default:
            return CGSizeMake((kScreenWidth  - 30)/2, 240);
            break;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    if ( section == 4) {
         return UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    }else{
         return UIEdgeInsetsMake(2.0f, 0.0f, 2.0f, 0.0f);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0.01f,0.01f);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
      return CGSizeMake(0.01f,0.01f);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        SKrealityGoodsModel *model = self.realitySources[indexPath.row];
          [self IntergralTypeMoreDelegate:indexPath.section uid:model.uid];
    }else if (indexPath.section == 4){
        SKrealityGoodsModel *model = self.fictitiousSources[indexPath.row];
        [self IntergralTypeMoreDelegate:indexPath.section uid:model.uid];
    }else{
        
    }
}
#pragma mark --> 查看商品
- (void)IntergralTypeMoreDelegate:(NSInteger)tag uid:(NSString *)uid
{
    SKGoodsInfoViewController *goodsVC = [[SKGoodsInfoViewController alloc] init];
    goodsVC.title = @"商品详情";
    if(tag == 2){
        goodsVC.InActionType = Integralfictitions;
    }else{
        goodsVC.InActionType = Integralreality;
    }
    goodsVC.uid = uid;
    goodsVC.vDelegate = self;
      [self.navigationController pushViewController:goodsVC animated:YES];
}
#pragma mark --> 积分规则
- (void)Integralrule
{
    SKIntegralruleViewController *IntegralruleVC = [[SKIntegralruleViewController alloc] init];
    IntegralruleVC.title = @"积分规则";
    [self.navigationController pushViewController:IntegralruleVC animated:YES];
}
- (void)onClickedOKbtn
{
    WS(weakSelf);
  UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"兑换记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf changeHistory];
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"收货地址" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf addAddress];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma mark --> 兑换记录
- (void)changeHistory{
    SKExchangerecordsViewController *ExchangerecordsVC = [[SKExchangerecordsViewController alloc] init];
    ExchangerecordsVC.title = @"兑换记录";
    [self.navigationController pushViewController:ExchangerecordsVC animated:YES];
}
#pragma mark --> 添加地址
- (void)addAddress
{
    SKAddressViewController *addressVC = [[SKAddressViewController alloc] init];
    addressVC.title = @"收货地址";
    [self.navigationController pushViewController:addressVC animated:YES];
}
- (void)SKSmallintagraCollectionRuleDidClick:(NSInteger)tag
{
    if (tag == 9) {
        [self Integralrule];
    }else{
        [self signIn];
    }
}

- (void)signIn{
    WS(weakSelf);
    [SVCCommunityApi signInWithNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
//        if (code == 0) {
            [weakSelf.view toastShow:msg];
//        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:@"signin"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)IntergralTypeMoreDelegate:(NSInteger)tag
{
    
}
- (void)changeSuccessful
{
    [self configData];
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

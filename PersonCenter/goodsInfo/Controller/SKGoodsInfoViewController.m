//
//  SKGoodsInfoViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKGoodsInfoViewController.h"
#import "SKgoodsInfoView.h"
#import "SKgoodsRuledetailView.h"
@interface SKGoodsInfoViewController ()<SKgoodsRuledetailViewDelegate>

@property (nonatomic , weak)SKgoodsInfoView *infoView;

@property (nonatomic , weak)SKgoodsRuledetailView *reluView;

@property (nonatomic , strong)NSMutableArray *sources;

@end

@implementation SKGoodsInfoViewController
- (NSMutableArray *)sources
{
    if (!_sources) {
        _sources = [NSMutableArray new];
    }
    return _sources;
}
- (SKgoodsInfoView *)infoView
{
    if (!_infoView) {
        SKgoodsInfoView *view = [SKgoodsInfoView initWithinstancetype];
        view.frame = CGRectMake(0, 0, kScreenWidth, 200);
        [self.view addSubview:view];
        _infoView = view;
    }
    return _infoView;
}
- (SKgoodsRuledetailView *)reluView
{
    if (!_reluView) {
        SKgoodsRuledetailView *view = [SKgoodsRuledetailView initWithinstancetype];
        view.frame = CGRectMake(0, 144, kScreenWidth, 350);
        view.vDelegate = self;
        [self.view addSubview:view];
        _reluView = view;
    }
    return _reluView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    if (self.InActionType == Integralfictitions) {
//        [self.reluView initWithSKgoodsRuleView:1];
//    }else{
        [self.reluView initWithSKgoodsRuleView:0];
//    }
    [self infoView];
   
    // Do any additional setup after loading the view.
}
- (void)config{
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.uid};
    [SVCCommunityApi GoodsListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSDictionary *dict = [JSON objectForKey:@"data"];
            [weakSelf.sources addObject:dict];
            [weakSelf.infoView initWithSKgoodsInfoView:dict];
        }
    } andfail:^(NSError *error) {
        
    } path:@"detail"];
}
- (void)exchangeClick
{
    WS(weakSelf);
    if (self.sources.count > 0) {
        NSDictionary *uid = [self.sources[0] objectForKey:@"id"];
        NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":uid};
        [SVCCommunityApi GoodsListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                if (_vDelegate && [_vDelegate respondsToSelector:@selector(changeSuccessful)]) {
                    [_vDelegate changeSuccessful];
                }
            }
            [weakSelf.view toastShow:[[JSON objectForKey:@"data"] objectForKey:@"msg"]];
        } andfail:^(NSError *error) {
            
        } path:@"exchange"];
    }
   
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

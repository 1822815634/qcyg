//
//  SKAddBankCradTwoViewController.m
//  Stockallocation
//
//  Created by xumin on 2019/3/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAddBankCradTwoViewController.h"
#import "SKSeleceModelView.h"
#import "SKRelaNamecertificationViewController.h"
@interface SKAddBankCradTwoViewController ()<UITextFieldDelegate> {
    NSString *_stutueString;
    NSDictionary *nameDict;
}
/** 真实姓名 */
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
/** 银行卡号 */
@property (weak, nonatomic) IBOutlet UITextField *bankCradNumTF;
/** 开户银行 */
@property (weak, nonatomic) IBOutlet UITextField *openBankNameTF;
/** 支行 */
@property (weak, nonatomic) IBOutlet UITextField *subbranchTF;
/** 所在省 */
@property (weak, nonatomic) IBOutlet UITextField *provinceTF;
/** 城市 */
@property (weak, nonatomic) IBOutlet UITextField *CityTF;

/** 银行列表 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/** 省份列表 */
@property (nonatomic,strong) NSMutableArray *dataPrvArray;
/** 城市列表 */
@property (nonatomic,strong) NSMutableArray *dataCityArray;
/** 灰色背景 */
@property (nonatomic,strong) UIView *bgView;
/** 银行弹出视图 */
@property (nonatomic,strong) SKSeleceModelView *modelViewBank;
/** 省份弹出视图 */
@property (nonatomic,strong) SKSeleceModelView *modelViewPrv;
/** 城市弹出视图 */
@property (nonatomic,strong) SKSeleceModelView *modelViewCity;

@property (nonatomic,copy) NSString *BankID;
@property (nonatomic,copy) NSString *prvinceID;

@property (nonatomic,copy) NSString *CityID;

@property (weak, nonatomic) IBOutlet UIButton *completeButton;

@end

@implementation SKAddBankCradTwoViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)dataPrvArray{
    if (!_dataPrvArray) {
        _dataPrvArray = [[NSMutableArray alloc]init];
    }
    return _dataPrvArray;
}
-(NSMutableArray *)dataCityArray{
    if (!_dataCityArray) {
        _dataCityArray = [[NSMutableArray alloc]init];
    }
    return _dataCityArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setMainUI];
    [self getBankList];
    [self getPrvinceData];
    [self addgesture];
}

- (void)addgesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.realNameLabel addGestureRecognizer:tap];
}

- (void)tap {
    //去实名认证
        SKRelaNamecertificationViewController *RelaNameVC = [[SKRelaNamecertificationViewController alloc] init];
        RelaNameVC.name_Type = RelaName;
        RelaNameVC.title = @"实名认证";
        [self.navigationController pushViewController:RelaNameVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRealState];
}

- (void)getRealState {
    [SVCCommunityApi commitRelaNicknameNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            nameDict = [JSON objectForKey:@"data"];
            _stutueString = [NSString stringWithFormat:@"%@",[nameDict objectForKey:@"status"]];
            if ([_stutueString isEqualToString:@"2"]) {
                self.realNameLabel.text = [NSString stringWithFormat:@"%@",[nameDict objectForKey:@"realname"]];
                self.realNameLabel.userInteractionEnabled = NO;
            } else {
                NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"您尚未实名认证 马上认证"];
                [attributeStr addAttribute:NSForegroundColorAttributeName
                                     value:KBlueColor
                                     range:NSMakeRange(8, 4)];
                self.realNameLabel.attributedText = attributeStr;
                self.realNameLabel.userInteractionEnabled = YES;
            }
        }
    } andfail:^(NSError *error) {
        
    } path:@"getreal"];
}


-(void)setMainUI{
    self.openBankNameTF.delegate = self;
    self.provinceTF.delegate = self;
    self.CityTF.delegate = self;
    self.completeButton.layer.cornerRadius = 5.0;
    self.completeButton.layer.masksToBounds = YES;
}

-(void)getBankList{
    NSDictionary *param = @{@"token":[SKUserInfoModel userToken]};
    [SVCCommunityApi XMgetBankListWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [self.dataArray addObject:[JSON objectForKey:@"data"]];
        }
    } andfail:^(NSError *error) {
        NSLog(@"请求银行列表失败%@",error);
    }];
}
-(void)getPrvinceData{
    NSDictionary *param = @{@"token":[SKUserInfoModel userToken]};
    [SVCCommunityApi XMgetPrvinceListWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [self.dataPrvArray addObject:[JSON objectForKey:@"data"]];
        }
    } andfail:^(NSError *error) {
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    if (textField.tag == 1000) {
        [self selectBank];
    }else if (textField.tag == 1001){
        [self selectPrvince];
    }else if (textField.tag == 1002){
        if (self.provinceTF.text.length ==0 || self.provinceTF.text == nil) {
            [self.view toastShow:@"请选择省份"];
            return 0;
        }
        [self SelectCity];
    }
    return NO;
}

-(void)selectBank{
    UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.6;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    SKSeleceModelView *view = [[SKSeleceModelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.dataArray = self.dataArray;
    view.modelType = @"bank";
    WS(weakSelf);
    [view setCellClickIndexPath:^(NSString *ResultStr, NSString *bankID) {
        weakSelf.openBankNameTF.text = ResultStr;
        weakSelf.BankID = bankID;
        [weakSelf bgViewClick];
    }];
    self.modelViewBank = view;
}

-(void)selectPrvince{
    UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.6;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    SKSeleceModelView *view = [[SKSeleceModelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.dataPrvArray = self.dataPrvArray;
    view.modelType = @"prv";
    WS(weakSelf);
    [view setCellPrvClickIndexPath:^(NSString *ResultStr, NSString *prvID) {
        weakSelf.provinceTF.text = ResultStr;
        weakSelf.prvinceID = prvID;
        [weakSelf getCityDataWithID:prvID];
        [weakSelf bgViewClick];
    }];
    self.modelViewPrv = view;
}
-(void)getCityDataWithID:(NSString *)prvID{
    NSDictionary *param = @{@"token":[SKUserInfoModel userToken],@"id":prvID};
    [SVCCommunityApi XMgetCityListWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [self.dataCityArray addObject:[JSON objectForKey:@"data"]];
        }
    } andfail:^(NSError *error) {

    }];
}
-(void)SelectCity{
    UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.6;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    SKSeleceModelView *view = [[SKSeleceModelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.dataCityArray = self.dataCityArray;
    view.modelType = @"city";
    WS(weakSelf);
    [view setCellCityClickIndexPath:^(NSString *ResultStr, NSString *CityID) {
        weakSelf.CityTF.text = ResultStr;
        weakSelf.CityID = CityID;
        [weakSelf bgViewClick];
    }];
    self.modelViewCity = view;
}
-(void)bgViewClick{
    [self.bgView removeFromSuperview];
    [self.modelViewBank removeFromSuperview];
    [self.modelViewPrv removeFromSuperview];
    [self.modelViewCity removeFromSuperview];
    [self.openBankNameTF resignFirstResponder];
    [self.provinceTF resignFirstResponder];
    [self.CityTF resignFirstResponder];
}

- (IBAction)completeButtonClick:(UIButton *)sender {
    
    if (![_stutueString isEqualToString:@"2"]) {
        [self.view toastShow:@"请先实名认证"];
        return;
    }
    if (self.bankCradNumTF.text == nil ||self.bankCradNumTF.text.length == 0) {
        [self.view toastShow:@"请输入卡号"];
        return;
    }
    if (self.openBankNameTF.text == nil ||self.openBankNameTF.text.length == 0) {
        [self.view toastShow:@"请选择开户银行"];
        return;
    }
    if (self.subbranchTF.text == nil ||self.subbranchTF.text.length == 0) {
        [self.view toastShow:@"请输入支行名称"];
        return;
    }
    if (self.provinceTF.text == nil ||self.provinceTF.text.length == 0) {
        [self.view toastShow:@"请选择省份"];
        return;
    }
    if (self.CityTF.text == nil ||self.CityTF.text.length == 0) {
        [self.view toastShow:@"请选择城市"];
        return;
    }
    NSDictionary *param = @{@"token":[SKUserInfoModel userToken],@"bankid":self.BankID,@"bankcode":self.bankCradNumTF.text,@"bankcode2":self.bankCradNumTF.text,@"bankaddress":self.subbranchTF.text,@"provinceid":self.prvinceID,@"cityid":self.CityID};
    [SVCCommunityApi XMgetAddBankCradWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [self.view toastShow:msg];
        }else{
            [self.view toastShow:msg];
        }
    } andfail:^(NSError *error) {
        NSLog(@"添加银行卡请求失败");
    }];
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

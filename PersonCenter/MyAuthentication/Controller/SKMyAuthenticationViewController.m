//
//  SKMyAuthenticationViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMyAuthenticationViewController.h"
#import "SKSexSelectedCell.h"
#import "SKMyAuthenTypeSelectedCell.h"
#import "SKSelectAccountView.h"
#import "SKMyAuthenInfoCell.h"
@interface SKMyAuthenticationViewController ()<UITableViewDelegate , UITableViewDataSource ,SKMyAuthenInfoCellDelegate , SKSexSelectedCellDelegate>

{
    NSString *_relaName;//真实姓名
     NSString *_Professionalscope;//专业范围
    BOOL _role;//角色
     NSString *_ID;//身份证id
     NSString *_mobile;//手机号
     NSString *_email;//email
     NSString *_Qualificatione;//资格证书
     NSString *_Post;//所在岗位
     NSString *_Certificatenumber;//证书号码
     NSString *_actualoperation;//从业年限
     NSString *_Company;//所在公司
     NSString *_DepartmentofBusiness;//所在营业部
}

@property (nonatomic , weak)UITableView *mainTableView;

@property (nonatomic , weak)UIButton *commitBtn;

@property (nonatomic , strong)NSMutableDictionary *sources;

@property (nonatomic , strong)NSMutableDictionary *datas;

@property (nonatomic , strong)NSMutableDictionary *list;


@property (nonatomic,strong) SKSelectAccountView *SelectView;

@property (nonatomic,strong) UIView *bgView;

@end

@implementation SKMyAuthenticationViewController
- (NSMutableDictionary *)sources
{
    if (!_sources) {
        _sources = [NSMutableDictionary new];
    }
    return _sources;
}
- (NSMutableDictionary *)datas
{
    if (!_datas) {
        _datas = [NSMutableDictionary new];
    }
    return _datas;
}
- (NSMutableDictionary *)list
{
    if (!_list) {
        _list = [NSMutableDictionary new];
    }
    return _list;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
    UITableViewController* tvc=[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self addChildViewController:tvc];
        [tvc.view setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 45)];
      UITableView *tab = tvc.tableView;
        tab.delegate = self;
        tab.dataSource = self;
        tab.rowHeight = 50;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [tab registerNib:[UINib nibWithNibName:@"SKMyAuthenInfoCell" bundle:nil] forCellReuseIdentifier:@"SKMyAuthenInfoCell"];
         [tab registerNib:[UINib nibWithNibName:@"SKSexSelectedCell" bundle:nil] forCellReuseIdentifier:@"SKSexSelectedCell"];
     [tab registerNib:[UINib nibWithNibName:@"SKMyAuthenTypeSelectedCell" bundle:nil] forCellReuseIdentifier:@"SKMyAuthenTypeSelectedCell"];
        [self.view addSubview:tab];
        _mainTableView = tab;
    }
    return _mainTableView;
}
- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定申请" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font =kFont(15);
        button.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
        [button addTarget:self action:@selector(commitApply) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.view).offset(0);
            make.height.equalTo(@(45));
        }];
        _commitBtn = button;
    }
    return _commitBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mainTableView reloadData];
    _role = YES;
    _Qualificatione = @"";
    _Post = @"";
    _Certificatenumber = @"";
    _actualoperation = @"";
    _Company = @"";
    _DepartmentofBusiness = @"";
    [self commitBtn];
}


- (void)config{
        [SVCCommunityApi questionListWithNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {

        }
        } andfail:^(NSError *error) {

        } path:@"adviser"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        SKSexSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKSexSelectedCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.Vdelegate = self;
        [cell initSexType:_role];
        return cell;
    }else{
        if (indexPath.section == 0) {
        SKMyAuthenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyAuthenInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.Vdelegate = self;
            [self setCellTF:indexPath dict:self.sources cell:cell];
            switch (indexPath.row) {
                case 0:
                    [cell initMyAuthenInfoType:@"* 真实姓名" palceString:@"请输入真实姓名" index:indexPath];
                    break;
                case 1:
                    [cell initMyAuthenInfoType:@"  专业范围" palceString:@"请输入专业范围" index:indexPath];
                    break;
                case 3:
                    [cell initMyAuthenInfoType:@"* 身份证号" palceString:@"请输入身份证号" index:indexPath];
                    break;
                case 4:
                    [cell initMyAuthenInfoType:@"* 手机号码" palceString:@"请输入手机号码" index:indexPath];
                    break;
                case 5:
                    [cell initMyAuthenInfoType:@"* 电子邮箱" palceString:@"请输入电子邮箱" index:indexPath];
                    break;
                default:
                    break;
            }
        return cell;
        }else if (indexPath.section == 1){
        if (indexPath.row == 2) {
        SKMyAuthenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyAuthenInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.Vdelegate = self;
         [self setCellTF:indexPath dict:self.datas cell:cell];
         [cell initMyAuthenInfoType:@"  证书号码" palceString:@"请输入证书号码" index:indexPath];
        return cell;
        }else{
        SKMyAuthenTypeSelectedCell *typeCell = [tableView dequeueReusableCellWithIdentifier:@"SKMyAuthenTypeSelectedCell" forIndexPath:indexPath];
            switch (indexPath.row) {
                case 0:
                [typeCell setTypeLabelText:@"  资格证书" content:_Qualificatione index:indexPath];
                    break;
                case 1:
                 [typeCell setTypeLabelText:@"  所在岗位" content:_Post index:indexPath];
                    break;
                case 3:
                 [typeCell setTypeLabelText:@"  从业年限" content:_actualoperation index:indexPath];
                    break;
                default:
                    break;
            }
        return typeCell;
        }
        }else{
        SKMyAuthenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMyAuthenInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.Vdelegate = self;
             [self setCellTF:indexPath dict:self.list cell:cell];
            switch (indexPath.row) {
                case 0:
                    [cell initMyAuthenInfoType:@"  所在公司" palceString:@"请输入所在公司" index:indexPath];
                    break;
                case 1:
                    [cell initMyAuthenInfoType:@"  所在营业部" palceString:@"请输入所在营业部" index:indexPath];
                    break;
                default:
                    break;
            }
        return cell;
        }
    }
}
- (void)setCellTF:(NSIndexPath *)indexPath dict:(NSMutableDictionary *)dict cell:(SKMyAuthenInfoCell *)cell
{
    NSArray *indexArr = [dict allKeys];
    if ([indexArr containsObject:@(indexPath.row)]) {
        cell.contentTF.text = [dict objectForKey:@(indexPath.row)];
    }else{
        cell.contentTF.text = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 4;
    }else{
        return 2;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }else{
        return 15.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 15.0f;
    }else{
        return 0.01f;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
    switch (indexPath.row) {
        case 0:
        [self selectAccountButtonClick:[self.userInfoDict objectForKey:@"zgzs"] index:indexPath.row];
        break;
        case 1:
        [self selectAccountButtonClick:[self.userInfoDict objectForKey:@"szgw"] index:indexPath.row];
        break;
        case 3:
        [self selectAccountButtonClick:[self.userInfoDict objectForKey:@"cynx"] index:indexPath.row];
        break;
        default:
        break;
    }
    }
}
- (void)changeRoleType:(BOOL)ret
{
    _role = ret;
    [self.mainTableView reloadData];
}
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.sources setObject:text forKey:@(indexPath.row)];
        switch (indexPath.row) {
            case 0:
                _relaName = text;
                break;
            case 1:
                _Professionalscope = text;
                break;
            case 3:
                _ID = text;
                break;
            case 4:
                _mobile = text;
                break;
            case 5:
                _email = text;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        [self.datas setObject:text forKey:@(indexPath.row)];
    _Certificatenumber = text;
    }else{
        [self.list setObject:text forKey:@(indexPath.row)];
        switch (indexPath.row) {
            case 0:
                _Company = text;
                break;
            case 1:
                _DepartmentofBusiness = text;
                break;
            default:
                break;
        }
    }
}
- (void)commitApply
{
    if (_relaName.length < 1 || _ID.length < 1 || _mobile.length < 1 || _email.length < 1 ) {
        [self.view toastShow:@"带 * 的内容是必填项"];
    }else{
        NSString *roleType = _role?@"1":@"2";
        NSDictionary *params = @{@"sex":roleType,@"realName":_relaName,@"token":[SKUserInfoModel userToken],@"cartId":_ID,@"tel":_mobile,@"email":_email,@"zyzg":_Qualificatione,@"szgw":_Post,@"zghm":_Certificatenumber,@"cynx":_actualoperation,@"company":_Company,@"department":_DepartmentofBusiness};
        WS(weakSelf);
        [SVCCommunityApi questionListWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            [weakSelf.view toastShow:msg];
        } andfail:^(NSError *error) {
            
        } path:@"applyAdviser"];
    }
}
-(void)selectAccountButtonClick:(NSArray *)list index:(NSInteger )index{
      UIView *bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
      bgView.backgroundColor = [UIColor grayColor];
      bgView.alpha = 0.6;
      self.bgView = bgView;
      [[UIApplication sharedApplication].keyWindow addSubview:bgView];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
      bgView.userInteractionEnabled = YES;
      [bgView addGestureRecognizer:tap];

      SKSelectAccountView *view = [[SKSelectAccountView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 250)];
      [[UIApplication sharedApplication].keyWindow addSubview:view];
      view.center = [UIApplication sharedApplication].keyWindow.center;
      view.dataArray = list;
      WS(weakSelf);
      [view setCellClickIndexPath:^(NSString *StockAccount,NSInteger tag) {
      if(index == 0){
      _Qualificatione = StockAccount;
      }else if (index == 1){
      _Post = StockAccount;
      }else{
      _actualoperation = StockAccount;
      }
      [weakSelf.mainTableView reloadData];
      [weakSelf bgViewClick];
      }];
      self.SelectView = view;
}

-(void)bgViewClick{
    [self.bgView removeFromSuperview];
    [self.SelectView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

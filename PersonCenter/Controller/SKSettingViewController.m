//
//  SKSettingViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKSettingViewController.h"
#import "SVCTabBarController.h"
#import "SKAboutUSViewController.h"
#import "SKSettingNickNameViewController.h"
#import "SKAuthenticationViewController.h"
#import "SKSetPresentationpasswordViewController.h"
#import "SKRelaNamecertificationViewController.h"
#import "SKLoginViewController.h"
#import "SKPersonImagellCell.h"
#import "SKPersonInfoTypeCell.h"
#import "SKoutLoginCell.h"
#import "SKMainFootView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "SKGestureViewController.h"
#import "SKChangePhoneViewController.h"
@interface SKSettingViewController ()<UITableViewDelegate , UITableViewDataSource , SKoutLogoutCellClickViewDelegate , SKSettingNickNameSuccessfulDelegate , SKPersonImagellCellDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , SettingSuccessfulDelegate>
{
    NSString *_nickName;
     NSString *_stutueString;
}
@property (nonatomic , weak)UITableView *mainTableView;
@property (nonatomic , strong)NSMutableArray *sources;
@end

@implementation SKSettingViewController
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
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Knavheight) style:UITableViewStyleGrouped];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;                        tab.showsVerticalScrollIndicator = NO;
        [self registerCell:@"SKPersonImagellCell" withTab:tab];
        [self registerCell:@"SKPersonInfoTypeCell" withTab:tab];
        [tab registerClass:[SKoutLoginCell class] forCellReuseIdentifier:@"SKoutLoginCell"];
        [tab registerClass:[SKMainFootView class] forHeaderFooterViewReuseIdentifier:@"SKMainFootView"];
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
    [self.mainTableView reloadData];
    [self config];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.mainTableView reloadData];
}

- (void)config{
     WS(weakSelf);
     dispatch_group_t group = dispatch_group_create();
     [self getName:group];
     [self getrealStatues:group];
     dispatch_group_notify(group, dispatch_get_main_queue(), ^{
     [weakSelf.mainTableView reloadData];
     });
}
- (void)getName:(dispatch_group_t)group{
     WS(weakSelf);
 dispatch_group_enter(group);
     [SVCCommunityApi getUserNicknameNSDictionary:nil BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
     _nickName = [JSON objectForKey:@"nickname"];
     [weakSelf.mainTableView reloadData];
     }
     dispatch_group_leave(group);
     } andfail:^(NSError *error) {
      dispatch_group_leave(group);
     }];
}
- (void)getrealStatues:(dispatch_group_t)group
{
    dispatch_group_enter(group);
      [SVCCommunityApi commitRelaNicknameNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
      if (code == 0) {
      NSDictionary *dict = [JSON objectForKey:@"data"];
      _stutueString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
      
      }
      dispatch_group_leave(group);
      } andfail:^(NSError *error) {
        dispatch_group_leave(group);
      } path:@"getreal"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            SKPersonImagellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonImagellCell" forIndexPath:indexPath];
            cell.headImagellPath = self.headerImagellPath;
            cell.selectionStyle = 0;
            cell.vDelegate = self;
            return cell;
        }else{
            SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
            if (indexPath.row == 2) {
                [cell setTypeLab:@"设置昵称" des:_nickName];
            }else if(indexPath.row == 1){
                 [cell setTypeLab:@"投顾中心" des:@""];
            }else{
                [cell setTypeLab:@"实名认证" des:_stutueString];
            }
            cell.selectionStyle = 0;
            return cell;
        }
    }else if(indexPath.section == 1){
        SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTypeLab:@"登录密码" des:@"修改"];
        }else if(indexPath.row == 1){
            [cell setTypeLab:@"支付密码" des:@"修改"];
        }else if(indexPath.row == 2){
//            [cell setTypeLab:@"提现密码" des:@"修改"];
            [cell setTypeLab:@"手势密码" des:[[NSUserDefaults standardUserDefaults]boolForKey:GestureTag]?@"已启用":@"未启用"];
        } else if (indexPath.row ==3) {
            [cell setTypeLab:@"更改手机号" des:@"修改"];
        }
        cell.selectionStyle = 0;
        return cell;
    }else if(indexPath.section == 2){
        SKPersonInfoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKPersonInfoTypeCell" forIndexPath:indexPath];
        [cell setTypeLab:@"关于" des:@"版本号1.0.0"];
        cell.selectionStyle = 0;
        return cell;
    }else{
        SKoutLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKoutLoginCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.vDelegate = self;
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        SKMainFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SKMainFootView"];
        [footView setupFootView];
        return footView;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 1) {
        return 4;
    }else if (section == 0){
        return 4;
    }
    else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f;
    }else{
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return kScreenHeight - Knavheight - 40 - 70 - 45 * 7;
    }
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        SKAboutUSViewController *aboutVC = [[SKAboutUSViewController alloc] init];
        aboutVC.title = @"关于";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else if (indexPath.section == 0){
        if (indexPath.row == 2) {
            SKSettingNickNameViewController *setNicknameVC = [[SKSettingNickNameViewController alloc] init];
            setNicknameVC.vDelegate = self;
            setNicknameVC.title = @"设置昵称";
            [self.navigationController pushViewController:setNicknameVC animated:YES];
        }else if (indexPath.row == 3){
            [self relaNameVCWithtype:31];
        }else if (indexPath.row == 1){
            SKAuthenticationViewController *authenVC = [[SKAuthenticationViewController alloc] init];
            authenVC.title = @"投顾中心";
            authenVC.imagellPath = self.headerImagellPath;
            authenVC.nickName = _nickName;
            [self.navigationController pushViewController:authenVC animated:YES];
        }
        else{
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 3) {
            //更改手机号
            SKChangePhoneViewController *change = [SKChangePhoneViewController new];
            change.title = @"验证原手机号";
            [self.navigationController pushViewController:change animated:YES];
        } else if (indexPath.row == 2) {
//            SKSetPresentationpasswordViewController *setVC = [[SKSetPresentationpasswordViewController alloc] init];
//            setVC.title = @"设置提现密码";
//            [self.navigationController pushViewController:setVC animated:YES];
            //手势密码页面
            SKGestureViewController *sk = [SKGestureViewController new];
            sk.title = @"手势密码";
            [self.navigationController pushViewController:sk animated:YES];
            
        }else if (indexPath.row == 1){
            [self relaNameVCWithtype:32];
        }else{
            [self relaNameVCWithtype:33];
        }
    }
    else{
        
    }
}
#pragma mark --> 实名认证
- (void)relaNameVCWithtype:(NSInteger)type
{
    SKRelaNamecertificationViewController *RelaNameVC = [[SKRelaNamecertificationViewController alloc] init];
   RelaNameVC.Vdelegate = self;
    if (type == 31) {
        RelaNameVC.name_Type = RelaName;
    }else if(type == 32){
        RelaNameVC.name_Type = Relapassword;
    }else{
        RelaNameVC.name_Type = loginPwd;
    }
     RelaNameVC.title = @"钱程优顾";
    [self.navigationController pushViewController:RelaNameVC animated:YES];
}
- (void)setSuccessful
{
    [self config];
}
- (void)SKoutLogoutCellClick
{
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"您确定要退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不，我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {

        }];
        WS(weakSelf);
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf logout];
        }];

        [alertVc addAction:cancle];
        [alertVc addAction:camera];
        [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma mark --> 跳转tab
- (void)logout{
     [SKUserInfoModel deleteModel];
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:GestureWord];
     [[NSUserDefaults standardUserDefaults]setBool:NO forKey:GestureTag];
     [self.navigationController popToRootViewControllerAnimated:YES];
      SVCTabBarController *tabbar = [[SVCTabBarController alloc] init];
      UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
      keyWindow.rootViewController = tabbar;
      tabbar.selectedIndex = 0;
}
- (void)setNicknameSuccessful:(NSString *)nickName
{
    _nickName = nickName;
    [self.mainTableView reloadData];
}
#pragma mark --> 判断相机相机权限
- (BOOL)canOpenCammer
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}
#pragma mark --> 判断用户是否有相册权限
- (BOOL)canOpenLibary
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}
#pragma mark --> 打开相机或者相册
- (void)SKPersoninagellChange
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    WS(weakSelf);
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([weakSelf canOpenCammer]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [weakSelf presentViewController:imagePicker animated:YES completion:nil];
        }else{
            [weakSelf.view toastShow:@"请前往设置打开相机权限"];
        }
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([weakSelf canOpenLibary]) {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [weakSelf presentViewController:pickerImage animated:YES completion:nil];
        }else{
             [weakSelf.view toastShow:@"请前往设置打开相册权限"];
        }
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma mark -->  选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([type isEqualToString:@"public.image"])
        {
            UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [picker dismissViewControllerAnimated:YES completion:nil];
            [WSProgressHUD showWithStatus:@"图片正在上传中..."];
            NSString *encodedImageStr = [[self resetSizeOfImageData:image maxSize:50] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [self uploadImagell:encodedImageStr];
            
        }
    });
}
- (void)uploadImagell:(NSString *)imageName
{
    WS(weakSelf);
    NSDictionary *param = @{@"token":[SKUserInfoModel userToken],@"file":[NSString stringWithFormat:@"data:image/jpg;base64,%@",imageName]};
    [SVCCommunityApi SetImageWithNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            weakSelf.headerImagellPath = [NSString stringWithFormat:@"%@%@",ServerPath,[[JSON objectForKey:@"data"] objectForKey:@"imgurl"]];
            [weakSelf.mainTableView reloadData];
             [weakSelf.view toastShow:msg];
            if (weakSelf.vDelegate && [weakSelf.vDelegate respondsToSelector:@selector(updateHeaderImagell)]) {
                [_vDelegate updateHeaderImagell];
            }
        }
        [WSProgressHUD dismiss];
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
          [WSProgressHUD dismiss];
    }];
}
// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 图片压缩
- (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
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

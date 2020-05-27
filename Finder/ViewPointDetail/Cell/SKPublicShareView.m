//
//  SKPublicShareView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKPublicShareView.h"
#import <ShareSDK/ShareSDK.h>
@interface SKPublicShareView ()
{
NSDictionary *_params;
}
@end
@implementation SKPublicShareView

+ (SKPublicShareView *)instanceSKPublicShareView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKPublicShareView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)show:(NSDictionary *)dict
{
    _params = dict;
}
- (void)diss
{
    [self removeFromSuperview];
}
- (IBAction)typeChangeClick:(UIButton *)sender {
    if (sender.tag == 51) {
        [self sharePlatform:SSDKPlatformSubTypeWechatTimeline];
    }else if (sender.tag == 52){
        [self sharePlatform:SSDKPlatformSubTypeWechatSession];
    }else if (sender.tag == 53){
        [self sharePlatform:SSDKPlatformSubTypeQQFriend];
    }else{
        [self sharePlatform:SSDKPlatformSubTypeQZone];
    }
    
}
- (void)sharePlatform:(SSDKPlatformType)type
{
NSArray* imageArray = @[[_params objectForKey:@"img"]];
NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
if (imageArray) {
[shareParams SSDKSetupShareParamsByText:[_params objectForKey:@"content"] images:imageArray url:[NSURL URLWithString:[_params objectForKey:@"url"]] title:[_params objectForKey:@"title"] type:SSDKContentTypeAuto];
 }
WS(weakSelf);
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
     [weakSelf removeFromSuperview];
        switch (state) {
            case SSDKResponseStateSuccess:
            [weakSelf toastShow:@"分享成功"];
                break;
            case SSDKResponseStateFail:
                 [weakSelf toastShow:@"分享失败"];
                break;
            default:
                break;
        }
    }];
}
- (IBAction)dissClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end

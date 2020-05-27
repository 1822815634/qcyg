//
//  SKViewPointDetailViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//
/**
 消息详情与观点详情页面(观点详情页面另写为SKPointDetailViewController)
 */
#import "SKBaseViewController.h"

@interface SKViewPointDetailViewController : SKBaseViewController

@property (nonatomic , copy)NSString *content;//内容

@property (nonatomic , copy)NSString *TXtitle;//标题

@property (nonatomic , copy)NSString *right;//时间

@property (nonatomic , copy)NSString *uid;

@property (nonatomic , assign)NSInteger tag; //1为消息详情 其他为观点详情

@end

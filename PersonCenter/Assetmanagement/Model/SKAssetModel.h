//
//  SKAssetModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKAssetModel : SKBaseModel

@property (nonatomic , copy)NSString *asset;

@property (nonatomic , assign)CGFloat freeze;

@property (nonatomic , copy)NSString *balance;

@property (nonatomic , copy)NSString *net_asset;

@property (nonatomic , copy)NSString *frozen_amt;

@property (nonatomic , copy)NSString *order_amt;

@property (nonatomic , copy)NSString *deposit;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end

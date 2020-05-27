//
//  SKAssetmentSumCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/27.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKAssetmentSumCelltixianClickViewDelegate <NSObject>

-(void)tixianClick;

@end

@class SKAssetModel;

@interface SKAssetmentSumCell : UITableViewCell

@property (nonatomic , strong)SKAssetModel *model;

@property (weak ,nonatomic) id<SKAssetmentSumCelltixianClickViewDelegate> vDelegate;

@end

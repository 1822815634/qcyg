//
//  SKRankingInfoTableViewCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKrankModel;
@class SKLastAwardModel;
@interface SKRankingInfoTableViewCell : UITableViewCell

- (void)setupViewWithrankModel:(SKrankModel *)model index:(NSIndexPath *)index;

- (void)setupViewWithlastAardModel:(SKLastAwardModel *)model index:(NSIndexPath *)index;

@end

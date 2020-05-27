//
//  SKTransactionCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTradeHistoryModel;

@interface SKTransactionCell : UITableViewCell

- (void)setTransactionWithTag:(NSInteger)tag model:(SKTradeHistoryModel *)model;

@end

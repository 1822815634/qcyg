//
//  SKMyawardInfoCell.h
//  Stockallocation
//
//  Created by SoWhat on 2019/4/15.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKLastAwardModel ;

@protocol SKMyawardInfoCellDelegate <NSObject>

-(void)awardredemption:(NSInteger)tag;

@end

@interface SKMyawardInfoCell : UITableViewCell

- (void)setModel:(SKLastAwardModel *)model index:(NSInteger)index;

@property (weak ,nonatomic) id<SKMyawardInfoCellDelegate> vDelegate;

@end

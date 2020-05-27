//
//  SKSQestionInfoCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/26.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKQuestionModel;
@protocol SKSQestionInfoCellDelegate <NSObject>

-(void)questionSKClick:(NSIndexPath *)index;

@end

@interface SKSQestionInfoCell : UITableViewCell

@property (nonatomic ,  strong)SKQuestionModel *model;

- (void)setType:(NSString *)type index:(NSIndexPath *)indx;

@property (weak ,nonatomic) id<SKSQestionInfoCellDelegate> vDelegate;


@end

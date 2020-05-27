//
//  SKchicangCell.h
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKchicangCellSellorBuyClickViewDelegate <NSObject>

-(void)SellOrBuyType:(NSInteger)type index:(NSInteger)index;

@end


@class SKshareTypeModel;

@interface SKchicangCell : UITableViewCell

- (void)setShareTypeModel:(SKshareTypeModel *)model index:(NSInteger )index;

@property (weak ,nonatomic) id<SKchicangCellSellorBuyClickViewDelegate> vDelegate;

@end

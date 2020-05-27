//
//  SKJingXuanCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/4.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKviewPointModel;

@protocol SKJingXuanCellClickViewDelegate <NSObject>

- (void)reoprtBtnClick;

-(void)poinViewtouchEndClick:(NSIndexPath *)index;

- (void)userimagellTouchClick:(NSIndexPath *)index;

- (void)zanOrreplyClickWithTag:(NSInteger )tag index:(NSInteger)index;

@end


@interface SKJingXuanCell : UITableViewCell

- (void)setviewPointModel:(SKviewPointModel *)model index:(NSIndexPath *)index type:(NSInteger)type;

@property (weak ,nonatomic) id<SKJingXuanCellClickViewDelegate> vDelegate;

@end

//
//  SKMainTypeTableViewCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKMainTypeTableViewCellDelegate <NSObject>

-(void)SKMainTypeTableViewCellTypeClickDelegate:(NSInteger)tag;

@end

@interface SKMainTypeTableViewCell : UITableViewCell

- (void)initWithSKMaintypeView:(NSArray *)imagePathList;

@property (weak ,nonatomic) id<SKMainTypeTableViewCellDelegate> vDelegate;

@end

//
//  SKMegagameCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKMegagameCellDelegate <NSObject>

-(void)SKMegagameCellJoinClickDelegate;

@end

@interface SKMegagameCell : UITableViewCell

@property (weak ,nonatomic) id<SKMegagameCellDelegate> vDelegate;

- (void)setUpViewWithDic:(NSDictionary *)dict;

@end

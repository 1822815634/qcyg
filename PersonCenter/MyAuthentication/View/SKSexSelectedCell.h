//
//  SKSexSelectedCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSexSelectedCellDelegate <NSObject>

- (void)changeRoleType:(BOOL)ret;

@end

@interface SKSexSelectedCell : UITableViewCell

- (void)initSexType:(BOOL)type;

@property (weak, nonatomic) id<SKSexSelectedCellDelegate> Vdelegate;

@end

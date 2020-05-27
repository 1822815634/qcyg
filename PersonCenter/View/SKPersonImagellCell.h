//
//  SKPersonImagellCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKPersonImagellCellDelegate <NSObject>

-(void)SKPersoninagellChange;

@end

@interface SKPersonImagellCell : UITableViewCell

@property (nonatomic , copy)NSString *headImagellPath;

@property (weak ,nonatomic) id<SKPersonImagellCellDelegate> vDelegate;

@end

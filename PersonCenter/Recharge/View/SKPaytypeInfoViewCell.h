//
//  SKPaytypeInfoViewCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKPaytypeInfoViewCell : UITableViewCell

- (void)setupViewType:(NSInteger)type countName:(NSString *)countName conutType:(NSString *)countType countInfo:(NSString *)countInfo imagPath:(NSString *)path;

@end

//
//  SKAnalogdiskHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/15.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKAnalogdiskHeaderView : UITableViewHeaderFooterView

- (void)setupViewwithassets:(NSString *)assets market:(NSString *)market balance:(NSString *)balance earnings:(NSString *)earnings dayearnings:(NSString *)dayearnings weekearnings:(NSString *)weekearnings;

@end

//
//  SKCashNumCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCashNumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *countNumTF;

- (void)initBalanceLab:(NSString *)balance;

@end

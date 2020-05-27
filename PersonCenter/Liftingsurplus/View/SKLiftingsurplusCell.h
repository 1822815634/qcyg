//
//  SKLiftingsurplusCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKLiftingsurplusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *acountTF;

@property (nonatomic,copy) void(^selectButtonClick)(void);
/** 股票账户数字 */
@property (nonatomic,copy) NSString *accountNum;

@property (nonatomic , copy)NSString *banlance;

@end

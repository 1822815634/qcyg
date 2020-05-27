//
//  SKBankInfoCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKBankCardmoveClickViewDelegate <NSObject>

-(void)SKbankCardmoveClick;

@end

@interface SKBankInfoCell : UITableViewCell

- (void)setBankInfoWithDict:(NSDictionary *)dict;

@property (weak ,nonatomic) id<SKBankCardmoveClickViewDelegate> vDelegate;

@end

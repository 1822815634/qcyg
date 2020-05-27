//
//  SKanalogdiskPurchaseCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/16.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKanalogdiskPurchaseCellDelegate <NSObject>

-(void)SKanalogdiskPurchaseCellClick:(NSString *)shareNum type:(NSString *)type;

- (void)changevalue:(NSString *)price count:(NSString *)count;

- (void)changAmountClickType:(NSInteger)tape;

@end

@interface SKanalogdiskPurchaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *priceTF;

@property (weak, nonatomic) IBOutlet UITextField *NumTF;

- (void)setupBussinessButtonType:(NSInteger)type code:(NSString *)code price:(NSString *)price countNum:(NSString *)countNum;

@property (weak ,nonatomic) id<SKanalogdiskPurchaseCellDelegate> vDelegate;

@end

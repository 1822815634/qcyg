//
//  SKJuniorcowCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/8.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKJuniorcowCellClickViewDelegate <NSObject>

-(void)SKJuniorcowCellchangTypeClick:(NSInteger)type;

-(void)countTFValuechangTypeClick:(NSString *)text type:(NSString *)type;

-(void)typeButtonchangTypeClick:(NSInteger)type senderTag:(NSInteger)senderTag;

@end

@interface SKJuniorcowCell : UITableViewCell


- (void)changeType:(NSInteger)type buttonType:(NSInteger)buttonType scale:(NSInteger)scale yushu:(CGFloat)yushu currentIndx:(NSInteger)index balance:(NSString *)balance;

@property (weak ,nonatomic) id<SKJuniorcowCellClickViewDelegate> vDelegate;

@end

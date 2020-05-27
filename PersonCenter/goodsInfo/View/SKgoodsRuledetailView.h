//
//  SKgoodsRuledetailView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKgoodsRuledetailViewDelegate <NSObject>

-(void)exchangeClick;

@end

@interface SKgoodsRuledetailView : UIView

+ (SKgoodsRuledetailView *)initWithinstancetype;

- (void)initWithSKgoodsRuleView:(NSInteger)num;

@property (weak ,nonatomic) id<SKgoodsRuledetailViewDelegate> vDelegate;

@end

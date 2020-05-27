//
//  SKAgreetRiskstatementView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/6/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKAgreetRiskstatementViewDelegate <NSObject>

-(void)aggretRisk;

@end

@interface SKAgreetRiskstatementView : UIView

+ (SKAgreetRiskstatementView *)instanceSKAgreetRiskstatementView;

@property (weak ,nonatomic) id<SKAgreetRiskstatementViewDelegate> vDelegate;

@end

NS_ASSUME_NONNULL_END

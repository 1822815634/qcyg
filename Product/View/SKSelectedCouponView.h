//
//  SKSelectedCouponView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSelectedCouponViewDelegate <NSObject>

-(void)indexDidselected:(NSInteger)type;

@end

@interface SKSelectedCouponView : UIView

+ (SKSelectedCouponView *)instanceSKSelectedCouponView;

- (void)setSources:(NSMutableArray *)sources index:(NSInteger )index;

@property (weak ,nonatomic) id<SKSelectedCouponViewDelegate> vDelegate;


@end

//
//  SKselectedMonthView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKselectedMonthViewDelegate <NSObject>

-(void)changeMonth:(NSInteger)month;

@end

@interface SKselectedMonthView : UIView

+ (SKselectedMonthView *)instanceSKselectedMonthView;

- (void)show:(NSInteger)month;

@property (weak ,nonatomic) id<SKselectedMonthViewDelegate> vDelegate;

@end

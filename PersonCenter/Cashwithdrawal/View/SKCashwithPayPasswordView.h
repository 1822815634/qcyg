//
//  SKCashwithPayPasswordView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/2/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKCashwithPayPasswordViewDelegate <NSObject>

-(void)getpassWord:(NSString *)password;

@end

@interface SKCashwithPayPasswordView : UIView

+ (SKCashwithPayPasswordView *)instanceSKPasswordView;

- (void)show;

@property (weak ,nonatomic) id<SKCashwithPayPasswordViewDelegate> vDelegate;

@end

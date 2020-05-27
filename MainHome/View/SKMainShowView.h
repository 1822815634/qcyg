//
//  SKMainShowView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/6/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKMainShowViewRegisterAndloginDelegate <NSObject>

-(void)registerAndLogin:(NSInteger)tag;

@end

@interface SKMainShowView : UIView


+ (SKMainShowView *)instanceSKMainShowView;

@property (weak ,nonatomic) id<SKMainShowViewRegisterAndloginDelegate> vDelegate;

@end

NS_ASSUME_NONNULL_END

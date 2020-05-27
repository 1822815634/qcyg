//
//  SKPublicShareView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKPublicShareView : UIView

+ (SKPublicShareView *)instanceSKPublicShareView;

- (void)show:(NSDictionary *)dict;

- (void)diss;

@end

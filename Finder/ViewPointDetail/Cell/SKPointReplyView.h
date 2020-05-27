//
//  SKPointReplyView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKPointReplyViewDelegate <NSObject>

-(void)replayClick;

@end

@interface SKPointReplyView : UIView

+ (SKPointReplyView *)instanceSKPointReplyView;

@property (weak ,nonatomic) id<SKPointReplyViewDelegate> vDelegate;

@end

//
//  SKCommitPointReplyView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKCommitPointReplyViewDelegate <NSObject>

-(void)commitReplycontent:(NSString *)text;

@end

@interface SKCommitPointReplyView : UIView

+ (SKCommitPointReplyView *)instanceSKCommitPointReplyView;

@property (weak ,nonatomic) id<SKCommitPointReplyViewDelegate> vDelegate;

- (void)show;

- (void)dissmiss;

@end

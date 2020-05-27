//
//  SKBullraceheaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKBullraceheaderViewDelegate <NSObject>

-(void)SKBullraceheaderViewTypeViewClick:(NSInteger)tag;

@end

@interface SKBullraceheaderView : UIView

- (void)setupView:(NSInteger )seleType titleArr:(NSArray *)titleArr;

@property (weak ,nonatomic) id<SKBullraceheaderViewDelegate> vDelegate;

@end

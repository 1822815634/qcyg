//
//  SKOperaHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/15.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKOperaHeaderViewTypeViewDelegate <NSObject>

-(void)SKOperaHeaderViewTypeViewClick:(NSInteger)tag;

@end

@interface SKOperaHeaderView : UIView

- (void)setupView:(NSInteger )seleType titleArr:(NSArray *)titleArr;

@property (weak ,nonatomic) id<SKOperaHeaderViewTypeViewDelegate> vDelegate;

@property (nonatomic, assign)NSInteger selectedIndex;


@end

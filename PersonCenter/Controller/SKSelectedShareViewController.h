//
//  SKSelectedShareViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/20.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseViewController.h"
@protocol SKshareSelectedViewDelegate<NSObject>

-(void)SKshareSelectedViewTypeClickWithcode:(NSString *)code gid:(NSString *)gid amount:(NSString *)amount type:(NSString *)type;

@end
@interface SKSelectedShareViewController : SKBaseViewController

/**
 股票代码
 */
@property (nonatomic , copy)NSString *code;

/**
 1 股票卖出进入
 
 */
@property (nonatomic , assign)NSInteger type;

@property(nonatomic , weak) id <SKshareSelectedViewDelegate>Vdelegate;

@end

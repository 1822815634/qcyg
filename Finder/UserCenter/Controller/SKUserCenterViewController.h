//
//  SKUserCenterViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//
/**投顾个人中心*/

typedef void (^block) (void);
#import "SKBaseViewController.h"

@interface SKUserCenterViewController : SKBaseViewController

@property (nonatomic , copy)NSString *uid;

@property (nonatomic , copy)NSString *nickName;

@property (nonatomic , copy)NSString *imagellPath;

@property (nonatomic , assign)NSInteger active;//是否关注

//关注or取关修改上个页面的关注状态
@property (nonatomic , copy)block block;

@end

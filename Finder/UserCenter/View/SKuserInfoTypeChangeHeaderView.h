//
//  SKuserInfoTypeChangeHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SKuserInfoTypeChangeHeaderViewDelegate <NSObject>

-(void)infoChangeinfoChangeHeadertype:(NSInteger)type;

@end

@interface SKuserInfoTypeChangeHeaderView : UITableViewHeaderFooterView

- (void)infoTypeChangeHeaderView:(NSInteger)index title:(NSArray *)title;

@property (weak ,nonatomic) id<SKuserInfoTypeChangeHeaderViewDelegate> vDelegate;

@end

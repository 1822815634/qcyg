//
//  SKBannerHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKBannerHeaderViewDidselectedDelegate <NSObject>

-(void)SKBannerHeaderViewDidselectedAtindex:(NSInteger)tag;

@end

@interface SKBannerHeaderView : UITableViewHeaderFooterView

- (void)setupViewWithimageList:(NSArray *)list txString:(NSString *)tx;

@property (weak ,nonatomic) id<SKBannerHeaderViewDidselectedDelegate> vDelegate;

@end

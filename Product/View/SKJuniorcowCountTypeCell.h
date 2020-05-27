//
//  SKJuniorcowCountTypeCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/8.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKJuniorcowCountTypeCell : UITableViewCell

- (void)setupViewWithtitle:(NSDictionary *)title content:(NSString *)content type:(NSInteger)type index:(NSIndexPath *)index;

- (void)setupViewWithTX:(NSString *)title content:(NSString *)content type:(NSInteger)type;

@end

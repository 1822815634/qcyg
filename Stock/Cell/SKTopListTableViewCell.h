//
//  SKTopListTableViewCell.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/20.
//  Copyright © 2019年 SoWhat. All rights reserved.
//
/**首页榜单*/
#import <UIKit/UIKit.h>
#import "SKrankModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SKTopListTableViewCell : UITableViewCell

- (void)setDataWithNum:(NSString *)num headImage:(NSString *)image Name:(NSString *)name earn:(NSString *)earn;

- (void)setDataWithModel:(SKrankModel *)model Section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

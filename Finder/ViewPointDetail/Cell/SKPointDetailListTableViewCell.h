//
//  SKPointDetailListTableViewCell.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKPointDetailListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SKPointDetailListTableViewCell : UITableViewCell

@property (nonatomic , strong)UIImageView *iconImageView;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *contentLabel;

- (void)setDataWithModel:(SKPointDetailListModelResponse *)data;



@end

NS_ASSUME_NONNULL_END

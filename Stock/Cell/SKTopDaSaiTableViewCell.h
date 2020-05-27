//
//  SKTopDaSaiTableViewCell.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/20.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKStockModel;
NS_ASSUME_NONNULL_BEGIN

@protocol SKTopDaSaiTableViewCellViewDelegate <NSObject>

-(void)SKBullracewCellTypeViewClick:(NSInteger)tag;
@end

@interface SKTopDaSaiTableViewCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UIButton *outGameBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentMyRaceLabel;

@property (weak ,nonatomic) id<SKTopDaSaiTableViewCellViewDelegate> vDelegate;

- (void)setupBullraceCellWithmodel:(SKStockModel *)model ;


@end

NS_ASSUME_NONNULL_END

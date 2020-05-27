//
//  SKquestionAndAswerCell.h
//  Stockallocation
//
//  Created by SoWhat on 2019/1/21.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKQuestionModel;

@protocol SKquestionAndAswerCellDelegate <NSObject>

-(void)touchHeaderImagellClick:(NSInteger )tag;

@end


@interface SKquestionAndAswerCell : UITableViewCell

@property (nonatomic ,  strong)SKQuestionModel *model;

@property (weak ,nonatomic) id<SKquestionAndAswerCellDelegate> vDelegate;

@property (nonatomic , assign)NSInteger index;
@end

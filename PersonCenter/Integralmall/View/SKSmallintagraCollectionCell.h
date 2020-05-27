//
//  SKSmallintagraCollectionCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/24.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSmallintagraCollectionCellDelegate <NSObject>

-(void)SKSmallintagraCollectionRuleDidClick:(NSInteger)tag;

@end

@interface SKSmallintagraCollectionCell : UICollectionViewCell

- (void)setupSignLab:(NSString *)sign Num:(NSString *)signNum;

@property (weak ,nonatomic) id<SKSmallintagraCollectionCellDelegate> vDelegate;

@end

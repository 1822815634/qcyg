//
//  SKIntegralTypeCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SKIntegralTypeCellDelegate <NSObject>

-(void)IntergralTypeMoreDelegate:(NSInteger)tag;

@end

@interface SKIntegralTypeCell : UICollectionViewCell

- (void)initWithType:(NSInteger)tag realArray:(NSMutableArray *)array moniArray:(NSMutableArray *)otherArray;

@property (weak ,nonatomic) id<SKIntegralTypeCellDelegate> vDelegate;

@end

//
//  SKrechargeNumCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKrechargeNumCellAcountValuechangeViewDelegate <NSObject>

-(void)AcountValuechange:(NSString *)acount index:(NSInteger )index;

@end

@interface SKrechargeNumCell : UITableViewCell

- (void)setupViewWithType:(NSString *)type placeString:(NSString *)pla type:(NSInteger)textType index:(NSInteger)tag;
@property (weak, nonatomic) IBOutlet UITextField *AcountTF;

@property (weak ,nonatomic) id<SKrechargeNumCellAcountValuechangeViewDelegate> vDelegate;

@end

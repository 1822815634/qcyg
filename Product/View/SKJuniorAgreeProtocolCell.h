//
//  SKJuniorAgreeProtocolCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKJuniorAgreeProtocolCellDelegate <NSObject>

-(void)selectedbButtonType:(NSInteger)type;

@end

@interface SKJuniorAgreeProtocolCell : UITableViewCell

- (void)changeCommitBtntitle:(NSInteger)tag ret:(BOOL)ret;

@property (weak ,nonatomic) id<SKJuniorAgreeProtocolCellDelegate> vDelegate;

@end

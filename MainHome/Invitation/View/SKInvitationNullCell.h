//
//  SKInvitationNullCell.h
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKInvitationNullCellDelegate <NSObject>

-(void)SKInvitationNullCellClick;

@end

@interface SKInvitationNullCell : UITableViewCell

@property (weak ,nonatomic) id<SKInvitationNullCellDelegate> vDelegate;
@end

//
//  SKapplyInfoNodataCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKapplyInfoNodataCelldidClickViewDelegate <NSObject>

-(void)SKapplyInfoNodataCellClick;

@end

@interface SKapplyInfoNodataCell : UITableViewCell

@property (weak ,nonatomic) id<SKapplyInfoNodataCelldidClickViewDelegate> vDelegate;

@end

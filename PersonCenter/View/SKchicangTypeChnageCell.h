//
//  SKchicangTypeChnageCell.h
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKchicangTypeChnageCellDelegate<NSObject>

-(void)SKchicangTypeChnageCellTypeClickTag:(NSInteger)tag;

@end

@interface SKchicangTypeChnageCell : UITableViewCell

- (void)skchangeType:(NSInteger)type;

@property(nonatomic , weak) id <SKchicangTypeChnageCellDelegate>Vdelegate;

@end

//
//  SKMyAuthenInfoCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKMyAuthenInfoCellDelegate <NSObject>

@required
// cell 的contentTextField的文本发生改变时调用
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath;

@end

@interface SKMyAuthenInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *contentTF;

- (void)initMyAuthenInfoType:(NSString *)type palceString:(NSString *)string index:(NSIndexPath *)index;

@property (weak, nonatomic) id<SKMyAuthenInfoCellDelegate> Vdelegate;

@end

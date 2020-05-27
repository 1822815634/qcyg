//
//  SKpersonOperaTypeCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//
/**交易认证*/
#import <UIKit/UIKit.h>

@protocol SKpersonOperaTypeCellDelegate<NSObject>

-(void)SKpersonOperaTypeCellTypeClickIndex:(NSInteger)index tag:(NSInteger)tag;

@end

@interface SKpersonOperaTypeCell : UITableViewCell

- (void)initSkpersonOperaTypeCell:(NSArray *)titleArr imageArr:(NSArray *)imageArr hidden:(BOOL)ret title:(NSString *)title index:(NSIndexPath *)index;


@property(nonatomic , weak) id <SKpersonOperaTypeCellDelegate>Vdelegate;

@end

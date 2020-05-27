//
//  SKSelectAccountView.h
//  Stockallocation
//
//  Created by xumin on 2019/3/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKSelectAccountView : UIView

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,copy) void(^cellClickIndexPath)(NSString *StockAccount,NSInteger tag);

@end

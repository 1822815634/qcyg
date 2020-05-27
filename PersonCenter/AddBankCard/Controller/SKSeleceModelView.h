//
//  SKSeleceModelView.h
//  Stockallocation
//
//  Created by xumin on 2019/3/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKSeleceModelView : UIView

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) NSArray *dataPrvArray;

@property (nonatomic,strong) NSArray *dataCityArray;

@property (nonatomic,copy) NSString *modelType;

@property (nonatomic,copy) void(^cellClickIndexPath)(NSString *ResultStr,NSString *bankID);

@property (nonatomic,copy) void(^cellPrvClickIndexPath)(NSString *ResultStr,NSString *prvID);
@property (nonatomic,copy) void(^cellCityClickIndexPath)(NSString *ResultStr,NSString *CityID);

@end

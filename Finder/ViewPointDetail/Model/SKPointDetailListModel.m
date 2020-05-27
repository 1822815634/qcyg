//
//  SKPointDetailListModel.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKPointDetailListModel.h"

@implementation SKPointDetailListModelResponse

@end

@implementation SKPointDetailListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[SKPointDetailListModelResponse class]};
}

@end

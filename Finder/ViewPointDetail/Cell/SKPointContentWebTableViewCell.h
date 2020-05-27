//
//  SKPointContentWebTableViewCell.h
//  Stockallocation
//
//  Created by wuyou on 2019/7/16.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKPointContentWebTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

- (void)setDataWithHtmlString:(NSString *)htmlString;

@end

NS_ASSUME_NONNULL_END

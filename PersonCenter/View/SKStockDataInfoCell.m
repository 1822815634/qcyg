//
//  SKStockDataInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKStockDataInfoCell.h"

@interface SKStockDataInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *sellOneLab;
@property (weak, nonatomic) IBOutlet UILabel *selltwoLab;
@property (weak, nonatomic) IBOutlet UILabel *sellthreeLab;
@property (weak, nonatomic) IBOutlet UILabel *sellfourLab;
@property (weak, nonatomic) IBOutlet UILabel *sellFiveLab;
@property (weak, nonatomic) IBOutlet UILabel *NewPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *maxPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *minPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *rateLab;
@property (weak, nonatomic) IBOutlet UILabel *sellOneNumLab;
@property (weak, nonatomic) IBOutlet UILabel *sellTwoNUmLab;
@property (weak, nonatomic) IBOutlet UILabel *sellThreeNumLba;
@property (weak, nonatomic) IBOutlet UILabel *sellFourNumLab;
@property (weak, nonatomic) IBOutlet UILabel *sellFiveNumLab;
@property (weak, nonatomic) IBOutlet UILabel *buyOnePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyTwoPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyThreePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyFourPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyFivePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyOneNumLab;
@property (weak, nonatomic) IBOutlet UILabel *buyTwoNumLab;
@property (weak, nonatomic) IBOutlet UILabel *buyThreeNumLab;
@property (weak, nonatomic) IBOutlet UILabel *buyFourNumLab;
@property (weak, nonatomic) IBOutlet UILabel *buyFiveNumLab;

@end

@implementation SKStockDataInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setshareInfoWithDict:(NSDictionary *)dict
{
    _buyOneNumLab.text = [dict objectForKey:@"buyOne"];
    _buyTwoNumLab.text = [dict objectForKey:@"buyTwo"];
    _buyThreeNumLab.text = [dict objectForKey:@"buyThree"];
    _buyFourNumLab.text = [dict objectForKey:@"buyFour"];
    _buyFiveNumLab.text = [dict objectForKey:@"buyFive"];
    
    _buyOnePriceLab.text = [dict objectForKey:@"buyOnePri"];
    _buyTwoPriceLab.text = [dict objectForKey:@"buyTwoPri"];
    _buyThreePriceLab.text = [dict objectForKey:@"buyThreePri"];
    _buyFourPriceLab.text = [dict objectForKey:@"buyFourPri"];
    _buyFivePriceLab.text = [dict objectForKey:@"buyFivePri"];
    
    _sellOneLab.text = [dict objectForKey:@"sellOnePri"];
    _selltwoLab.text = [dict objectForKey:@"sellTwoPri"];
    _sellthreeLab.text = [dict objectForKey:@"sellThreePri"];
    _sellfourLab.text = [dict objectForKey:@"sellFourPri"];
    _sellFiveLab.text = [dict objectForKey:@"sellFivePri"];
    
    _sellOneNumLab.text = [dict objectForKey:@"sellOne"];
    _sellTwoNUmLab.text = [dict objectForKey:@"sellTwo"];
    _sellThreeNumLba.text = [dict objectForKey:@"sellThree"];
    _sellFourNumLab.text = [dict objectForKey:@"sellFour"];
    _sellFiveNumLab.text = [dict objectForKey:@"sellFive"];
    
    
    _maxPriceLab.text = [dict objectForKey:@"todayMax"];
    _minPriceLab.text = [dict objectForKey:@"todayMin"];
    _rateLab.text = [dict objectForKey:@"rise"];
    _NewPriceLab.text = [dict objectForKey:@"nowPri"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

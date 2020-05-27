//
//  SKSeleceModelView.m
//  Stockallocation
//
//  Created by xumin on 2019/3/23.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSeleceModelView.h"

@interface SKSeleceModelView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayDict;

@property (nonatomic,strong) NSMutableArray *arrayDictID;

@end

@implementation SKSeleceModelView

-(NSMutableArray *)arrayDict{
    if (!_arrayDict) {
        _arrayDict = [[NSMutableArray alloc]init];
    }
    return _arrayDict;
}
-(NSMutableArray *)arrayDictID{
    if (!_arrayDictID) {
        _arrayDictID = [[NSMutableArray alloc]init];
    }
    return _arrayDictID;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.arrayDict removeAllObjects];
    [self.arrayDictID removeAllObjects];
    for (NSDictionary *dict in dataArray[0]) {
        NSString *bankName = [dict objectForKey:@"title"];
        NSString *bankId = [dict objectForKey:@"bank_id"];
        [self.arrayDict addObject:bankName];
        [self.arrayDictID addObject:bankId];
    }
    [self.tableView reloadData];
}
-(void)setDataPrvArray:(NSArray *)dataPrvArray{
    _dataPrvArray = dataPrvArray;
    [self.arrayDict removeAllObjects];
    [self.arrayDictID removeAllObjects];
    for (NSDictionary *dict in dataPrvArray[0]) {
        NSString *prvName = [dict objectForKey:@"name"];
        NSString *prvID = [dict objectForKey:@"id"];
        [self.arrayDict addObject:prvName];
        [self.arrayDictID addObject:prvID];
    }
    [self.tableView reloadData];
}

-(void)setDataCityArray:(NSArray *)dataCityArray{
    _dataCityArray = dataCityArray;
    [self.arrayDict removeAllObjects];
    [self.arrayDictID removeAllObjects];
    for (NSDictionary *dict in dataCityArray[0]) {
        NSString *CityName = [dict objectForKey:@"name"];
        NSString *CityID = [dict objectForKey:@"id"];
        [self.arrayDict addObject:CityName];
        [self.arrayDictID addObject:CityID];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDict.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKSeleceModelView"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SKSeleceModelView"];
    }
    cell.textLabel.text =self.arrayDict[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.modelType isEqualToString:@"bank"]) {
        NSString *resultStr = self.arrayDict[indexPath.row];
        NSString *bankId = self.arrayDictID[indexPath.row];
        if (self.cellClickIndexPath) {
            self.cellClickIndexPath(resultStr,bankId);
        }
    }else if([self.modelType isEqualToString:@"prv"]){
        NSString *resultStr = self.arrayDict[indexPath.row];
        NSString *prvID = self.arrayDictID[indexPath.row];
        if (self.cellPrvClickIndexPath) {
            self.cellPrvClickIndexPath(resultStr, prvID);
        }
    }else{
        NSString *resultStr = self.arrayDict[indexPath.row];
        NSString *cityID = self.arrayDictID[indexPath.row];
        if (self.cellCityClickIndexPath) {
            self.cellCityClickIndexPath(resultStr, cityID);
        }
    }
}

@end

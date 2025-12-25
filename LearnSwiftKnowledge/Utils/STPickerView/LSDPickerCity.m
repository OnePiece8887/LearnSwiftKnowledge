//
//  LSDPickerCity.m
//  EasyToClassmates
//
//  Created by ls on 2017/6/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDPickerCity.h"
#import "LSDCityModel.h"
#import "LSDAreaModel.h"
#import "LSDProvinceModel.h"
#import <YYModel/YYModel.h>
@interface LSDPickerCity ()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.数据源数组 */
@property (nonatomic, strong, nullable)NSArray *arrayRoot;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvince;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayCity;
/** 4.当前地区数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayArea;
/** 5.当前选中数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;

/** 6.省份 */
@property (nonatomic, strong, nullable)NSString *province;
///
@property(copy,nonatomic)NSString *provinceid;
/** 7.城市 */
@property (nonatomic, strong, nullable)NSString *city;
///
@property(copy,nonatomic)NSString *cityid;
/** 8.地区 */
@property (nonatomic, strong, nullable)NSString *area;
///
@property(copy,nonatomic)NSString *areaid;

///
@property(assign,nonatomic)NSInteger  oneIndex;
///
@property(assign,nonatomic)NSInteger twoIndex;
///
@property(assign,nonatomic)NSInteger thirdIndex;

@end

@implementation LSDPickerCity

#pragma mark - --- init 视图初始化 ---

- (void)setupUI
{
    // 1.获取数据

    
    self.arrayProvince = [NSMutableArray arrayWithArray:self.arrayRoot];
    
    LSDProvinceModel *provinceModel = self.arrayProvince[0];
    self.province = provinceModel.city_name;
    self.provinceid = provinceModel.city_id;
 
    self.arrayCity = [NSMutableArray arrayWithArray:provinceModel.
                      cityArr];
    NSArray *cityArray = provinceModel.cityArr;
    LSDAreaModel *model =  cityArray[0];
    self.city = model.city_name;
    self.cityid = model.city_id;
    
    
    self.arrayArea = [NSMutableArray arrayWithArray:model.areaArr];
    
    if (self.arrayArea.count != 0) {
        LSDCityModel *cityModel = model.areaArr[0];
        self.area = cityModel.city_name;
        self.areaid = cityModel.city_id;
    }else{
        self.area = @"";
        self.areaid = @"";
    }
    
    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
    [self setTitle:@"请选择城市地区"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  
    if (component == 0) {
        
        return self.arrayProvince.count;
    }else if (component == 1) {
        
        //多少行 获取第0列的当前选中行
//    NSInteger index0 =  [pickerView selectedRowInComponent:0];
//    LSDProvinceModel *provinceModel =   self.arrayRoot[index0];
//        
//        [self.arrayCity removeAllObjects];
//        
//        self.arrayCity = [NSMutableArray arrayWithArray:provinceModel.cityArr];
        
        return self.arrayCity.count;
        
    }else{
        //多少行 获取第0列的当前选中行
//        NSInteger index0 =  [pickerView selectedRowInComponent:0];
//        NSInteger index1 =  [pickerView selectedRowInComponent:1];
//        LSDProvinceModel *provinceModel =   self.arrayRoot[index0];
//    
//        LSDAreaModel *areaModel = provinceModel.cityArr[index1];
//        
//        [self.arrayArea removeAllObjects];
//        
//        self.arrayArea = [NSMutableArray arrayWithArray:areaModel.areaArr];
        
        return self.arrayArea.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        self.oneIndex = row;
        
        LSDProvinceModel *provinceModel =  self.arrayRoot[row];

        self.arraySelected = provinceModel.cityArr.mutableCopy;
        
        [self.arrayCity removeAllObjects];
        self.arrayCity = [NSMutableArray arrayWithArray:self.arraySelected];

        
        LSDAreaModel *areaModel = self.arraySelected[0];
        
        [self.arrayArea removeAllObjects];
        self.arrayArea = [NSMutableArray arrayWithArray:areaModel.areaArr];

        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if (component == 1) {
     
        
        if (self.arraySelected.count == 0) {
            
            LSDProvinceModel *provinceModel =  self.arrayRoot[0];
            self.arraySelected = provinceModel.cityArr.mutableCopy;
        }
        
        
        LSDAreaModel *areaModel = self.arraySelected[row];
        
        [self.arrayArea removeAllObjects];
        
        self.arrayArea = [NSMutableArray arrayWithArray:areaModel.areaArr];

        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else{
        
         self.thirdIndex = row;
        
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.borderButtonColor;
        }
    }];
    
    
    NSString *text;
    if (component == 0) {
        
        LSDProvinceModel *provinceModel = self.arrayProvince[row];
        text =  provinceModel.city_name;
    }else if (component == 1){
        
        LSDAreaModel *areaModel = self.arrayCity[row];
        
        text =  areaModel.city_name;
    }else{
        if (self.arrayArea.count > 0) {
            LSDCityModel *cityModel = self.arrayArea[row];
            text = cityModel.city_name;
        }else{
            text =  @"";
        }
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    if ([self.delegate respondsToSelector:@selector(pickerArea:province:provinceid:city:cityid:area:areaid:)]) {
        [self.delegate pickerArea:self province:self.province provinceid:self.provinceid city:self.city cityid:self.cityid area:self.area areaid:self.areaid];
    }
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    
    LSDProvinceModel *provinceModel = self.arrayProvince[index0];
    self.province = provinceModel.city_name;
    self.provinceid = provinceModel.city_id;
    
    LSDAreaModel *areaModel = self.arrayCity[index1];
    self.city = areaModel.city_name;
    self.cityid = areaModel.city_id;
   
    if (self.arrayArea.count != 0) {
        LSDCityModel *cityModel = self.arrayArea[index2];
        self.area = cityModel.city_name;
        self.areaid = cityModel.city_id;
    }else{
        self.area = @"";
        self.areaid = @"";
    }
    
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.area];
    [self setTitle:title];
    
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---

- (NSArray *)arrayRoot
{
    if (!_arrayRoot) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        
        NSDictionary *dataDic = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSArray *array = dataDic[@"data"];
        NSMutableArray *muarray = [NSMutableArray array];
        for (NSDictionary *dic  in array) {
            LSDProvinceModel *provinceModel = [LSDProvinceModel yy_modelWithDictionary:dic];
            [muarray addObject:provinceModel];
        }
    
        _arrayRoot = muarray.copy;
        
    }
    return _arrayRoot;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = @[].mutableCopy;
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = @[].mutableCopy;
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = @[].mutableCopy;
    }
    return _arrayArea;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = @[].mutableCopy;
    }
    return _arraySelected;
}


@end

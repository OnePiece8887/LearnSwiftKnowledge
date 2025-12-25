//
//  LSDPickerDateTimeView.m
//  EasyToClassmates
//
//  Created by ls on 2017/8/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDPickerDateTimeView.h"
#import "NSCalendar+STPicker.h"

@interface LSDPickerDateTimeView ()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.年 */
@property (nonatomic, assign)NSInteger year;
/** 2.月 */
@property (nonatomic, assign)NSInteger month;
/** 3.日 */
@property (nonatomic, assign)NSInteger day;
/** 4.小时 */
@property (nonatomic, copy)NSString *hour;
/** 5.分钟 */
@property (nonatomic, copy)NSString *minute;
///
@property(strong,nonatomic)NSArray *hourArray;
///
@property(strong,nonatomic)NSArray *minuteArray;
@end

@implementation LSDPickerDateTimeView

#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    
    _yearLeast = 1900;
    _yearSum   = 200;
    _heightPickerComponent = 28;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
 
    
    self.hour = [NSString stringWithFormat:@"%02zd",[NSCalendar currentHour]];
    self.minute = [NSString stringWithFormat:@"%02zd",[NSCalendar currentMinute]];
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}

#pragma mark - --- delegate 视图委托 ---
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        return 12;
    }else if(component == 2){
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.yearLeast;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }else if(component == 3){
        return self.hourArray.count;
    }else{
        return self.minuteArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            [pickerView reloadComponent:2];
        case 3:
            [pickerView reloadComponent:3];
        default:
            break;
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
    if (self.showUnits) {
        if (component == 0) {
            text =  [NSString stringWithFormat:@"%zd年", row + self.yearLeast];
        }else if (component == 1){
            text =  [NSString stringWithFormat:@"%zd月", row + 1];
        }else if (component == 2){
            text = [NSString stringWithFormat:@"%zd日", row + 1];
        }else if (component == 3){
            text = [NSString stringWithFormat:@"%@时", self.hourArray[row]];
        }else{
            text = [NSString stringWithFormat:@"%@分", self.minuteArray[row]];
        }
    }else{
        if (component == 0) {
            text =  [NSString stringWithFormat:@"%zd", row + self.yearLeast];
        }else if (component == 1){
            text =  [NSString stringWithFormat:@"%zd", row + 1];
        }else if (component == 2){
            text = [NSString stringWithFormat:@"%zd", row + 1];
        }else if (component == 3){
            text = [NSString stringWithFormat:@"%@", self.hourArray[row]];
        }else{
            text = [NSString stringWithFormat:@"%@", self.minuteArray[row]];
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
    
    if ([self.delegate respondsToSelector:@selector(pickerDateTimeViewWithYear:month:day:hour:minute:title:)]) {
        [self.delegate pickerDateTimeViewWithYear:self.year month:self.month day:self.day hour:self.hour minute:self.minute title:self.markTitle];
    }
    
    [super selectedOk];
    
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    self.year  = [self.pickerView selectedRowInComponent:0] + self.yearLeast;
    self.month = [self.pickerView selectedRowInComponent:1] + 1;
    self.day   = [self.pickerView selectedRowInComponent:2] + 1;
    self.hour = self.hourArray[[self.pickerView selectedRowInComponent:3]];
    self.minute = self.minuteArray[[self.pickerView selectedRowInComponent:4]];
}

#pragma mark - --- setters 属性 ---
-(void)setMarkTitle:(NSString *)markTitle{

    _markTitle = markTitle;
    
    self.title = markTitle;
}

- (void)setYearLeast:(NSInteger)yearLeast
{
    
    if (yearLeast<=0) {
        return;
    }
    
    _yearLeast = yearLeast;
    [self.pickerView selectRow:(_year - _yearLeast) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
    [self.pickerView selectRow:( [self.hour integerValue]  ) inComponent:3 animated:NO];
    [self.pickerView selectRow:( [self.minute integerValue]  ) inComponent:4 animated:NO];
    
    [self.pickerView reloadAllComponents];
}

- (void)setYearSum:(NSInteger)yearSum{
    if (yearSum<=0) {
        return;
    }
    
    _yearSum = yearSum;
    [self.pickerView reloadAllComponents];
}

-(void)setShowUnits:(BOOL)showUnits{
    _showUnits = showUnits;
    [self.pickerView reloadAllComponents];
}

#pragma mark - --- getters 属性 ---

-(NSArray *)hourArray{
    
    if (_hourArray == nil) {
        
        NSMutableArray *muarray = [NSMutableArray array];
        for (NSInteger i = 0; i < 24 ; i ++) {
            [muarray addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        _hourArray = muarray.copy;
    }
    return _hourArray;
}


-(NSArray *)minuteArray{

    if (_minuteArray == nil) {
        
        NSMutableArray *muarray = [NSMutableArray array];
        for (NSInteger i = 0; i < 60 ; i ++) {
            [muarray addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        _minuteArray = muarray.copy;
    }
    return _minuteArray;
}
@end

//
//  LSDPickerCity.h
//  EasyToClassmates
//
//  Created by ls on 2017/6/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "STPickerView.h"

@class LSDPickerCity;
@protocol LSDPickerCityDelegate <NSObject>

@optional
- (void)pickerArea:(LSDPickerCity *)pickerArea province:(NSString *)province provinceid:(NSString *)provinceid  city:(NSString *)city cityid:(NSString *)cityid  area:(NSString *)area areaid:(NSString *)areaid;

@end

@interface LSDPickerCity : STPickerView
/** 1.中间选择框的高度，default is 32*/
@property (nonatomic, assign)CGFloat heightPickerComponent;


@property(nonatomic, weak)id <LSDPickerCityDelegate>delegate ;
@end

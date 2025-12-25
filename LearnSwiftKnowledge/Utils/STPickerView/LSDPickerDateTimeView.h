//
//  LSDPickerDateTimeView.h
//  EasyToClassmates
//
//  Created by ls on 2017/8/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "STPickerView.h"

@protocol LSDPickerDateTimeViewDelegate <NSObject>

-(void)pickerDateTimeViewWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSString *)hour  minute:(NSString *)minute title:(NSString *)title;

@end

@interface LSDPickerDateTimeView : STPickerView
/** 1.最小的年份，default is 1900 */
@property (nonatomic, assign)NSInteger yearLeast;
/** 2.显示年份数量，default is 200 */
@property (nonatomic, assign)NSInteger yearSum;
/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;
///标记
@property(copy,nonatomic)NSString *markTitle;

@property(assign,nonatomic)BOOL showUnits;

///
@property(weak,nonatomic)id<LSDPickerDateTimeViewDelegate> delegate;

@end

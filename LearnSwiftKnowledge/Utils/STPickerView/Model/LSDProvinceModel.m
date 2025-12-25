//
//  LSDProvinceModel.m
//  EasyToClassmates
//
//  Created by ls on 2017/6/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDProvinceModel.h"
#import "LSDAreaModel.h"
@implementation LSDProvinceModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cityArr" : [LSDAreaModel class]
             };
}

@end

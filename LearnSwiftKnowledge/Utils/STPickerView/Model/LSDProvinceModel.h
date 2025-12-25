//
//  LSDProvinceModel.h
//  EasyToClassmates
//
//  Created by ls on 2017/6/7.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LSDProvinceModel : NSObject

///
@property(copy,nonatomic)NSString *city_id;
///
@property(copy,nonatomic)NSString *city_name;
///
@property(strong,nonatomic)NSArray *cityArr;

@end

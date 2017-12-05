//
//  CYBusinessDetailModel1.h
//  CarWashing
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYBusinessDetailModel1 : NSObject
@property (assign,nonatomic) NSInteger  CurrentPrice;//现有价格
@property (assign,nonatomic) NSInteger  DiscountPrice;//优惠价格
@property (assign,nonatomic) NSInteger  MerCode;//商家编号
@property (assign,nonatomic) NSInteger  OriginalPrice;//原有价格
@property (assign,nonatomic) NSInteger  SerCode;//服务编号
@property (copy,nonatomic) NSString * SerComment;//服务内容
@property (copy,nonatomic) NSString * SerName;//服务名称
@property (assign,nonatomic) NSInteger  ShopType;//门店类型
@end

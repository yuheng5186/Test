//
//  CYBusinessModel.h
//  CarWashing
//
//  Created by apple on 2017/12/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYBusinessModel : NSObject
@property (copy,nonatomic) NSString * Account_Id;


@property (copy,nonatomic) NSString * Area;
@property (copy,nonatomic) NSString * City;
@property (assign,nonatomic) NSInteger  Distance;
@property (copy,nonatomic) NSString * Img;
@property (assign,nonatomic) NSInteger  Iscert;
@property (copy,nonatomic) NSString * MerAddress;
@property (assign,nonatomic) NSInteger  MerCode;
@property (assign,nonatomic) NSInteger  Score;
@property (assign,nonatomic) NSInteger  ServiceCount;
@property (assign,nonatomic) NSInteger  ShopType;
@property (assign,nonatomic) NSInteger  Xm;
@property (assign,nonatomic) NSInteger  Ym;
@property (copy,nonatomic) NSString * MerFlag;
@property (copy,nonatomic) NSString * MerName;
@property (copy,nonatomic) NSString * MerPhone;
@property (copy,nonatomic) NSString * ServiceTime;
@property (copy,nonatomic) NSString * StoreProfile;

@property (retain,nonatomic) NSArray * MerComList;
@property (retain,nonatomic) NSArray * MerSerList;

@end

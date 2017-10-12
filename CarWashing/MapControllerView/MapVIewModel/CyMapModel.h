//
//  CyMapModel.h
//  CarWashing
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyMapModel : NSObject
@property (nonatomic,copy)NSString* Xm;
@property (nonatomic,copy)NSString* Ym;
@property (nonatomic,copy) NSString* Area;
@property (nonatomic,copy) NSString* City;
@property (nonatomic,copy) NSString* CommentCount;
@property (nonatomic,copy) NSString* Distance;
@property (nonatomic,copy) NSString* Img;
@property (nonatomic,assign) NSInteger Iscert;
@property (nonatomic,copy) NSString* MerAddress;
@property (nonatomic,assign) NSInteger MerCode;
@property (nonatomic,copy) NSString* MerFlag;
@property (nonatomic,copy) NSString* MerName;
@property (nonatomic,copy) NSString* MerPhone;
@property (nonatomic,assign) NSInteger Score;
@property (nonatomic,copy) NSString* ServiceCount;
@property (nonatomic,copy) NSString* ServiceTime;
@property (nonatomic,copy) NSString* ShopType;
@property (nonatomic,copy) NSString* StoreProfile;
@property (nonatomic,copy) NSArray* MerComList;
@property (nonatomic,copy) NSArray* MerSerList;
@end

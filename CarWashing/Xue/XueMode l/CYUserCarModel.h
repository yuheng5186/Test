//
//  CYUserCarModel.h
//  CarWashing
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYUserCarModel : NSObject
@property(nonatomic,copy)NSString *Account_Id;
@property(nonatomic,copy)NSString *ActDate;
@property(nonatomic,copy)NSString *CarBrand;
@property(nonatomic,copy)NSString *CarCode;
@property(nonatomic,copy)NSString *CarComment;
@property(nonatomic,copy)NSString *CarTitle;
@property(nonatomic,copy)NSString *CarType;
@property(nonatomic,copy)NSString *CommentCount;
@property(nonatomic,copy)NSString *FromusrImg;
@property(nonatomic,copy)NSString *FromusrName;

@property(nonatomic,copy)NSString *GiveCount;
@property(nonatomic,copy)NSString *Img;


@property(nonatomic,copy)NSString *IsGive;
@property(nonatomic,copy)NSString *Manufacture;
@property(nonatomic,copy)NSString *Mileage;
@property(nonatomic,copy)NSArray *actModelList;

@end

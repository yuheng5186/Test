//
//  User.h
//  ItTest
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSUInteger Account_Id;
@property NSUInteger Level_id;


@property (copy, nonatomic)NSString *userName;
@property (copy, nonatomic)NSString *Accountname;


@property (copy, nonatomic)NSString *userImagePath;
@property (copy, nonatomic)NSString *userPhone;
//@property (copy, nonatomic)NSString *userPassword;
@property (copy, nonatomic)NSString *userSex;
@property (copy, nonatomic)NSString *userAge;
//@property (copy, nonatomic)NSString *token;
//@property (copy, nonatomic)NSString *status;
@property (copy, nonatomic)NSString *userhobby;
@property (copy, nonatomic)NSString *usermemo;
@property (copy, nonatomic)NSString *useroccupation;


+(User *)getInstanceByDic:(NSDictionary *)dic;

@end

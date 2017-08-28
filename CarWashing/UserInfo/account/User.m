//
//  User.m
//  ItTest
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 cw. All rights reserved.
//

#import "User.h"

@implementation User

+(User *)getInstanceByDic:(NSDictionary *)dic
{
    User *u = [[User alloc]init];
    u.Account_Id = [[dic valueForKey:@"Account_Id"] integerValue];
    u.Level_id = [[dic valueForKey:@"Level_id"] integerValue];
    u.UserScore = [[dic valueForKey:@"UserScore"] integerValue];
    
    if([NSNull null] != [dic objectForKey:@"ModifyType"]) {
        u.ModifyType = [[dic objectForKey:@"ModifyType"] integerValue];
    }
    else
    {
        u.ModifyType = 0;
    }
    if([NSNull null] != [dic objectForKey:@"VerCode"]) {
        u.VerCode = [[dic valueForKey:@"VerCode"] integerValue];
    }
    else
    {
        u.VerCode = 0;
    }
    
    if([NSNull null] != [dic objectForKey:@"Name"])
    {
        u.userName = [dic valueForKey:@"Name"];
    }
    else
    {
        
        u.userName = [dic valueForKey:@"Mobile"];
    }
    
    if([NSNull null] != [dic objectForKey:@"UserName"])
    {
        u.Accountname = [dic valueForKey:@"UserName"];
    }
    else
    {
        
        u.Accountname = [dic valueForKey:@"Mobile"];
    }
    
    
    u.userImagePath = [dic valueForKey:@"Headimg"];
    u.userPhone = [dic valueForKey:@"Mobile"];
    u.userSex = [dic valueForKey:@"Sex"];
    u.userAge = [dic valueForKey:@"Age"];
    
    u.userhobby = [dic valueForKey:@"Hobby"];
    u.usermemo = [dic valueForKey:@"Memo"];
    u.useroccupation = [dic valueForKey:@"Occupation"];
//    u.token = [dic valueForKey:@"token"];
    return u;
}

@end

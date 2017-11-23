//
//  MyinteractModel.h
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyinteractModel : NSObject
@property (nonatomic,copy) NSString * ActDate;
@property (nonatomic,assign) NSInteger  ActivityCode;
@property (nonatomic,copy) NSString * ActivityName;
@property (nonatomic,copy) NSString * ActivityType;
@property (nonatomic,copy) NSString * Comment;
@property (nonatomic,copy) NSString * CommentCount;
@property (nonatomic,copy) NSString * FromusrImg;
@property (nonatomic,copy) NSString * FromusrName;
@property (nonatomic,copy) NSString * GiveCount;
@property (nonatomic,copy) NSString * IndexImg;
@property (nonatomic,copy) NSString * IsGive;
@property (nonatomic,copy) NSString * Gives;
@property (nonatomic,copy) NSString * CarInfo;
@property (nonatomic,retain) NSArray * actModelList;

@end

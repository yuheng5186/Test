//
//  CYQuestionModel.h
//  CarWashing
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYQuestionModel : NSObject

@property(nonatomic,copy)NSString *FromusrName;     //作者名
@property(nonatomic,copy)NSString *FromusrImg;      //作者头像
@property(nonatomic,copy)NSString *CarInfo;         //车辆信息
@property(nonatomic,assign)NSInteger CommentCount;         //评论数
@property(nonatomic,copy)NSString *ActDate;         //时间
@property(nonatomic,copy)NSString *ActivityName;
@property(nonatomic,copy)NSString *IndexImg;
@property(nonatomic,assign)NSInteger ActivityCode; 


@end

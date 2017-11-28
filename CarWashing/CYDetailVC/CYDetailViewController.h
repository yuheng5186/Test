//
//  CYDetailViewController.h
//  CarWashing
//
//  Created by apple on 2017/11/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseController.h"

@interface CYDetailViewController : BaseController
@property(nonatomic) NSInteger ActivityCode;
@property(nonatomic) NSInteger CarCode;
@property NSInteger CommentCount;//评论次数
@property NSInteger GiveCount;//点赞次数
@property (nonatomic,copy)NSString * showType;//点赞次数
@property(copy,nonatomic)NSString * comeTypeString;     //1->提问 2->热门
@property (nonatomic,copy)NSString * carBrithYear;      //车辆生产年份
@property (nonatomic,copy)NSString * loopNum;          //公里数
@property (nonatomic,copy)NSString * deleteStr;//可以删除
@property (nonatomic,assign)NSInteger  DeleteType;//删除类型
@end

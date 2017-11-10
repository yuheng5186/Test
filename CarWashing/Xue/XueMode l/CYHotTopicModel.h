//
//  CYHotTopicModel.h
//  CarWashing
//
//  Created by apple on 2017/11/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYHotTopicModel : NSObject
@property(nonatomic,copy)NSString *ActivityName;    //title
@property(nonatomic,copy)NSString *ActDate;         //时间
@property(nonatomic,copy)NSString *IndexImg;        //图片
@property(nonatomic,copy)NSString *CommentCount;        //评论
@property(nonatomic,copy)NSString *GiveCount;        //赞
@property(nonatomic,assign)NSInteger ActivityCode;        //赞
@end

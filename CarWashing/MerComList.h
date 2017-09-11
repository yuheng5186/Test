//
//  MerComList.h
//  CarWashing
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MerComList : JSONModel
@property(nonatomic,strong)NSString<Optional> *Account_Id,*CommentContent,*CommentDate,*FromuserImg,*FromuserName,*PageSize;
@property(nonatomic,assign)int ComCode,MerCode,OrderId,Score,SerCode,PageIndex;
@end

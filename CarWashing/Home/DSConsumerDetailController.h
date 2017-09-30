//
//  DSConsumerDetailController.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseController.h"
#import "Record.h"
#import "CYModel.h"
@interface DSConsumerDetailController : BaseController

@property(nonatomic,copy)Recordinfo *record;

@property(nonatomic,copy)CYModel *CYrecord;

@property(nonatomic,assign)NSInteger showType;

@end

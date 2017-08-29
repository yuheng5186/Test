//
//  Record.h
//  CarWashing
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Record : JSONModel

@property (nonatomic,copy) NSString *Account_Id;
@property (nonatomic,copy) NSString *Area;
@property (nonatomic,copy) NSString *UniqueNumber; //(订单号或是卡片编码)1时对应卡片编号2时对应订单号
@property (nonatomic,copy) NSString *RightDes;//右边描述
@property (nonatomic,copy) NSString *MiddleDes;//中间描述
@property (nonatomic,copy) NSString *BottomDes;//下边描述
@property (nonatomic,copy) NSString *CreateDate;//创建时间

@property(nonatomic)NSInteger ShowType; //类型(1.优惠活动;2.消费记录)

@property(nonatomic)NSInteger ConsumptionType; //1.自动扫码支付;2.门店在线支付(当返回类型为2时用到)
@property(nonatomic)NSInteger IntegralNumber; 

@end

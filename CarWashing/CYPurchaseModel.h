//
//  CYPurchaseModel.h
//  CarWashing
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPurchaseModel : NSObject

@property (nonatomic,assign) NSInteger  ConfigCode;//卡片编码
@property (nonatomic ,copy)id <Optional> CardPrice;//卡金额
@property (nonatomic ,copy)id <Optional> DiscountPrice;//优惠金额
@property (nonatomic ,copy)id <Optional> PaymentPrice;//支付金额
@property (nonatomic,copy) NSString * Description;//卡片描述
@property (nonatomic,assign) NSInteger  Integralnum;//积分数
@property (nonatomic,assign) NSInteger  CardType;//卡片类型
@property (nonatomic,assign) NSInteger  GroupNumber;//团购数量
@property (nonatomic,assign) NSInteger  ExpiredDay;//有效期天
@end

//
//  MerSerListModel.m
//  CarWashing
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MerSerListModel.h"

@implementation MerSerListModel
//如果不想每一条属性都添加，我们也可以在.m文件中重写方法
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end
@implementation MerchantModel
//如果不想每一条属性都添加，我们也可以在.m文件中重写方法
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end

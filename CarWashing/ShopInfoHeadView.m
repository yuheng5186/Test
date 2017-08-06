//
//  ShopInfoHeadView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopInfoHeadView.h"

@implementation ShopInfoHeadView

+ (instancetype)shopInfoHeadView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"ShopInfoHeadView" owner:nil options:nil].lastObject;
}

@end

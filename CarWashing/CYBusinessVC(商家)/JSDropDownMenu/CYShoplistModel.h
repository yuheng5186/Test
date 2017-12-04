//
//  CYShoplistModel.h
//  CarWashing
//
//  Created by apple on 2017/12/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYShoplistModel : NSObject
@property (copy,nonatomic) NSString * Title;
@property (assign,nonatomic) NSInteger Value;
@property (retain,nonatomic) NSArray * serList;
@end

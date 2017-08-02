//
//  GoodsViewLayout.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GoodsViewLayout.h"

@implementation GoodsViewLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    CGFloat itemWH = (Main_Screen_Width - 1) / 2;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing = 1;
}

@end

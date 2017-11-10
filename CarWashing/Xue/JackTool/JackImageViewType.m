//
//  JackImageViewType.m
//  JackImageViewTool
//
//  Created by Wuxinglin on 2017/11/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "JackImageViewType.h"
#import "JackPhotoBrower.h"

@implementation JackImageViewType
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    self.image = [UIImage imageNamed:@"placeholder"];
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToLargeImage)];
    [self addGestureRecognizer:tap];
}

-(void)ToLargeImage{
    NSLog(@"Large!");
    JackPhotoBrower *brower = [[JackPhotoBrower alloc]init];
    [brower showYourself:self];
}


@end

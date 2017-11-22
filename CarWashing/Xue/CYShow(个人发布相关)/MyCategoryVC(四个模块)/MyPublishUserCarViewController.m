//
//  MyPublishUserCarViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyPublishUserCarViewController.h"

@interface MyPublishUserCarViewController ()

@end

@implementation MyPublishUserCarViewController
- (void) drawNavigation {
    [self drawTitle:@"发现"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self getData];
}
-(void)getData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"PageIndex":@(0),
                             @"PageSize":@(10),
                             @"AcquisitionType":@(1)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/SecondHandCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"我的二手车发布%@",dict);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end

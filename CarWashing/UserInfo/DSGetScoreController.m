//
//  DSGetScoreController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSGetScoreController.h"
#import <StoreKit/StoreKit.h>

@interface DSGetScoreController ()<SKStoreProductViewControllerDelegate>

@end

@implementation DSGetScoreController

- (void)drawNavigation {
    
    [self drawTitle:@"给我评分" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self openAppWithIdentifier:@"id940489630"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/qq/id451108668?mt=12"]];
    
    
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    
}
- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
    
    
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)storeProductVC {
    [storeProductVC dismissViewControllerAnimated:YES completion:^{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DSUpdateRuleController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/25.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSUpdateRuleController.h"

@interface DSUpdateRuleController ()<UIWebViewDelegate>

@end

@implementation DSUpdateRuleController

- (void)drawNavigation {
    
    [self drawTitle:@"等级规则"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    webView.opaque = NO;
    webView.delegate = self;
    
    [webView sizeToFit];
    
    [self.view addSubview:webView];
    
    NSURL * url                     = [NSURL URLWithString: @"http://115.159.97.191/jingding/dengji.html"];
    NSURLRequest* request           = [NSURLRequest requestWithURL: url];
    
    [webView loadRequest:request];
    
    webView.scrollView.contentInset = UIEdgeInsetsMake (0.0f, 0.0f, 80.0f, 0.0f);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
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

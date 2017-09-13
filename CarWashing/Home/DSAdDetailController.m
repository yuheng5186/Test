//
//  DSAdDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAdDetailController.h"

@interface DSAdDetailController ()<UIWebViewDelegate>

@end

@implementation DSAdDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"广告详情"];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSMutableString *str = [NSMutableString string];
    // 3.根据标签类型获取指定标签的元素
    [str appendString:@"var header = document.getElementsByTagName(\"header\")[0];"];
    [str appendString:@"header.parentNode.removeChild(header);"];// 移除头部的导航栏
    [str appendString:@"var content = document.getElementById('wrap');"];
    [str appendString:@"content.style.paddingTop = '0px';"];
    [webView stringByEvaluatingJavaScriptFromString:str];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    webView.opaque = NO;
    webView.delegate = self;
    
    [webView sizeToFit];
    
    [self.view addSubview:webView];
    NSLog(@"%@",self.urlstr);
    NSURL * url                     = [NSURL URLWithString:self.urlstr];
    NSURLRequest* request           = [NSURLRequest requestWithURL: url];
    
    [webView loadRequest:request];
    
    webView.scrollView.contentInset = UIEdgeInsetsMake (0.0f, 0.0f, 80.0f, 0.0f);
    
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

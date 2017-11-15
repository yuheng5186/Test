//
//  OldDriverViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/15.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OldDriverViewController.h"
#import <WebKit/WebKit.h>

@interface OldDriverViewController ()
@property(strong,nonatomic)UIView *fakeNavigation;
@property(strong,nonatomic)WKWebView *showWebView;
@end

@implementation OldDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fakeNavigation];
    [self.view addSubview:self.showWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(UIView *)fakeNavigation{
    if (!_fakeNavigation) {
        _fakeNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 66)];
        _fakeNavigation.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        
        UILabel *fakeTitle = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-100, 26, 200, 30)];
        fakeTitle.text = @"保养经验";
        fakeTitle.font = [UIFont systemFontOfSize:18 weight:18];
        fakeTitle.textColor = [UIColor whiteColor];
        fakeTitle.textAlignment = NSTextAlignmentCenter;
        [_fakeNavigation addSubview:fakeTitle];
        
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 32, 19, 19)];
        backImageView.image = [UIImage imageNamed:@"icon_titlebar_arrow"];
        backImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_fakeNavigation addSubview:backImageView];
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:backButton];
    }
    return _fakeNavigation;
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(WKWebView *)showWebView{
    if (!_showWebView) {
        _showWebView = [[WKWebView alloc]initWithFrame:CGRectMake(12, 66, Main_Screen_Width-24, Main_Screen_Height-66)];
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"remain"
                                                              ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath                                                        encoding:NSUTF8StringEncoding                                                       error:nil];
        [_showWebView loadHTMLString:htmlCont baseURL:baseURL];
        

        
    }
    return _showWebView;
}

@end

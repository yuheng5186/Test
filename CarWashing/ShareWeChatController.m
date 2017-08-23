//
//  ShareWeChatController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/23.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShareWeChatController.h"
#import "ShareWechatView.h"

@interface ShareWeChatController ()

@property (nonatomic, weak) UIView *containView;

@property (nonatomic, weak) ShareWechatView *shareView;

@end

@implementation ShareWeChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIButton *dissmissBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    dissmissBtn.alpha = 0.5f;
    dissmissBtn.backgroundColor = [UIColor blackColor];
    
    [dissmissBtn addTarget:self action:@selector(clickDissmissButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dissmissBtn];
    
//    UIView *containView = [[UIView alloc] init];
//    containView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 230*Main_Screen_Height/667);
//    containView.backgroundColor = [UIColor whiteColor];
//    self.containView = containView;
//    [self.view addSubview:containView];
    
    ShareWechatView *shareView = [ShareWechatView shareWechatView];
    shareView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 230*Main_Screen_Height/667);
    self.shareView = shareView;
    
    [self.view addSubview:shareView];
    
}





- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //更改视图
    self.shareView.frame = CGRectMake(0, Main_Screen_Height - 230*Main_Screen_Height/667, Main_Screen_Width, 230*Main_Screen_Height/667);
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)clickDissmissButton{
    
    //更改视图
    self.shareView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 230*Main_Screen_Height/667);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


- (IBAction)shareWechatFriendsBtn:(UIButton *)sender {
}



- (IBAction)shareWechatPYQBtn:(UIButton *)sender {
}


- (IBAction)cancelButton:(UIButton *)sender {
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

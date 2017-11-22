//
//  MyInteractMessageViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyInteractMessageViewController.h"

@interface MyInteractMessageViewController ()
{
    UIButton * selectButton;
}
@property (nonatomic,weak)UIButton *selectedBtn;
@end

@implementation MyInteractMessageViewController
- (void) drawNavigation {
    [self drawTitle:@"我的消息"];
    
}
- (void) drawContent {
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor=[UIColor whiteColor];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(84);
        make.width.mas_equalTo(Main_Screen_Width-160);
        make.height.mas_equalTo(50);
    }];
    CGFloat width = (Main_Screen_Width-170)/2;
    NSLog(@"--%f",width);
    NSArray * arr=@[@"评论",@"点赞"];
    for (int i =0; i<2; i++) {
        UIButton * TwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        TwoButton.frame =CGRectMake(5+i*width, 5, width, 40);
        [TwoButton setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        TwoButton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0*Main_Screen_Height/667];
        [TwoButton setBackgroundColor:RGBAA(242, 242, 242, 1.0)];
        [TwoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [TwoButton setTitleColor:[UIColor colorFromHex:@"#0161a1"] forState:UIControlStateSelected];
        TwoButton.tag=i+1;
        if (TwoButton.tag == 1) {
            //第一个按钮默认选中
            TwoButton.selected = YES;
            [TwoButton setBackgroundColor:[UIColor whiteColor]];
            //记录原按钮
            self.selectedBtn = TwoButton;
            
        }
        [TwoButton addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:TwoButton];
    }
    
}
-(void)buttonBtnClick:(UIButton*)btn
{
//    [self.recommendView removeFromSuperview];
//    [self.AttentionView removeFromSuperview];
    //每当点击按钮时取消上次选中的
    self.selectedBtn.selected = NO;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [self.selectedBtn setBackgroundColor:RGBAA(242, 242, 242, 1.0)];
    //当前点击按钮选中
    btn.selected = YES;
    self.selectedBtn = btn;
//    if (btn.tag==1) {
//        [self.view addSubview:self.recommendView];
//        RecommendViewController*vc=[[RecommendViewController alloc]init];
//        self.recommendVc = vc;
//        [self addChildViewController:vc];
//        [self.recommendView addSubview:vc.view];
//    }else if (btn.tag==2){
//        [self.view addSubview:self.AttentionView];
//        AttentionViewController*vc=[[AttentionViewController alloc]init];
//        [self addChildViewController:vc];
//        self.AttentionVc=vc;
//        [self.AttentionView addSubview:vc.view];
//    }else if (btn.tag==3){
//        [self.view addSubview:self.NearbyView];
//        NearbyViewController*vc=[[NearbyViewController alloc]init];
//        [self addChildViewController:vc];
//        self.NearbyVc=vc;
//        [self.NearbyView addSubview:vc.view];
//    }
    
    
}


@end

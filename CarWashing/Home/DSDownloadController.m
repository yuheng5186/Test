//
//  DSDownloadController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSDownloadController.h"
#import "HYActivityView.h"

@interface DSDownloadController ()

{
    enum WXScene scene;
    
}
@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation DSDownloadController

- (void) drawNavigation {

    [self drawTitle:@"下载金顶洗车"];
    [self drawRightImageButton:@"fenxiang" action:@selector(shareButtonClick:)];
}

- (void) shareButtonClick:(id)sender {

    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneSession;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneTimeline;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
}

- (void) drawContent {

    self.contentView.top                = 0;
    self.contentView.height             = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#f6f6f6"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}

- (void) createSubView {

    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*375/667) color:[UIColor whiteColor]];
    titleView.top                      = Main_Screen_Height*64/375;
    titleView.centerX                  = Main_Screen_Width/2;
    
    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*40/375, Main_Screen_Height*40/667) imageName:@"WechatIMG3"];
    logoImageView.top           = Main_Screen_Height*23/667;
    logoImageView.centerX       = titleView.size.width/2;
    
    NSString   *titleString     = @"金顶洗车";

    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:15];
    UILabel *titleLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = logoImageView.centerX;
    titleLabel.top              = logoImageView.bottom +Main_Screen_Height*12/667;
    
    UIImageView *bigImageView   = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*160/375, Main_Screen_Height*160/667) imageName:@"WechatIMG54"];
    bigImageView.top            = titleLabel.bottom +Main_Screen_Height*28/667;
    bigImageView.centerX        = titleView.size.width/2;
    
    
    NSString *showString              = @"扫一扫上面二维码，下载金顶洗车APP";
    UIFont *showStringFont            = [UIFont systemFontOfSize:14];
    UILabel *showLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:showString font:showStringFont] font:showStringFont text:showString isCenter:NO];
    showLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    showLabel.top               = bigImageView.bottom +Main_Screen_Height*32/667;
    showLabel.centerX           = bigImageView.centerX;
    
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

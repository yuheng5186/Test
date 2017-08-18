//
//  DSShareGetMoneyController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSShareGetMoneyController.h"
#import "WeixinSessionActivity.h"
#import "WeixinTimelineActivity.h"
#import "HYActivityView.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"

@interface DSShareGetMoneyController ()
{
    
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
    
    NSArray *activity;
}
@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation DSShareGetMoneyController

- (void) drawNavigation {

    [self drawTitle:@"分享赚钱"];
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
    
    activity = @[[[WeixinSessionActivity alloc] init], [[WeixinTimelineActivity alloc] init]];

}

- (void) createSubView {
    
//    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*375/667) color:[UIColor colorFromHex:@"#f6f6f6"]];
//    titleView.top                      = Main_Screen_Height*64/375;
//    titleView.centerX                  = Main_Screen_Width/2;
    
//    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*40/375, Main_Screen_Height*40/667) imageName:@"WechatIMG3"];
//    logoImageView.top           = Main_Screen_Height*23/667;
//    logoImageView.centerX       = titleView.size.width/2;
    
    NSString   *titleString     = @"推荐得“洗车卡”";
    
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:25];
    UILabel *titleLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*60/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#545454"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = self.contentView.centerX;
    titleLabel.top              = Main_Screen_Height*100/667;
    
    
    NSString *showString              = @"邀请新人完成注册，即可获得价值99元洗车卡";
    UIFont *showStringFont            = [UIFont systemFontOfSize:14];
    UILabel *showLabel          = [UIUtil drawLabelInView:self.contentView frame:[UIUtil textRect:showString font:showStringFont] font:showStringFont text:showString isCenter:NO];
    showLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    showLabel.textAlignment     = NSTextAlignmentCenter;
    showLabel.top               = titleLabel.bottom +Main_Screen_Height*14/667;
    showLabel.centerX           = titleLabel.centerX;
    
    UIImage  *getImage             = [UIImage imageNamed:@"efnxiangzhuanqiantu"];
    UIImageView *bigImageView   = [UIUtil drawCustomImgViewInView:self.contentView frame:CGRectMake(0, 0, getImage.size.width, getImage.size.height) imageName:@"efnxiangzhuanqiantu"];
    bigImageView.top            = showLabel.bottom +Main_Screen_Height*55/667;
    bigImageView.centerX        = self.contentView.centerX;
    
//    UIButton    *getMoneyButton = [UIUtil drawDefaultButton:self.contentView title:@"立即邀请，新人可获得99元洗车卡" target:self action:@selector(getMoneyButtonClick:)];
    NSString *string   = @"立即邀请，新人可获得99元洗车卡";
    UIFont  *stringFont = [UIFont systemFontOfSize:16];
    UIButton    *getMoneyButton = [UIUtil drawButtonInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*60/375, Main_Screen_Height*40/667) text:string font:stringFont color:[UIColor whiteColor] target:self action:@selector(getMoneyButtonClick:)];
    getMoneyButton.backgroundColor  = [UIColor colorWithHex:0xFFB500 alpha:1.0];
    getMoneyButton.layer.cornerRadius   = 5;
    getMoneyButton.bottom          = Main_Screen_Height -Main_Screen_Height*77/667;
    getMoneyButton.centerX      = self.contentView.centerX;
//    getMoneyButton.width        = Main_Screen_Width - Main_Screen_Width*40/375;
    
}

- (void) getMoneyButtonClick:(id)sender {
    
    ShareView *shareView = [ShareView createViewFromNib];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setBlurEffectWithView:self.view];
    //[alertController setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle];
    [self presentViewController:alertController animated:YES completion:nil];

//        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"这里是标题", [UIImage imageNamed:@"zensong"], [NSURL URLWithString:@"http://www.google.com"]] applicationActivities:activity];
//        activityView.excludedActivityTypes = @[UIActivityTypeAirDrop];
//        [self presentViewController:activityView animated:YES completion:nil];
    
//    if (!self.activityView) {
//        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
//        
//        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
//        self.activityView.numberOfButtonPerLine = 2.5;
//        
//        
//        ButtonView *bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"share_platform_wechat"] handler:^(ButtonView *buttonView){
//            NSLog(@"点击微信");
//            
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.scene = scene;
//            //    req.bText = NO;
//            req.message = WXMediaMessage.message;
//            req.message.title = title;
//            [self setThumbImage:req];
//            if (url) {
//                WXWebpageObject *webObject = WXWebpageObject.object;
//                webObject.webpageUrl = [url absoluteString];
//                req.message.mediaObject = webObject;
//            } else if (image) {
//                WXImageObject *imageObject = WXImageObject.object;
//                imageObject.imageData = UIImageJPEGRepresentation(image, 1);
//                req.message.mediaObject = imageObject;
//            }
//            [WXApi sendReq:req];
//            
//        }];
//        [self.activityView addButtonView:bv];
//        
//        
//        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"share_platform_wechattimeline"] handler:^(ButtonView *buttonView){
//            NSLog(@"点击微信朋友圈");
//        }];
//        [self.activityView addButtonView:bv];
    
//    }
    
//    [self.activityView show];

    
}

- (void)setThumbImage:(SendMessageToWXReq *)req
{
    if (image) {
        CGFloat width = 100.0f;
        CGFloat height = image.size.height * 100.0f / image.size.width;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [image drawInRect:CGRectMake(0, 0, width, height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [req.message setThumbImage:scaledImage];
    }
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

//
//  CYCardDetailViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYCardDetailViewController.h"
#import "CYCardCommentView.h"
#import "CYCardComment1.h"


#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"

#import "ShareWeChatController.h"
#import "HTTPDefine.h"
#import "AppDelegate.h"
#import "HYActivityView.h"
#import "UdStorage.h"
#import "AFNetworkingTool.h"
#import "LCMD5Tool.h"
@interface CYCardDetailViewController ()<SetTabBarDelegate>
{
    UIView * whiteVIew;
    UIView * leftView;
}
@property (nonatomic,strong) UIScrollView * bigScrollerView;
@property (nonatomic,strong) CYCardCommentView * topView;
@property (nonatomic, strong) HYActivityView *activityView;



@end

@implementation CYCardDetailViewController
- (void)drawNavigation {
    
    [self drawTitle:@"充值卡详情"];
}


- (void) drawContent
{
    self.contentView.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bigScrollerView];
    if (self.card.GetCardType ==11) {//团购卡
        UINib *nib = [UINib nibWithNibName:@"CYCardComment1" bundle:nil];
        CYCardComment1 *bookView = [[nib instantiateWithOwner:nil options:nil] firstObject];
        bookView.frame=CGRectMake(0, 0, Main_Screen_Width, 150);
        bookView.titleLabel.text=[NSString stringWithFormat:@"剩余%ld张",self.card.CardCount];
        bookView.timeLabel.text=@"即日起～长期有效";
        
        
        [self.bigScrollerView addSubview:bookView];
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 170, Main_Screen_Width, 50)];
        leftView.backgroundColor=[UIColor whiteColor];
        [self.bigScrollerView addSubview:leftView];
        UILabel * leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 50)];
        leftLabel.text = @"可分享好友免费洗车哦...";
        leftLabel.textColor = [UIColor colorFromHex:@"#ffce46"];
        leftLabel.font = [UIFont systemFontOfSize:18.0];
        [leftView addSubview:leftLabel];
        
        UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shareBtn.frame = CGRectMake(leftView.frame.size.width-95, 10, 75, 30);
        [shareBtn setBackgroundColor:[UIColor colorFromHex:@"#ffce46"]];
        shareBtn.layer.cornerRadius = 5;
        shareBtn.layer.masksToBounds = YES;
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(ShareClick) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:shareBtn];
        
        whiteVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 235, Main_Screen_Width, 300)];
        whiteVIew.backgroundColor=[UIColor whiteColor];
        [self.bigScrollerView addSubview:whiteVIew];
        if ([self.card.CardName isEqualToString:@"炫年卡"]) {
            if (self.card.CardUseState ==1) {//使用中
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_nianka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_yishiyong_nianka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_guoqi_nianka"];
            }
        }else if ([self.card.CardName isEqualToString:@"乐享卡"]){
            if (self.card.CardUseState ==1) {//使用中
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_cika"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_yishiyong_cika"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_guoqi_cika"];
            }
        }else if ([self.card.CardName isEqualToString:@"体验卡"]){
            if (self.card.CardUseState ==1) {//使用中
//                024575
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_tiyanka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_yishiyong_tiyanka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_guoqi_tiyanka"];
            }
        }else if ([self.card.CardName isEqualToString:@"悦洗卡"]){
            if (self.card.CardUseState ==1) {//使用中
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_yueka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_yishiyong_yueka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.leftImageView.image = [UIImage imageNamed:@"qw_guoqi_yueka"];
            }
        }
    }else{
        UINib *nib = [UINib nibWithNibName:@"CYCardCommentView" bundle:nil];
        CYCardCommentView *bookView = [[nib instantiateWithOwner:nil options:nil] firstObject];
        bookView.frame=CGRectMake(0, 0, Main_Screen_Width, 150);
        bookView.titleLabel.text=[NSString stringWithFormat:@"剩余扫码洗车%ld次",self.card.CardCount];
        bookView.timeLabel.text=[NSString stringWithFormat:@"即日起～%@",self.card.ExpEndDates];
        [self.bigScrollerView addSubview:bookView];
        
        whiteVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 165, Main_Screen_Width, 300)];
        whiteVIew.backgroundColor=[UIColor whiteColor];
        [self.bigScrollerView addSubview:whiteVIew];
        
        if ([self.card.CardName isEqualToString:@"炫年卡"]) {
            if (self.card.CardUseState ==1) {//使用中
                bookView.carImageView.image = [UIImage imageNamed:@"qw_nianka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.carImageView.image = [UIImage imageNamed:@"qw_yishiyong_nianka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.carImageView.image = [UIImage imageNamed:@"qw_guoqi_nianka"];
            }
        }else if ([self.card.CardName isEqualToString:@"乐享卡"]){
            if (self.card.CardUseState ==1) {//使用中
                bookView.carImageView.image = [UIImage imageNamed:@"qw_cika"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.carImageView.image = [UIImage imageNamed:@"qw_yishiyong_cika"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.carImageView.image = [UIImage imageNamed:@"qw_guoqi_cika"];
            }
        }else if ([self.card.CardName isEqualToString:@"体验卡"]){
            if (self.card.CardUseState ==1) {//使用中
                bookView.carImageView.image = [UIImage imageNamed:@"qw_tiyanka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.carImageView.image = [UIImage imageNamed:@"qw_yishiyong_tiyanka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.carImageView.image = [UIImage imageNamed:@"qw_guoqi_tiyanka"];
            }
        }else if ([self.card.CardName isEqualToString:@"悦洗卡"]){
            if (self.card.CardUseState ==1) {//使用中
                bookView.carImageView.image = [UIImage imageNamed:@"qw_yueka"];
            }else  if (self.card.CardUseState ==2) {//已使用
                bookView.carImageView.image = [UIImage imageNamed:@"qw_yishiyong_yueka"];
            }else  if (self.card.CardUseState ==3) {//已过期
                bookView.carImageView.image = [UIImage imageNamed:@"qw_guoqi_yueka"];
            }
        }
    }
    
    
   
   
    
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Main_Screen_Width, 50)];
    noticeLabel.text = @"使用须知";
    noticeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    noticeLabel.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    [whiteVIew addSubview:noticeLabel];
    
    UILabel *noticeLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, Main_Screen_Width-20, 30)];
    noticeLabelOne.backgroundColor=[UIColor whiteColor];
    noticeLabelOne.text = @"1、此卡仅限清洗汽车外观，不得购买其它服务项目";
    noticeLabelOne.numberOfLines = 2;
    noticeLabelOne.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabelOne.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    [whiteVIew addSubview:noticeLabelOne];
    
    UILabel*noticeLabeTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, Main_Screen_Width-20, 30)];
    noticeLabeTwo.text = @"2、洗车卡不能兑换现金和转赠与其他人使用";
    noticeLabeTwo.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabeTwo.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    [whiteVIew addSubview:noticeLabeTwo];
    
    UILabel *noticeLabelThree = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, Main_Screen_Width-20, 40)];
    noticeLabelThree.text = @"3、此卡一经售出，概不兑现。不记名，不挂失，不退卡，不补办";
    noticeLabelThree.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabelThree.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabelThree.numberOfLines = 2;
    [whiteVIew addSubview:noticeLabelThree];
    
    UILabel *noticeLabelFour =  [[UILabel alloc] initWithFrame:CGRectMake(10, 190, Main_Screen_Width-20, 40)];
    noticeLabelFour.text = @"4、此卡可在蔷薇服务点享受会员优惠待遇，不得与其它优惠同时使用";
    noticeLabelFour.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabelFour.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabelFour.numberOfLines = 2;
    [whiteVIew addSubview:noticeLabelFour];
    
    UILabel *noticeLabelFive = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, Main_Screen_Width-20, 40)];
    noticeLabelFive.text = @"5、由青岛蔷薇汽车服务有限公司保留此卡法律范围内的最终解释权。VIP热线：4006979558";
    noticeLabelFive.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabelFive.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabelFive.numberOfLines = 2;
    [whiteVIew addSubview:noticeLabelFive];
}
-(UIScrollView*)bigScrollerView
{
    if (_bigScrollerView ==nil) {
        _bigScrollerView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
        _bigScrollerView.contentSize = CGSizeMake(Main_Screen_Width, Main_Screen_Height+100);
        _bigScrollerView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    }
    return _bigScrollerView;
}

-(void)ShareClick{
    if (!self.activityView)
    {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        self.activityView.delegate = self;
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                     @"GroupPurchaseBatch":self.card.GroupPurchaseBatch
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/ShareWashCard",Khttp] success:^(NSDictionary *dict, BOOL success) {
                NSLog(@"%@",dict);
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    //创建发送对象实例
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];//分享标题
                    urlMessage.description = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];//分享描述
                    [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    //创建多媒体对象
                    WXWebpageObject *webObj = [WXWebpageObject object];
                    webObj.webpageUrl = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"JsonData"] objectForKey:@"InviteShareUrl"]];//分享链接
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                }
                else
                {
                    [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                    
                }
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                
            }];
            
            
            self.tabBarController.tabBar.hidden = YES;
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                     @"GroupPurchaseBatch":self.card.GroupPurchaseBatch
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/ShareWashCard",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    //创建发送对象实例
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];//分享标题
                    urlMessage.description = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];//分享描述
                    [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    
                    //创建多媒体对象
                    WXWebpageObject *webObj = [WXWebpageObject object];
                    webObj.webpageUrl = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"JsonData"] objectForKey:@"InviteShareUrl"]];//分享链接
                    
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                }
                else
                {
                    [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                    
                }
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                
            }];
            
            self.tabBarController.tabBar.hidden = YES;
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
}
@end

//
//  DSStartWashingController.m
//  CarWashing
//
//  Created by Mac WuXinLing on 2017/8/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSStartWashingController.h"
#import "DSCompleteWashingController.h"
#import "SXScrPageView.h"
@interface DSStartWashingController ()
{
    SXScrPageView *cycleScroll;
}
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int second;
@property (nonatomic, strong) UILabel *timeNumLabel;
@property (nonatomic, strong) UILabel *stepsLabel;
@property (nonatomic, strong) NSArray *stepsarrs;
@end

@implementation DSStartWashingController

- (void) drawNavigation {
    self.stepsarrs=[[NSArray alloc]initWithObjects:@"底盘清洗",@"环绕泡沫",@"幻彩泡沫",@"高压冲洗",@"水蜡镀膜",@"风干处理", nil];
    [self drawTitle:@"蔷薇爱车"];
}

- (void) dealloc
{
    [self.timer invalidate];
}

- (void) drawContent {
    
    self.contentView.top                = self.navigationView.bottom;
    self.contentView.height             = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#fafafa"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.second = 4;
    [self createSubView];
     [self startTimer];
    
    
}
- (void)startTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
  
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [self.timer fire];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)onTimer
{
    NSLog(@"================ %d",self.second);
    if (self.second == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"洗车成功" message:@"洗车结束，欢迎下次光临！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alertController addAction:OKAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
         [self createSubView];
//        DSCompleteWashingController     *completeVC     = [[DSCompleteWashingController alloc]init];
//        completeVC.hidesBottomBarWhenPushed             = YES;
//        [self.navigationController pushViewController:completeVC animated:YES];
//        
        [self.timer invalidate];
    }else {
        
        NSString *text  = [NSString stringWithFormat:@"%d%@",self.second--,@"秒钟"];
        
        self.timeNumLabel.text  = text;
    }
}


- (void) createSubView {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
    titleView.top                      = Main_Screen_Height*10/667;
    titleView.centerX                  = Main_Screen_Width/2;
    
    
    NSString   *titleString     = @"精洗";
    
    UIFont     *titleFont       = [UIFont systemFontOfSize:18];
    UILabel *titleLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = Main_Screen_Width/4 -Main_Screen_Width*20/375;;
    titleLabel.top              = Main_Screen_Height*16/667;
    
    NSString   *modeString     = @"洗车模式";
    
    UIFont     *modeFont       = [UIFont systemFontOfSize:12];
    UILabel *modeLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:modeFont text:modeString isCenter:NO];
    modeLabel.text             = modeString;
    modeLabel.textColor        = [UIColor colorFromHex:@"#868686"];
    modeLabel.textAlignment    = NSTextAlignmentCenter;
    modeLabel.centerX          = titleLabel.centerX;
    modeLabel.top              = titleLabel.bottom+Main_Screen_Height*10/667;
    
    
    
    NSString   *scoreString     = [NSString stringWithFormat:@"+%d积分",10];
    UILabel *scoreLabel         = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667)];
    scoreLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:scoreString];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange([scoreString length]-2, 2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"#4a4a4a"] range:NSMakeRange([scoreString length]-2, 2)];
    
    scoreLabel.attributedText   = AttributedStr;
    scoreLabel.textAlignment    = NSTextAlignmentCenter;
    scoreLabel.centerX          = Main_Screen_Width/2;
    scoreLabel.top              = Main_Screen_Height*16/667;
    [titleView addSubview:scoreLabel];
    
    
    NSString   *scoreTextString     = @"积分奖励";
    
    UIFont     *scoreTextFont       = [UIFont systemFontOfSize:12];
    UILabel *scoreTextLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:scoreTextFont text:scoreTextString isCenter:NO];
    scoreTextLabel.text             = scoreTextString;
    scoreTextLabel.textColor        = [UIColor colorFromHex:@"#868686"];
    scoreTextLabel.textAlignment    = NSTextAlignmentCenter;
    scoreTextLabel.centerX          = scoreLabel.centerX;
    scoreTextLabel.top              = scoreLabel.bottom+Main_Screen_Height*10/667;
    
    
    
    NSString   *timeNumString     = @"5分钟";
    
    self.timeNumLabel         = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667)];
    self.timeNumLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
    
    NSMutableAttributedString *AttributedStrTime = [[NSMutableAttributedString alloc]initWithString:timeNumString];
    [AttributedStrTime addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange([timeNumString length]-2, 2)];
    [AttributedStrTime addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"#4a4a4a"] range:NSMakeRange([timeNumString length]-2, 2)];
    
    self.timeNumLabel.attributedText   = AttributedStrTime;
    
    self.timeNumLabel.textAlignment    = NSTextAlignmentCenter;
    self.timeNumLabel.centerX          = Main_Screen_Width*3/4 +Main_Screen_Width*20/375;;
    self.timeNumLabel.top              = Main_Screen_Height*16/667;
    
    [titleView addSubview:self.timeNumLabel];
    
    
    NSString   *timeString     = @"洗车时间";
    
    UIFont     *timeFont       = [UIFont systemFontOfSize:12];
    UILabel *timeLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:timeFont text:timeString isCenter:NO];
    timeLabel.text             = timeString;
    timeLabel.textColor        = [UIColor colorFromHex:@"#868686"];
    timeLabel.textAlignment    = NSTextAlignmentCenter;
    timeLabel.centerX          = self.timeNumLabel.centerX;
    timeLabel.top              = self.timeNumLabel.bottom+Main_Screen_Height*10/667;
    
    

    
    
    

#pragma mark-洗车结束

    if (self.second == 0) {
        UIView *middleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
        middleView.top                      = titleView.bottom +Main_Screen_Height*10/667;
        middleView.centerX                  = Main_Screen_Width/2;
        
        NSString   *string            = @"支付方式";
        UIFont     *Font              = [UIFont systemFontOfSize:15];
        UILabel *washingLabel         = [UIUtil drawLabelInView:middleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:Font text:string isCenter:NO];
        washingLabel.text             = string;
        washingLabel.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
        washingLabel.textAlignment    = NSTextAlignmentCenter;
        washingLabel.left             = Main_Screen_Height*12/375;
        washingLabel.top              = Main_Screen_Height*20/667;
        
        
        
        NSString   *timeStr     = @"月卡抵扣";
        
        UIFont     *timeStrFont       = [UIFont systemFontOfSize:12];
        UILabel *timeStrLabel         = [UIUtil drawLabelInView:middleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:timeStrFont text:timeStr isCenter:NO];
        timeStrLabel.text             = timeStr;
        timeStrLabel.textColor        = [UIColor colorFromHex:@"#868686"];
        timeStrLabel.textAlignment    = NSTextAlignmentCenter;
        timeStrLabel.right            = Main_Screen_Width -Main_Screen_Width*12/375;
        timeStrLabel.centerY          = washingLabel.centerY;
            UIView *downView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
            downView.top                      = middleView.bottom +Main_Screen_Height*10/667;
            downView.centerX                  = Main_Screen_Width/2;
        
            NSString   *strings            = @"洗车优惠";
            UIFont     *Fonts              = [UIFont systemFontOfSize:15];
            UILabel *washingLabels         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:Fonts text:strings isCenter:NO];
            washingLabels.text             = strings;
            washingLabels.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
            washingLabels.textAlignment    = NSTextAlignmentCenter;
            washingLabels.left             = Main_Screen_Height*12/375;
            washingLabels.top              = Main_Screen_Height*14/667;
//
            NSString   *cardString            = @"洗车月卡";
            UIFont     *cardFont              = [UIFont systemFontOfSize:18];
            UILabel *washingCardLabel         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:cardFont text:cardString isCenter:NO];
            washingCardLabel.text             = cardString;
            washingCardLabel.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
            washingCardLabel.textAlignment    = NSTextAlignmentCenter;
            washingCardLabel.right            = Main_Screen_Width -Main_Screen_Height*12/375;
            washingCardLabel.top              = Main_Screen_Height*14/667;
        
        
            NSString   *timeStrs     = [NSString stringWithFormat:@"剩余%d次",3];
        
            UIFont     *timeStrFonts       = [UIFont systemFontOfSize:12];
            UILabel *timeStrLabels         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:timeStrFonts text:timeStrs isCenter:NO];
            timeStrLabels.text             = timeStr;
            timeStrLabels.textColor        = [UIColor colorFromHex:@"#868686"];
            timeStrLabels.textAlignment    = NSTextAlignmentCenter;
            timeStrLabels.right            = washingCardLabel.right;
            timeStrLabels.top              = washingCardLabel.bottom+Main_Screen_Height*2/667;
        self.stepsLabel.top=downView.bottom+10*Main_Screen_Height/667;
        cycleScroll.top=self.stepsLabel.bottom+5*Main_Screen_Height/667;
    }else{
        int tagi=0;
        switch (self.second) {
            case 5:
                tagi=0;
                break;
            case 68:
                tagi=1;
                break;
            case 109:
                tagi=2;
                break;
            case 171:
                tagi=3;
                break;
            case 234:
                tagi=4;
                break;
            case 239:
                tagi=5;
                break;
            default:
                break;
        }
         NSString   *stepStrs     = self.stepsarrs[tagi];
         UIFont     *stepStrsFonts       = [UIFont systemFontOfSize:12];
        self.stepsLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*25/667) font:stepStrsFonts text:stepStrs isCenter:NO];
        self.stepsLabel.text             = stepStrs;
        self.stepsLabel.textColor        = [UIColor colorFromHex:@"#868686"];
        self.stepsLabel.textAlignment    = NSTextAlignmentCenter;
        self.stepsLabel.centerX            = self.contentView.centerX;
        self.stepsLabel.top              = titleView.bottom+10*Main_Screen_Height/667;
#pragma mark-洗车轮播图
        NSMutableArray * images = [NSMutableArray array];
        
        
        for (NSInteger i = 0; i<5; i++)
        {
            [images addObject:[NSString stringWithFormat:@"x%ld",i+1]];
        }
        
        
        cycleScroll =   [SXScrPageView direcWithtFrame:CGRectMake(0, 0, Main_Screen_Width*180/375, Main_Screen_Height*180/667) ImageArr:images AndImageClickBlock:^(NSInteger index) {
            //        NSLog(@"tag:%ld",index);
            //        DSAdDetailController *viewVC = [[DSAdDetailController alloc]init];
            //        viewVC.urlstr=[((NSDictionary *)weackself.newrc.adverList[index]) objectForKey:@"Url"];
            //        viewVC.hidesBottomBarWhenPushed = YES;
            //        [weackself.navigationController pushViewController:viewVC animated:YES];
            
        }];
        
        //    cycleScroll.top  =   0;
        //    cycleScroll.width = Main_Screen_Width;
        //    [backgroudView addSubview:sxView];
        //
        //
        //
        //    //网络图片加载
        //    cycleScroll = [[GCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*180/375, Main_Screen_Height*180/667)];
        //    cycleScroll.delegate =self;
        //
        //    cycleScroll.localImageGroups = images;
        //    cycleScroll.autoScrollTimeInterval = 3.0;
        //    cycleScroll.dotColor = [UIColor blueColor];
        //    cycleScroll.top  =   0;
        //    cycleScroll.width = Main_Screen_Width*180/375;
        cycleScroll.top=self.stepsLabel.bottom+25*Main_Screen_Height/667;
        //    cycleScroll.titleLabelTextColor=[UIColor blackColor];
        //    cycleScroll.titleLabelFont=[UIFont systemFontOfSize:12*Main_Screen_Height/667];
        //    cycleScroll.titles = [[NSArray alloc] initWithObjects:@"测试标题1",@"测试标题2",@"测试标题3", @"测试标题4",nil];
        cycleScroll.centerX=self.contentView.centerX;
        cycleScroll.backgroundColor=[UIColor clearColor];
        [self.contentView  addSubview:cycleScroll];
        

    
    }
    

    
    
    UIButton    *adButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    adButton.frame              = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*100/667);
    adButton.backgroundColor    = [UIColor redColor];
    [adButton setBackgroundImage:[UIImage imageNamed:@"guanggao33"] forState:UIControlStateNormal];
    [adButton addTarget:self action:@selector(adButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //    logoImageView.bottom        = self.contentView.height -Main_Screen_Height*80/667;
    if (Main_Screen_Height == 568) {
        adButton.bottom        = self.contentView.height -Main_Screen_Height*85/667;
    }
    if (Main_Screen_Height == 667) {
        adButton.bottom        = self.contentView.height -Main_Screen_Height*75/667;
    }
    if (Main_Screen_Height == 736) {
        adButton.bottom        = self.contentView.height -Main_Screen_Height*70/667;
    }
    
    adButton.centerX       = titleView.size.width/2;
    [self.contentView addSubview:adButton];
    
    
    UIButton    *adPageButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    adPageButton.frame              = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*100/667);
    adPageButton.backgroundColor    = [UIColor redColor];
    [adPageButton setBackgroundImage:[UIImage imageNamed:@"guanggao11"] forState:UIControlStateNormal];
    [adPageButton addTarget:self action:@selector(adPageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    adPageButton.bottom        = adButton.top -Main_Screen_Height*10/667;
    adPageButton.centerX       = titleView.size.width/2;
//    [self.contentView addSubview:adPageButton];
    
    
    
    
    
    
   
        
}
    

    


- (void) adButtonClick:(id)sender {
    
//    DSCompleteWashingController     *completeVC     = [[DSCompleteWashingController alloc]init];
//    completeVC.hidesBottomBarWhenPushed             = YES;
//    [self.navigationController pushViewController:completeVC animated:YES];
}

- (void) adPageButtonClick:(id)sender {
    
    
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

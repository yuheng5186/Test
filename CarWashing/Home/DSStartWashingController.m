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

#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "HomeViewController.h"
#import "DSScanController.h"
#import "DSInputCodeController.h"

#import "HYActivityView.h"
@interface DSStartWashingController ()<UIScrollViewDelegate,SetTabBarDelegate>
{
    SXScrPageView *cycleScroll;
    UIImageView   * adVertist;
    UIView        * backView;
    UIButton      * exitBtn;
}
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *timeNumLabel;
@property (nonatomic, strong) UILabel *stepsLabel;
@property (nonatomic, strong) NSArray *stepsarrs;
@property (nonatomic, assign) NSInteger endstr;
@property (strong, nonatomic) NSMutableArray *imageArray;//存放图片的数组
@property (strong, nonatomic) UIScrollView *ADScroll;//广告栏的底层ScrollView

@property (nonatomic, strong) NSDictionary *dicData;
@property (nonatomic, strong) UIView       * packView;
@property (nonatomic, strong) HYActivityView *activityView;
@end

@implementation DSStartWashingController

- (void) drawNavigation {
    self.stepsarrs=[[NSArray alloc]initWithObjects:@"底盘清洗",@"环绕泡沫",@"幻彩泡沫",@"高压冲洗",@"水蜡镀膜",@"风干处理", nil];
    [self drawTitle:@"蔷薇爱车"];
    [self drawBackButtonWithAction:@selector(backButtonClick:)];

}
- (void) backButtonClick:(id)sender {
    NSArray * a = self.navigationController.viewControllers;
    NSLog(@"%@",a);
    NSLog(@"%ld",self.endstr);
    if (self.endstr<0) {
    
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        // push将控制器压到栈中，栈是先进后出；pop是出栈：即将控制器从栈中取出。
        
        NSArray * a = self.navigationController.viewControllers;
        NSLog(@"%@",a);
        NSMutableArray *arrController = [NSMutableArray arrayWithArray:a];
        
        NSInteger VcCount = arrController.count;
        
        //最后一个vc是自己，(-2)是倒数第二个是上一个控制器。
        
        UIViewController *lastVC = arrController[VcCount - 1];
        if ([arrController[0] isKindOfClass:[DSScanController class]]||[arrController[1] isKindOfClass:[DSInputCodeController class]]) {
            self.tabBarController.selectedIndex = 0;
        }else{
            // 返回到倒数第三个控制器
            
            if([lastVC isKindOfClass:[HomeViewController class]]||[arrController[1] isKindOfClass:[DSInputCodeController class]]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            else
            {
                
                HomeViewController *earnVC = [[HomeViewController alloc]init];
                
                [arrController replaceObjectAtIndex:(VcCount - 1) withObject:earnVC];
                self.navigationController.viewControllers = arrController;
            }
        }
    
    }


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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.endstr=1;
    _imageArray = [NSMutableArray array];

//    self.second = 24;
    [self createSubView];
    
     [self startTimer];
   
    
    //假红包
    [self creatPacket];
    
    
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
    
//    float Offx = _ADScroll.contentOffset.x;
//    Offx += Main_Screen_Width;
//    [_ADScroll setContentOffset:CGPointMake(Offx, 0) animated:YES];
    
    
    int second = self.second%60;//秒
    
    int minutes = self.second/60%60;//分钟的。
    
    NSLog(@"================ %d",self.second);
    if (self.second == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"洗车成功" message:@"洗车结束，欢迎下次光临！" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.tabBarController.selectedIndex = 0;            
//            [self.navigationController popToRootViewControllerAnimated:YES];
            self.endstr=self.second;
            
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
        
        
        
        int tagi=0;
//        self.stepsLabel.text    = self.stepsarrs[tagi];
        if (self.second<=5&&0<self.second) {
            tagi=5;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *6, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];
        }else if (self.second<=68&&5<self.second){
            tagi=4;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *5, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];
        }else if (self.second<=109&&68<self.second){
            tagi=3;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *4, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];
        }else if (self.second<=171&&109<self.second){
            tagi=2;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *3, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];
        }else if (self.second<=234&&171<self.second){
            tagi=1;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *2, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];

        }else if (self.second<=240&&234<self.second){
            tagi=0;
            _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *1, 0);
            self.stepsLabel.text    = self.stepsarrs[tagi];
        }
//        switch (self.second) {
//            case 5:             //5
//                tagi=5;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *6, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            case 68:            //68
//                tagi=4;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *5, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            case 109:           //109
//                tagi=3;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *4, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            case 171:           // 171
//                tagi=2;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *3, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            case 234:           // 234
//                tagi=1;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *2, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            case 240:           //239
//                tagi=0;
//                _ADScroll.contentOffset = CGPointMake(Main_Screen_Width *1, 0);
//                self.stepsLabel.text    = self.stepsarrs[tagi];
//
//                break;
//            default:
//                break;
//        }

        self.stepsLabel.width   = Main_Screen_Width*100/375;
//        NSString *text  = [NSString stringWithFormat:@"%d%@",self.second--,@"秒钟"];
        
        NSString *text  = [NSString stringWithFormat:@"%d分%d秒",minutes,second];
        
        self.timeNumLabel.text  = text;
    }
    
    self.second--;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_ADScroll == scrollView) {
        //往左滑
        if (scrollView.contentOffset.x >= scrollView.contentSize.width - Main_Screen_Width ) {
            scrollView.contentOffset = CGPointMake(Main_Screen_Width, 0);
        }
        //往右滑
        if (scrollView.contentOffset.x <= 0) {
            scrollView.contentOffset = CGPointMake(Main_Screen_Width * _imageArray.count, 0); // 这里的4，是整个Image数组的个数。
        }
        //        if (page == 0) {
        //            [scrollView setContentOffset:CGPointMake(UIScreen_width * _imageArray.count, 0)];
        //
        //        }else if (page == _imageArray.count + 1){
        //            // 如果是第最后一页就跳转到数组第一个元素的地点
        //            [scrollView setContentOffset:CGPointMake(UIScreen_width, 0)];
        //        }
    }
}



- (void) createSubView {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
    titleView.top                      = Main_Screen_Height*10/667;
    titleView.centerX                  = Main_Screen_Width/2;
    
    
    NSString   *titleString     = @"精洗";
    
    UIFont     *titleFont       = [UIFont systemFontOfSize:14];
    UILabel *titleLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = Main_Screen_Width/4 -Main_Screen_Width*20/375;;
    titleLabel.top              = Main_Screen_Height*16/667;
    
    NSString   *modeString     = @"精洗模式";
    
    UIFont     *modeFont       = [UIFont systemFontOfSize:12];
    UILabel *modeLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:modeFont text:modeString isCenter:NO];
    modeLabel.text             = modeString;
    modeLabel.textColor        = [UIColor colorFromHex:@"#868686"];
    modeLabel.textAlignment    = NSTextAlignmentCenter;
    modeLabel.centerX          = titleLabel.centerX;
    modeLabel.top              = titleLabel.bottom+Main_Screen_Height*10/667;
    
    
    
    NSString   *scoreString     = [NSString stringWithFormat:@"%@积分",self.IntegralNum];
    UILabel *scoreLabel         = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667)];
    scoreLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:scoreString];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*Main_Screen_Height/667] range:NSMakeRange([scoreString length]-2, 2)];
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
    
    
    
    NSString   *timeNumString     = @"4分钟";
    
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
      
        NSString   *timeStr     = self.CardName.length==0?@"微信支付":self.CardName;
        
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
        
            NSString   *strings            = self.CardName.length==0?@"支付金额":[NSString stringWithFormat:@"我的%@",self.CardName];
            UIFont     *Fonts              = [UIFont systemFontOfSize:15];
            UILabel *washingLabels         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:Fonts text:strings isCenter:NO];
            washingLabels.text             = strings;
            washingLabels.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
            washingLabels.textAlignment    = NSTextAlignmentCenter;
            washingLabels.left             = Main_Screen_Height*12/375;
            washingLabels.top              = Main_Screen_Height*14/667;
//
        NSString   *timeStrs     =self.CardName.length==0?[NSString stringWithFormat:@"%@元",self.paynum]:[NSString stringWithFormat:@"剩余%@次",self.RemainCount];
            UIFont     *cardFont              = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
            UILabel *washingCardLabel         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:cardFont text:timeStrs isCenter:NO];
            washingCardLabel.text             = timeStrs;
            washingCardLabel.textColor        = [UIColor colorFromHex:@"#ff525a"];
            washingCardLabel.textAlignment    = NSTextAlignmentCenter;
            washingCardLabel.right            = Main_Screen_Width -Main_Screen_Height*12/375;
            washingCardLabel.top              = Main_Screen_Height*14/667;
        
        
        
//         NSString   *timeStrc     = [NSString stringWithFormat:@"剩余%@次",self.RemainCount];
//            UIFont     *timeStrFonts       = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
//            UILabel *timeStrLabels         = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*20/667) font:timeStrFonts text:timeStrs isCenter:NO];
//            timeStrLabels.text             = timeStrc;
//            timeStrLabels.textColor        = [UIColor colorFromHex:@"#868686"];
//            timeStrLabels.textAlignment    = NSTextAlignmentCenter;
//            timeStrLabels.right            = washingLabels.right;
//            timeStrLabels.top              = washingLabels.bottom+Main_Screen_Height*2/667;
        self.stepsLabel.top=downView.bottom+10*Main_Screen_Height/667;
        cycleScroll.top=self.stepsLabel.bottom+5*Main_Screen_Height/667;
        _ADScroll.top=self.stepsLabel.bottom+5*Main_Screen_Height/667;

        
    }else{
        
        
         NSString   *stepStrs     = @"";
         UIFont     *stepStrsFonts       = [UIFont systemFontOfSize:18];
        self.stepsLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*25/667) font:stepStrsFonts text:stepStrs isCenter:NO];
        self.stepsLabel.text             = stepStrs;
        self.stepsLabel.textColor        = [UIColor colorFromHex:@"#000000"];
        self.stepsLabel.textAlignment    = NSTextAlignmentCenter;
        self.stepsLabel.centerX            = self.contentView.centerX;
        self.stepsLabel.top              = titleView.bottom+50*Main_Screen_Height/667;
#pragma mark-洗车轮播图
        
        _ADScroll           = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*150/667)];
        _ADScroll.delegate  = self;
        _ADScroll.top       =   self.stepsLabel.bottom+25*Main_Screen_Height/667;
        _ADScroll.centerX   =  self.contentView.centerX;
        _ADScroll.backgroundColor   = [UIColor clearColor];
        [self.contentView addSubview:_ADScroll];
        
        NSArray *arr = @[[UIImage imageNamed:@"x1.png"],[UIImage imageNamed:@"x2.png"],[UIImage imageNamed:@"x3.png"],[UIImage imageNamed:@"x4.png"],[UIImage imageNamed:@"x5.png"],[UIImage imageNamed:@"x5.png"]];
        
//        NSArray *arr = @[@"http://www.pptbz.com/pptpic/UploadFiles_6909/201204/2012041411433867.jpg",@"http://pic25.nipic.com/20121112/5955207_224247025000_2.jpg",@"http://img10.3lian.com/c1/newpic/10/08/04.jpg",@"http://img3.imgtn.bdimg.com/it/u=2699593702,2049257415&fm=206&gp=0.jpg"];

        [_imageArray addObjectsFromArray:arr];
        int i = 0;
        for (; i < _imageArray.count; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.frame = CGRectMake(Main_Screen_Width * (i + 1), 0, Main_Screen_Width*150/375, Main_Screen_Height*150/667);
//            [img sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
             img.tag = i;
            [self loadGifWithImageView:img andimagestr:[NSString stringWithFormat:@"b%d",i+1]];
//            [img setImage:arr[i]];

           
            [_ADScroll addSubview:img];
            
        }
        
        // 将最后一张图片弄到第一张的位置
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, Main_Screen_Width, Main_Screen_Height/3)];
//        [img sd_setImageWithURL:[NSURL URLWithString:_imageArray[i-1]]];
        [img setImage:_imageArray[i-1]];
        [_ADScroll addSubview:img];
        // 将第一张图片放到最后位置，造成视觉上的循环
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Height * (i + 1), 50, Main_Screen_Width, Main_Screen_Height/3)];
//        [img0 sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]]];
        [img0 setImage:_imageArray[0]];
        [_ADScroll addSubview:img0];
        [_ADScroll setContentOffset:CGPointMake(Main_Screen_Width/3, 0)];//将起始位置设置在这里
        
        _ADScroll.pagingEnabled = YES;
        _ADScroll.scrollEnabled = NO;
        
        _ADScroll.showsHorizontalScrollIndicator = NO;
        _ADScroll.showsVerticalScrollIndicator = NO;
        _ADScroll.contentSize = CGSizeMake((i+2)*Main_Screen_Width, 0);
        
    }
    
    UIButton    *adButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    adButton.frame              = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*100/667);
    adButton.backgroundColor    = [UIColor redColor];
    [adButton setBackgroundImage:[UIImage imageNamed:@"banka_banner"] forState:UIControlStateNormal];
    [adButton addTarget:self action:@selector(adButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //    logoImageView.bottom        = self.contentView.height -Main_Screen_Height*80/667;
    adButton.bottom        = self.contentView.height -Main_Screen_Height*70/667;

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
    [adPageButton setBackgroundImage:[UIImage imageNamed:@"banka_banner"] forState:UIControlStateNormal];
    [adPageButton addTarget:self action:@selector(adPageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    adPageButton.bottom        = adButton.top -Main_Screen_Height*10/667;
    adPageButton.centerX       = titleView.size.width/2;
//    [self.contentView addSubview:adPageButton];
    
//    [self gifPlay6];
    
    adVertist = [[UIImageView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-100, Main_Screen_Width, 100)];
    //    [adVertist sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,dict[@"JsonData"][0][@"AdvertisImg"]]]];
    [adVertist sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.adverUrl]]];
    [self.contentView addSubview:adVertist];
    
}

#pragma mark - SDWebImage内部解析gif数据
- (void)loadGifWithImageView:(UIImageView *)myImgView andimagestr:(NSString *)imgestr
{
    NSString *path = [[NSBundle mainBundle] pathForResource:imgestr ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    myImgView.image = image;
}
    
//-(void)gifPlay6  {
//    UIImage  *image         = [UIImage sd_animatedGIFNamed:@"b1"];
//    UIImageView  *gifview   = [[UIImageView alloc]initWithFrame:CGRectMake(50,80,image.size.width, image.size.height)];
//    gifview.backgroundColor = [UIColor orangeColor];
//    gifview.image           = image;
//    [self.view addSubview:gifview];
//}

- (void) adButtonClick:(id)sender {
    self.tabBarController.selectedIndex = 3;
    
    NSArray     *array  = self.navigationController.viewControllers;
    NSArray *a = [NSArray arrayWithObject:array[0]];
    self.navigationController.viewControllers = a;
}

- (void) adPageButtonClick:(id)sender {
    
    self.tabBarController.selectedIndex = 3;
    
    NSArray     *array  = self.navigationController.viewControllers;
    NSArray *a = [NSArray arrayWithObject:array[0]];
    self.navigationController.viewControllers = a;
    
}

#pragma mark-----红包相关
-(void)creatPacket{
    backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha = 0.7;
    [self.view addSubview:backView];
//    UIImageView * ExitimageView = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width-50, 10, 50, 50)];
//    ExitimageView.image =[UIImage imageNamed:@"shoucang"];
//    [self.view addSubview:ExitimageView];
//    UIButton * exitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    exitBtn.frame =CGRectMake(Main_Screen_Width-100, 0, 100, 60);
//    [exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:exitBtn];
    
    self.packView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 545/2+75)];
    self.packView.centerX = Main_Screen_Width/2;
    self.packView.centerY = Main_Screen_Height/2;
    [self.view addSubview:self.packView];
    UIImageView * packimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.packView.frame.size.width, self.packView.frame.size.height-75)];
    packimageView.image =[UIImage imageNamed:@"hongbao"];
    packimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SharebtnClick)];
    [packimageView addGestureRecognizer:tap];
    [self.packView addSubview:packimageView];
    
//    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.packView.frame.size.width, 50)];
//    titleLabel.text = @"恭喜您获得10张洗车卡";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor =[UIColor whiteColor];
//    [self.packView addSubview:titleLabel];
//    UILabel * titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.packView.frame.size.width, 30)];
//    titleLabel1.text = @"马上分享给好友";
//    titleLabel1.textAlignment = NSTextAlignmentCenter;
//    titleLabel1.textColor =[UIColor whiteColor];
//    [self.packView addSubview:titleLabel1];
//    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.packView.frame.size.width, 30)];
//    titleLabel2.text = @"一起免费洗车";
//    titleLabel2.textAlignment = NSTextAlignmentCenter;
//    titleLabel2.textColor =[UIColor whiteColor];
//    [self.packView addSubview:titleLabel2];
    
    exitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame =CGRectMake(self.packView.frame.size.width/2-(35/2), self.packView.frame.size.height-35, 35, 35);
    [exitBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.packView addSubview:exitBtn];
    
//    //弹出动画
//    [self.view addSubview:self.redImageView];
    //设置初始帧
    self.packView.transform = CGAffineTransformMakeScale(0, 0);
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionLayoutSubviews) animations:^{
        self.packView.transform = CGAffineTransformIdentity;
    } completion:nil];
}
//退出按钮
-(void)exitBtnClick
{
    [backView removeFromSuperview];
    [exitBtn removeFromSuperview];
    [self.packView removeFromSuperview];
}
//点击分享
-(void)SharebtnClick
{
    if (!self.activityView)
    {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        self.activityView.delegate = self;
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            //创建发送对象实例
            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
            sendReq.bText = NO;//不使用文本信息
            sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
            
            //创建分享内容对象
            WXMediaMessage *urlMessage = [WXMediaMessage message];
            urlMessage.title = @"【蔷薇爱车】洗车红包等你来拿!";//分享标题
            urlMessage.description = @"手快者得，手慢者无";;//分享描述
            [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
            //创建多媒体对象
            WXWebpageObject *webObj = [WXWebpageObject object];
            webObj.webpageUrl = [NSString stringWithFormat:@"%@",self.ShareUrl];//分享链接
            //完成发送对象实例
            urlMessage.mediaObject = webObj;
            sendReq.message = urlMessage;
            
            //发送分享信息
            [WXApi sendReq:sendReq];
            
            
            self.tabBarController.tabBar.hidden = NO;
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            //创建发送对象实例
            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
            sendReq.bText = NO;//不使用文本信息
            sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
            
            //创建分享内容对象
            WXMediaMessage *urlMessage = [WXMediaMessage message];
            urlMessage.title = @"【蔷薇爱车】洗车红包等你来拿!";//分享标题
            urlMessage.description = @"手快者得，手慢者无";;//分享描述
            [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
            
            //创建多媒体对象
            WXWebpageObject *webObj = [WXWebpageObject object];
            webObj.webpageUrl = [NSString stringWithFormat:@"%@",self.ShareUrl];//分享链接
            
            //完成发送对象实例
            urlMessage.mediaObject = webObj;
            sendReq.message = urlMessage;
            
            //发送分享信息
            [WXApi sendReq:sendReq];
            
            self.tabBarController.tabBar.hidden = NO;
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    self.tabBarController.tabBar.hidden = YES;
    
    [self.activityView show];
}
@end

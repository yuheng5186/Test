//
//  XueCarFirendViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "XueCarFirendViewController.h"
#import "HotTopicViewController.h"
#import "UsedCarViewController.h"
#import "QuestionsViewController.h"
#import "InfoViewController.h"

#import "TLMenuButtonView.h"

// 发布相关
#import "CYPublishViewController.h"
#import "CYSecondcarViewController.h"
#import "CYDynamicShareViewController.h"
@interface XueCarFirendViewController ()<UITableViewDelegate>
{
    BOOL _ISShowMenuButton;
}
@property (nonatomic,strong) UIView * firstView;
@property (nonatomic,strong) UIView * secondView;
@property (nonatomic,strong) UIView * thridView;
@property (nonatomic,strong) UIView * fourthView;
@property (nonatomic, strong) TLMenuButtonView *tlMenuView ;
@property (nonatomic,strong) UIView * blackView;
@property (nonatomic,strong) UIButton * addbtn;
@property (nonatomic,weak)UIButton *selectedBtn;
@property (nonatomic,strong) NSMutableArray * btnArray;

@end

@implementation XueCarFirendViewController

- (void) drawNavigation {
    
    [self drawTitle:@"发现"];
}
//- (void) drawContent {
//    self.contentView.top        = 0;
//    self.contentView.height     = self.view.height;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopButton];
    _ISShowMenuButton = NO;
    
    
    [self.view addSubview:self.addbtn];
    
    TLMenuButtonView *tlMenuView =[TLMenuButtonView standardMenuView];
    tlMenuView.centerPoint = self.addbtn.center;
    __weak typeof(self) weakSelf = self;
    tlMenuView.clickAddButton = ^(NSInteger tag, UIColor *color){
        weakSelf.view.backgroundColor = color;
        _ISShowMenuButton = YES;
        [weakSelf clickAddButton:self.addbtn];
        NSLog(@"=====%ld",tag);
        if (tag==5) {//发布问题
            
            CYDynamicShareViewController *findController      = [[CYDynamicShareViewController alloc]init];
            findController.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:findController animated:YES];
            
        }else if (tag==3){//动态分享
            CYPublishViewController *findController      = [[CYPublishViewController alloc]init];
            findController.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:findController animated:YES];
        }else if (tag==1){//二手车信息
            CYSecondcarViewController *findController      = [[CYSecondcarViewController alloc]init];
            findController.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:findController animated:YES];
        }
        
        
    };
    _tlMenuView = tlMenuView;
}



-(void)setTopButton{
    
    //创建4个button
    NSArray *buttonNames = @[@"车友提问",@"热门话题",@"二手车信息",@"资讯"];
    for (int i = 0; i < buttonNames.count; i++) {
        UIButton *jackButton = [[UIButton alloc]initWithFrame:CGRectMake(i * (self.view.frame.size.width)/4, 64, (self.view.frame.size.width)/4, 44)];
        [jackButton setTitle:buttonNames[i] forState:(UIControlStateNormal)];
        jackButton.titleLabel.font = [UIFont systemFontOfSize:14];
        jackButton.backgroundColor = [UIColor whiteColor];
        [jackButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
        [jackButton setTitleColor:[UIColor colorWithRed:254/255.0 green:184/255.0 blue:71/255.0 alpha:1.0] forState:UIControlStateSelected];
        jackButton.tag = i;
        if (jackButton.tag == 0) {
            //第一个按钮默认选中
            jackButton.selected = YES;
            jackButton.titleLabel.font=[UIFont systemFontOfSize:15];
            //记录原按钮
            self.selectedBtn = jackButton;
        }
        [jackButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:jackButton];
        [self.btnArray addObject:jackButton];
    }       //for循环结束
    
    //添加scrollView
    _baseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    _baseView.pagingEnabled = YES;
    _baseView.delegate = self;
    _baseView.contentSize = CGSizeMake((self.view.frame.size.width)*4, self.view.frame.size.height-108);
    _baseView.showsHorizontalScrollIndicator = NO;

    //添加动画灰色条
    _amnationView = [[UIView alloc]initWithFrame:CGRectMake(0, 108, (self.view.frame.size.width)/4, 3)];
    _amnationView.backgroundColor = [UIColor colorWithRed:254/255.0 green:184/255.0 blue:71/255.0 alpha:1.0];
    [self.view addSubview:_amnationView];
    
    [_baseView addSubview:self.firstView];
    [_baseView addSubview:self.secondView];
    [_baseView addSubview:self.thridView];
    [_baseView addSubview:self.fourthView];

}

#pragma mark - 动画

//移动scrollView改变小灰条的位置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
//    NSLog(@"%f",_baseView.contentOffset.x/((self.view.frame.size.width)*4));
    CGFloat f =[[NSString stringWithFormat:@"%.2f",_baseView.contentOffset.x/((self.view.frame.size.width)*4)]floatValue];
//    NSLog(@"%.2f",f);
    NSInteger a;
    if ([[NSString stringWithFormat:@"%.2f",_baseView.contentOffset.x/((self.view.frame.size.width)*4)]floatValue]==0.00) {
         a=0;
        UIButton * sender = self.btnArray[a];
        //每当点击按钮时取消上次选中的
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        sender.titleLabel.font=[UIFont systemFontOfSize:15.0];
        //当前点击按钮选中
        sender.selected = YES;
        self.selectedBtn = sender;
    }else if ([[NSString stringWithFormat:@"%.2f",_baseView.contentOffset.x/((self.view.frame.size.width)*4)]floatValue]==0.25){
         a=1;
        UIButton * sender = self.btnArray[a];
        //每当点击按钮时取消上次选中的
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        sender.titleLabel.font=[UIFont systemFontOfSize:15.0];
        //当前点击按钮选中
        sender.selected = YES;
        self.selectedBtn = sender;
        
    }else if ([[NSString stringWithFormat:@"%.2f",_baseView.contentOffset.x/((self.view.frame.size.width)*4)]floatValue]==0.50){
         a=2;
        UIButton * sender = self.btnArray[a];
        //每当点击按钮时取消上次选中的
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        sender.titleLabel.font=[UIFont systemFontOfSize:15.0];
        //当前点击按钮选中
        sender.selected = YES;
        self.selectedBtn = sender;
    }else if ([[NSString stringWithFormat:@"%.2f",_baseView.contentOffset.x/((self.view.frame.size.width)*4)]floatValue]==0.75){
         a=3;
        UIButton * sender = self.btnArray[a];
        //每当点击按钮时取消上次选中的
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        sender.titleLabel.font=[UIFont systemFontOfSize:15.0];
        //当前点击按钮选中
        sender.selected = YES;
        self.selectedBtn = sender;
    }
    //动画效果
    [UIView animateWithDuration:0.1 animations:^{
        [_amnationView setFrame:CGRectMake(_baseView.contentOffset.x/((self.view.frame.size.width)*4)*(self.view.frame.size.width), 108, (self.view.frame.size.width)/4, 3)];
    }];
   

}






//因为小灰条根据scrollView移动，故只改变scrollView
-(void)buttonAction:(UIButton*)sender{
    [UIView animateWithDuration:1 animations:^{
        [_baseView setContentOffset:CGPointMake(sender.tag*(self.view.frame.size.width), 0) animated:YES];
    }];
}

//懒加载4个viewController
-(UIView *)firstView{
    if(_firstView==nil){
        _firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-108)];
        //添加子控制器
        QuestionsViewController * vc =[[QuestionsViewController alloc]init];
        [self addChildViewController:vc];
        [_firstView addSubview:vc.view];        
    }
    return _firstView;
}

-(UIView *)secondView{
    if(_secondView == nil){
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height-108)];
        HotTopicViewController * vc =[[HotTopicViewController alloc]init];
        [self addChildViewController:vc];
        [_secondView addSubview:vc.view];
    }
    return _secondView;
}

-(UIView *)thridView{
    if(_thridView == nil){
        _thridView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width*2, 0, Main_Screen_Width, Main_Screen_Height-108)];
        UsedCarViewController * vc =[[UsedCarViewController alloc]init];
        [self addChildViewController:vc];
        [_thridView addSubview:vc.view];

    }
    return _thridView;
}

-(UIView *)fourthView{
    if(_fourthView == nil){
        _fourthView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width*3, 0, Main_Screen_Width, Main_Screen_Height-108)];
        InfoViewController * vc =[[InfoViewController alloc]init];
        [self addChildViewController:vc];
        [_fourthView addSubview:vc.view];
    }
    return _fourthView;
}

#pragma mark----弹簧按钮下相关
- (void)clickAddButton:(UIButton *)sender{
    
    if (!_ISShowMenuButton) {
        [UIView animateWithDuration:0.2 animations:^{
            //            CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI / 4 );
            //            [sender setTransform:rotate];
            [_addbtn setImage:[UIImage imageNamed:@"fabu_guanbi"] forState:UIControlStateNormal];
        }];
        
        [self.view addSubview:self.blackView];
        [self.view addSubview:self.addbtn];
        [_tlMenuView showItems];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            //            CGAffineTransform rotate = CGAffineTransformMakeRotation( 0 );
            //            [sender setTransform:rotate];
            [_addbtn setImage:[UIImage imageNamed:@"fabuanniu"] forState:UIControlStateNormal];
            
        }];
        [_blackView removeFromSuperview];
        [_tlMenuView dismiss];
    }
    _ISShowMenuButton = !_ISShowMenuButton;
}
-(UIView *)blackView{
    if (_blackView==nil) {
        _blackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _blackView.backgroundColor=[UIColor blackColor];
        _blackView.alpha=0.3;
        
        ////////////////////
        
        
    }
    return _blackView;
}
-(UIButton*)addbtn{
    if (_addbtn==nil) {
        _addbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-(80*Main_Screen_Height/667), self.view.bounds.size.height-(180*Main_Screen_Height/667), 80*Main_Screen_Height/667, 80*Main_Screen_Height/667)];
        //        _addbtn.layer.cornerRadius = 27.5;
        //        _addbtn.backgroundColor = [UIColor grayColor];
        [_addbtn addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        [_addbtn setImage:[UIImage imageNamed:@"fabuanniu"] forState:UIControlStateNormal];
    }
    return _addbtn;
}
-(NSMutableArray *)btnArray
{
    if (_btnArray==nil) {
        _btnArray=[NSMutableArray array];
        
    }
    return _btnArray;
}
@end

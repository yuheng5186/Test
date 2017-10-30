//
//  TLMenuButtonView.m
//  MiShu
//
//  Created by tianlei on 16/6/24.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import "TLMenuButtonView.h"
#define ColorWithRGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:0.9]
#define kWindow [[UIApplication sharedApplication] keyWindow]

@interface TLMenuButtonView ()

@property (nonatomic, strong) TLMenuButton *menu1;

@property (nonatomic, strong) TLMenuButton *menu2;

@property (nonatomic, strong) TLMenuButton *menu3;

@property (nonatomic, strong) TLMenuButton *menu4;

@property (nonatomic, strong) TLMenuButton *menu5;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@end

static TLMenuButtonView *instanceMenuView;

@implementation TLMenuButtonView
- (instancetype)init{
    if (self = [super init]) {
//        [self ];
    }
    return self;
}
- (void)showItems{
    CGPoint center = self.centerPoint;
    CGFloat r = 180;
    CGPoint point1 = CGPointMake(center.x - 100, center.y+r*sin(M_PI/24));

    CGPoint point3 = CGPointMake(center.x - 100, center.y - r*sin(M_PI / 4-M_PI/12));

    CGPoint point5 = CGPointMake(center.x-r*sin(M_PI/24), center.y - r+10);
    
  
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.center = center;
    view1.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1)];
    UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageVIew.image=[UIImage imageNamed:@"ershouche"];
    [view1 addSubview:imageVIew];
    [view1 addGestureRecognizer:tap1];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, view1.frame.size.height-15, 100, 20)];
    titleLabel.text = @"二手车";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor whiteColor];
    [view1 addSubview:titleLabel];
    
//    TLMenuButton *menu1 = [TLMenuButton buttonWithTitle:@"二手车" imageTitle:@"icon_menu_general" center:center color:ColorWithRGB(93,198,78)];
//    menu1.tag = 1;
//    [menu1 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view3.userInteractionEnabled = YES;
    view3.center = center;
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3)];
    UIImageView * imageVIew1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageVIew1.image=[UIImage imageNamed:@"dongtai"];
    [view3 addSubview:imageVIew1];
    [view3 addGestureRecognizer:tap3];
    UILabel * titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, view3.frame.size.height-15, 100, 20)];
    titleLabel1.text = @"动态";
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor=[UIColor whiteColor];
    [view3 addSubview:titleLabel1];
   
//    TLMenuButton *menu3 = [TLMenuButton buttonWithTitle:@"动态" imageTitle:@"icon_menu_reim" center:center color:ColorWithRGB(93,198,78)];
//    menu3.tag = 3;
//    [menu3 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view5.userInteractionEnabled = YES;
    view5.center = center;
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap5)];
    [view5 addGestureRecognizer:tap5];
    UIImageView * imageVIew2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageVIew2.image=[UIImage imageNamed:@"tiwen"];
    [view5 addSubview:imageVIew2];
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, view5.frame.size.height-15, 100, 20)];
    titleLabel2.text = @"提问";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.textColor=[UIColor whiteColor];
    [view5 addSubview:titleLabel2];
//    TLMenuButton *menu5 = [TLMenuButton buttonWithTitle:@"提问" imageTitle:@"icon_menu_dayoff" center:center color:ColorWithRGB(87,211,200)];
//    menu5.tag = 5;
//    [menu5 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
    _view1 =view1;
    _view2 = view3;
    _view3 = view5;
//    _menu1 = menu1;
//
//    _menu3 = menu3;
//
//    _menu5 = menu5;
    _view1.alpha = 0;

    _view2.alpha = 0;

    _view3.alpha = 0;
    
    [kWindow addSubview:view1];

    [kWindow addSubview:view3];

    [kWindow addSubview:view5];
    
    [UIView animateWithDuration:0.2 animations:^{
        _view1.alpha = 1;

        _view2.alpha = 1;

        _view3.alpha = 1;
        _view1.center = point1;

        _view2.center = point3;

        _view3.center = point5;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        _view1.center = self.centerPoint;

        _view2.center = self.centerPoint;

        _view3.center = self.centerPoint;
        _view1.alpha = 0;

        _view2.alpha = 0;

        _view3.alpha = 0;
    } completion:^(BOOL finished) {
        [_view1 removeFromSuperview];

        [_view2 removeFromSuperview];

        [_view3 removeFromSuperview];
    }];
}

- (void)dismissAtNow{
    [_view1 removeFromSuperview];

    [_view2 removeFromSuperview];

    [_view3 removeFromSuperview];
}
-(void)tap1
{
    if (self.clickAddButton) {
        self.clickAddButton(1, nil );
    }
}
-(void)tap3
{
    if (self.clickAddButton) {
        self.clickAddButton(3, nil );
    }
}
-(void)tap5
{
    if (self.clickAddButton) {
        self.clickAddButton(5, nil );
    }
}
//- (void)_addExamApprovel:(UIButton *)sender{
//    
//    NSLog( @"%@", sender );
//    if (self.clickAddButton) {
//        self.clickAddButton(sender.tag, [sender valueForKey:@"backgroundColor"] );
//    }
//}
+ (instancetype)standardMenuView{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instanceMenuView = [[self alloc] init];
    });
    return instanceMenuView;
}
@end

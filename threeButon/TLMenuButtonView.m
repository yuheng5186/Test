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
    
  
    
    TLMenuButton *menu1 = [TLMenuButton buttonWithTitle:@"二手车" imageTitle:@"icon_menu_general" center:center color:ColorWithRGB(93,198,78)];
    menu1.tag = 1;
    [menu1 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
   
    TLMenuButton *menu3 = [TLMenuButton buttonWithTitle:@"动态" imageTitle:@"icon_menu_reim" center:center color:ColorWithRGB(93,198,78)];
    menu3.tag = 3;
    [menu3 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
   
    TLMenuButton *menu5 = [TLMenuButton buttonWithTitle:@"提问" imageTitle:@"icon_menu_dayoff" center:center color:ColorWithRGB(87,211,200)];
    menu5.tag = 5;
    [menu5 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
    _menu1 = menu1;

    _menu3 = menu3;

    _menu5 = menu5;
    _menu1.alpha = 0;

    _menu3.alpha = 0;

    _menu5.alpha = 0;
    
    [kWindow addSubview:menu1];

    [kWindow addSubview:menu3];

    [kWindow addSubview:menu5];
    
    [UIView animateWithDuration:0.2 animations:^{
        _menu1.alpha = 1;

        _menu3.alpha = 1;

        _menu5.alpha = 1;
        _menu1.center = point1;

        _menu3.center = point3;

        _menu5.center = point5;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        _menu1.center = self.centerPoint;

        _menu3.center = self.centerPoint;

        _menu5.center = self.centerPoint;
        _menu1.alpha = 0;

        _menu3.alpha = 0;

        _menu5.alpha = 0;
    } completion:^(BOOL finished) {
        [_menu1 removeFromSuperview];

        [_menu3 removeFromSuperview];

        [_menu5 removeFromSuperview];
    }];
}

- (void)dismissAtNow{
    [_menu1 removeFromSuperview];

    [_menu3 removeFromSuperview];

    [_menu5 removeFromSuperview];
}

- (void)_addExamApprovel:(UIButton *)sender{
    
    NSLog( @"%@", sender );
    if (self.clickAddButton) {
        self.clickAddButton(sender.tag, [sender valueForKey:@"backgroundColor"] );
    }
}
+ (instancetype)standardMenuView{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instanceMenuView = [[self alloc] init];
    });
    return instanceMenuView;
}
@end

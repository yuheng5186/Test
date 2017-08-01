//
//  DSCardGroupController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCardGroupController.h"
#import <Masonry.h>
#import "DiscountCategoryView.h"
#import "DiscountController.h"
#import "RechargeController.h"


@interface DSCardGroupController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIScrollView *cardScrollView;

@property (nonatomic, weak) DiscountCategoryView *categoryView;

@end


@implementation DSCardGroupController

- (void)drawNavigation {
    
    [self drawTitle:@"我的卡券" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupCategoryView];
    [self setupScrollView];
    
    [self addCardChildViewControllers];
    
}


- (void)addCardChildViewControllers{
    
    DiscountController *discountVC = [[DiscountController alloc] init] ;
    RechargeController *rechargeVC = [[RechargeController alloc] init];
    
    [self addChildViewController:discountVC];
    [self addChildViewController:rechargeVC];
    
    [_containerView addSubview:discountVC.view];
    [_containerView addSubview:rechargeVC.view];
    
    [discountVC didMoveToParentViewController:self];
    [rechargeVC didMoveToParentViewController:self];
    
    [discountVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(_containerView);
        make.size.equalTo(_cardScrollView);
    }];
    
    [rechargeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.leading.equalTo(discountVC.view.mas_trailing);
        make.size.equalTo(_cardScrollView);
    }];
    
}


#pragma mark - 设置分类视图
- (void)setupCategoryView{
    
    DiscountCategoryView *categoryView = [[DiscountCategoryView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    
    _categoryView = categoryView;
    
    [self.view addSubview:categoryView];
    
    categoryView.categoryBlock = ^(NSInteger index){
        
        //修改scrollView的contentOffset
        [self.cardScrollView setContentOffset:CGPointMake(index * self.cardScrollView.width, 0) animated:YES];
    };
}



#pragma mark - 布局scrollView
- (void)setupScrollView {
    
    
    
    UIScrollView *cardScrollView =  [[UIScrollView alloc] init];
    _cardScrollView = cardScrollView;
    
    cardScrollView.delegate = self;
    cardScrollView.bounces = NO;
    cardScrollView.pagingEnabled = YES;
    
    [self.view addSubview:cardScrollView];
    
    [cardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    
    //容器视图
    UIView *containerView = [[UIView alloc] init];
    _containerView = containerView;
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    [cardScrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cardScrollView);
        make.width.equalTo(cardScrollView).multipliedBy(2);
        make.height.equalTo(cardScrollView);
    }];
    
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x / 2;
        _categoryView.offsetX = offsetX;
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

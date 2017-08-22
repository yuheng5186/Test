//
//  DSFavoritesController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSFavoritesController.h"

#import "SalerListViewCell.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface DSFavoritesController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *favoriteListView;

@end

static NSString *id_salerListCell = @"salerListCell";

@implementation DSFavoritesController

- (UITableView *)favoriteListView{
    if (nil == _favoriteListView) {
        UITableView *favoriteListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
       
        [self.view addSubview:favoriteListView];
        _favoriteListView = favoriteListView;
    }
    
    return _favoriteListView;
}

- (void)drawNavigation {
    
    [self drawTitle:@"收藏"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
  self.favoriteListView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)setupUI {
    
    self.favoriteListView.delegate = self;
    self.favoriteListView.dataSource = self;
#pragma maek-空白页
    self.favoriteListView.emptyDataSetSource = self;
    self.favoriteListView.emptyDataSetDelegate = self;
    //可以去除tableView的多余的线，否则会影响美观
    self.favoriteListView.tableFooterView = [UIView new];
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.favoriteListView registerNib:nib forCellReuseIdentifier:id_salerListCell];
    
    self.favoriteListView.rowHeight = 110*Main_Screen_Height/667;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalerListViewCell *favoriCell = [tableView dequeueReusableCellWithIdentifier:id_salerListCell forIndexPath:indexPath];
//    favoriCell.backgroundColor=[UIColor redColor];

    return favoriCell;
}


#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"shoucang_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"shoucang_kongbai"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
//设置文字（上图下面的文字，我这个图片默认没有这个文字的）是富文本样式，扩展性很强！

//这个是设置标题文字的
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"客管你还没有收藏";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
}
//设置按钮的文本和按钮的背景图片

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
////    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
////    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
////    return [[NSAttributedString alloc] initWithString:@"点击上传照片" attributes:attributes];
//}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"button_image"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return NO;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    return NSLog(@"空白页按钮点击事件");
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f;
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

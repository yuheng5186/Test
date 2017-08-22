//
//  ShopCommentController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopCommentController.h"
#import "BusinessEstimateCell.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface ShopCommentController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *commentListView;

@end

static NSString *id_commentShopCell = @"id_commentShopCell";

@implementation ShopCommentController

- (UITableView *)commentListView{
    if (_commentListView == nil) {
        UITableView *commenListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _commentListView = commenListView;
        [self.view addSubview:commenListView];
    }
    return _commentListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentListView.delegate = self;
    self.commentListView.dataSource = self;
#pragma maek-空白页
    self.commentListView.emptyDataSetSource = self;
    self.commentListView.emptyDataSetDelegate = self;
    //可以去除tableView的多余的线，否则会影响美观
    self.commentListView.tableFooterView = [UIView new];
    [self.commentListView registerNib:[UINib nibWithNibName:@"BusinessEstimateCell" bundle:nil] forCellReuseIdentifier:id_commentShopCell];
    self.commentListView.rowHeight = 110*Main_Screen_Height/667;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessEstimateCell *commentCell = [tableView dequeueReusableCellWithIdentifier:id_commentShopCell forIndexPath:indexPath];
    
    return commentCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *commentTitleLabel = [[UILabel alloc] init];
    commentTitleLabel.text = @"  评价(58)";
    commentTitleLabel.backgroundColor = [UIColor colorFromHex:@"#dfdfdf"];
    commentTitleLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    commentTitleLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    
    return commentTitleLabel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40*Main_Screen_Height/667;
    
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pinglun_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"pinglun_kongbai"];
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
    NSString *text = @"暂无评价";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
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
    return -64.f-74;
}
@end

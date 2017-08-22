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

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "UdStorage.h"

@interface DSFavoritesController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *favoriteListView;

@property (nonatomic, strong) NSMutableArray *MyFavouriteMerchantData;

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
    self.MyFavouriteMerchantData = [[NSMutableArray alloc]init];
    [self getMyFavouriteMC];
    
    [self setupUI];
  self.favoriteListView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)getMyFavouriteMC
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"Ym":@31.192255,
                             @"Xm":@121.52334,
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/GetFavouriteMerchant",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        
        
        NSArray *arr = [NSArray array];
        arr = [dict objectForKey:@"JsonData"];
        [self.MyFavouriteMerchantData addObjectsFromArray:arr];
        [self.favoriteListView reloadData];
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];

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
    
    self.favoriteListView.rowHeight = 110;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.MyFavouriteMerchantData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalerListViewCell *favoriCell = [tableView dequeueReusableCellWithIdentifier:id_salerListCell forIndexPath:indexPath];
//    favoriCell.backgroundColor=[UIColor redColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row] objectForKey:@"Img"]];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            favoriCell.shopImageView.image = img;
        });
    });
    favoriCell.shopNameLabel.text = [[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
    favoriCell.shopAdressLabel.text = [[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"MerAddress"];
    //    salerListViewCell.freeTestLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
    //    salerListViewCell.qualityLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
    favoriCell.distanceLabel.text = [NSString stringWithFormat:@"%@km",[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"Distance"]];
    
    if([[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"ShopType"] intValue] == 1)
    {
        favoriCell.typeShopLabel.text = @"洗车服务";
    }
    
    
    
    favoriCell.ScoreLabel.text = [NSString stringWithFormat:@"%@分",[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"Score"]];
    
    [favoriCell.starView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"Score"]] substringToIndex:1]]]];
    
    NSArray *lab = [[[self.MyFavouriteMerchantData objectAtIndex:indexPath.row]objectForKey:@"MerFlag"] componentsSeparatedByString:@","];
    
    for (int i = 0; i < [lab count]; i++) {
        UILabel *MerflagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(115 + i % 3 * 67,  i / 3 * 25 + 88, 60, 15)];
        MerflagsLabel.text = lab[i];
        MerflagsLabel.backgroundColor = [UIColor redColor];
        [MerflagsLabel setFont:[UIFont fontWithName:@"Helvetica" size:11 ]];
        MerflagsLabel.textColor = [UIColor colorFromHex:@"#fefefe"];
        MerflagsLabel.backgroundColor = [UIColor colorFromHex:@"#ff7556"];
        MerflagsLabel.textAlignment = NSTextAlignmentCenter;
        MerflagsLabel.layer.masksToBounds = YES;
        MerflagsLabel.layer.cornerRadius = 7.5;
        [favoriCell.contentView addSubview:MerflagsLabel];
    }
    
    favoriCell.qualityLabel.hidden = YES;
    favoriCell.freeTestLabel.hidden = YES;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, favoriCell.contentView.frame.size.height -0.5,self.contentView.frame.size.width,0.5)];
    view2.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0f];
    [favoriCell.contentView addSubview:view2];
    
    favoriCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_favoriteListView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    

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

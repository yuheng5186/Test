//
//  MyCarPortController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyCarPortController.h"
#import <Masonry.h>
#import "MyCarViewCell.h"
#import "IcreaseCarController.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MyCar.h"
#import "UdStorage.h"

@interface MyCarPortController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


@property (nonatomic, weak) UIView *increaseView;

@property (nonatomic, weak) UITableView *carListView;

@property (nonatomic, strong) NSIndexPath *nowPath;

@property(nonatomic ,strong)NSMutableArray *mycararray;

@property(nonatomic ,strong)NSMutableArray *myDefaultcararray;

@end

static NSString *id_carListCell = @"id_carListCell";

@implementation MyCarPortController

- (UITableView *)carListView {
    
    if (_carListView == nil) {
        
        UITableView *carListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - (48+25+25)*Main_Screen_Height/667)];
        _carListView = carListView;
        [self.view addSubview:_carListView];
    }
    
    return _carListView;
}

//- (UIView *)increaseView {
//    
//    if (_increaseView == nil) {
//        
//        UIView *increaseView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60, Main_Screen_Width, 60)];
//        _increaseView = increaseView;
//        [self.view addSubview:_increaseView];
//    }
//    return _increaseView;
//}


- (void)drawNavigation {
    
    [self drawTitle:@"我的车库"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeincreaseMyCar:) name:@"increasemycarsuccess" object:nil];
    _mycararray = [[NSMutableArray alloc]init];
    
    _myDefaultcararray = [[NSMutableArray alloc]init];
    
    [self getMyCarData];
    
//    [self setupUI];
}

-(void)getMyCarData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/GetCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
//                MyCar *newcar = [[MyCar alloc]init];
                if([dic[@"IsDefaultFav"] intValue] == 1)
                {
//                    [newcar setValuesForKeysWithDictionary:dic];
                    [_myDefaultcararray addObject:dic];
                }
                else
                {
                    [_mycararray addObject:dic];
                }
                
            }
            
            
            [self setupUI];
            
            [_carListView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
            [self setupUI];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self setupUI];
    }];
    
}


- (void)setupUI {
    
    self.carListView.delegate = self;
    self.carListView.dataSource = self;
#pragma maek-空白页
    self.carListView.emptyDataSetSource = self;
    self.carListView.emptyDataSetDelegate = self;
    [self.carListView registerNib:[UINib nibWithNibName:@"MyCarViewCell" bundle:nil] forCellReuseIdentifier:id_carListCell];
    
    
    UIButton *increaseBtn = [UIUtil drawDefaultButton:self.view title:@"新增车辆" target:self action:@selector(didClickIncreaseButton)];
    
    [increaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-25*Main_Screen_Height/667);
    }];
}

#pragma mark - 数据源代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150*Main_Screen_Height/667;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if([_myDefaultcararray count] == 0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if([_myDefaultcararray count] != 0)
    {
        if(section == 1)
        {
            return [self.mycararray count];
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return [self.mycararray count];
    }

//    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([_myDefaultcararray count] != 0)
    {
        if(section == 1)
        {
            return 10*Main_Screen_Height/667;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCarViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carListCell];
    
    
    if([_myDefaultcararray count] != 0)
    {
        if(indexPath.section == 0)
        {
            carCell.manuLabel.text = [NSString stringWithFormat:@"%@年产",[[_myDefaultcararray objectAtIndex:indexPath.row] objectForKey:@"Manufacture"]];
            carCell.brandLabel.text = [[_myDefaultcararray objectAtIndex:indexPath.row] objectForKey:@"CarBrand"];
            carCell.defaultButton.selected = YES;
            carCell.defaultButton.enabled = NO;
            carCell.deleteButton.tag = indexPath.row+10000;
            [carCell.defaultButton setTitle:@"已默认" forState:UIControlStateNormal];
        }
        else
        {
            carCell.manuLabel.text = [NSString stringWithFormat:@"%@年产",[[_mycararray objectAtIndex:indexPath.row] objectForKey:@"Manufacture"]];
            carCell.brandLabel.text = [[_mycararray objectAtIndex:indexPath.row] objectForKey:@"CarBrand"];
            carCell.defaultButton.selected = NO;
            carCell.defaultButton.tag = indexPath.row;
            carCell.deleteButton.tag = indexPath.row;
            [carCell.defaultButton setTitle:@"设置默认" forState:UIControlStateNormal];
        }
    }
    else
    {
        carCell.manuLabel.text = [NSString stringWithFormat:@"%@年产",[[_mycararray objectAtIndex:indexPath.row] objectForKey:@"Manufacture"]];
        carCell.brandLabel.text = [[_mycararray objectAtIndex:indexPath.row] objectForKey:@"CarBrand"];
        carCell.defaultButton.selected = NO;
        carCell.defaultButton.tag = indexPath.row;
        carCell.deleteButton.tag = indexPath.row;
        [carCell.defaultButton setTitle:@"设置默认" forState:UIControlStateNormal];
    }
    
    
    
//    if (indexPath.section == self.nowPath.section) {
//        
//        carCell.defaultButton.selected = YES;
//        [carCell.defaultButton setTitle:@"已默认" forState:UIControlStateNormal];
//        
//    }else {
//        
//        carCell.defaultButton.selected = NO;
//        [carCell.defaultButton setTitle:@"设置默认" forState:UIControlStateNormal];
//        
//    }
    
    
    return carCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}



- (IBAction)didClickDefaultButton:(UIButton *)button {
    
    
    
//    UITableViewCell *cell = (UITableViewCell *) [[button superview] superview];
    
//    NSIndexPath *path = [self.carListView indexPathForCell:cell];
    
    //记录当下的indexpath
//    self.nowPath = path;
    
    
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"CarCode":[[_mycararray objectAtIndex:button.tag] objectForKey:@"CarCode"],
                                 @"ModifyType":@2,
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
                _mycararray = [[NSMutableArray alloc]init];
                _myDefaultcararray = [[NSMutableArray alloc]init];
                [self getMyCarData];
//                [self.carListView reloadData];
                NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
            }
            else
            {
                [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
        }];

    
    
    
    
    
    
}


- (IBAction)didClickDeleteButton:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除车辆信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
            
            if(sender.tag >= 10000)
            {
                NSDictionary *mulDic = @{
                                         @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                         @"CarCode":[[_myDefaultcararray objectAtIndex:sender.tag - 10000] objectForKey:@"CarCode"],
                                         @"ModifyType":@3,
                                         };
                NSDictionary *params = @{
                                         @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                         @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                         };
                [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
                    
                    if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                    {
                        [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
                        _mycararray = [[NSMutableArray alloc]init];
                        _myDefaultcararray = [[NSMutableArray alloc]init];
                        [self getMyCarData];
                        NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                    }
                    else
                    {
                        [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
                    }
                    
                } fail:^(NSError *error) {
                    [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
                }];
            }
            else
            {
                NSDictionary *mulDic = @{
                                         @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                         @"CarCode":[[_mycararray objectAtIndex:sender.tag] objectForKey:@"CarCode"],
                                         @"ModifyType":@3,
                                         };
                NSDictionary *params = @{
                                         @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                         @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                         };
                [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
                    
                    if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                    {
                        [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
                        _mycararray = [[NSMutableArray alloc]init];
                        _myDefaultcararray = [[NSMutableArray alloc]init];
                        [self getMyCarData];
                        NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                    }
                    else
                    {
                        [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
                    }
                    
                } fail:^(NSError *error) {
                    [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
                }];
            }

        
            
            
//        NSLog(@"%ld",sender.tag);
        
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - 新增车辆
- (void)didClickIncreaseButton {
    
    IcreaseCarController *increaseVC = [[IcreaseCarController alloc] init];
    increaseVC.hidesBottomBarWhenPushed = YES;
    increaseVC.titlename = @"新增车辆";
    [self.navigationController pushViewController:increaseVC animated:YES];
    
}

-(void)noticeincreaseMyCar:(NSNotification *)sender{
    _mycararray = [[NSMutableArray alloc]init];
    _myDefaultcararray = [[NSMutableArray alloc]init];
    [self getMyCarData];
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"cheku_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"cheku_kongbai"];
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
    NSString *text = @"小二已在此恭候你多时";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex: @"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
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
    return -64;
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

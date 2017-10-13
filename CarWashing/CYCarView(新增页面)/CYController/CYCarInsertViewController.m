//
//  CYCarInsertViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYCarInsertViewController.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "UdStorage.h"
#import "MBProgressHUD.h"
#import "CYSlideViewController.h"

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"


#import "CYCarRMListModel.h"
@interface CYCarInsertViewController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSMutableArray *_indexArr;//索引数组
    UILabel *_myindex;//中间索引view
    UILabel *_indexView;//右边索引view
    UIView  * headerView;
    UIView  * blakView;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) CYSlideViewController *currentVC;
@property (nonatomic, strong) NSDictionary *dicData;
@property (nonatomic, strong) NSMutableArray *RMListArray;
@property (nonatomic, strong) NSMutableArray *RMListArraySection;
@property (nonatomic, strong) NSMutableArray *RMListArrayRow;
@end

@implementation CYCarInsertViewController


- (void)drawNavigation {
    
    [self drawTitle:@"请选择品牌"];
    
}

-(void)getDta
{
//    NSDictionary *mulDic = @{
//                             @"City":self.citystr,
//                             @"Area":self.areastr,
//                             @"ShopType":@1,
//                             @"ServiceCode":[NSString stringWithFormat:@"10%ld",index+1],
//                             @"DefaultSort":DefaultSort,
//                             @"Ym":[UdStorage getObjectforKey:@"Ym"],
//                             @"Xm":[UdStorage getObjectforKey:@"Xm"],
//                             @"PageIndex":@0,
//                             @"PageSize":@10
//                             };
//    NSDictionary *params = @{
//                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
//                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
//                             };
//    NSLog(@"%@",params);
    [AFNetworkingTool post:nil andurl:[NSString stringWithFormat:@"%@MyCar/GetCarDropList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"车辆信息---%@",dict);
        self.dicData = dict;
        self.RMListArray = (NSMutableArray*)[CYCarRMListModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"RMList"][0][@"List"]];
        self.RMListArraySection = (NSMutableArray*)[CYCarRMListModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"ZMList"]];
        
//        NSArray * titleArr=@[@"宝马",@"奔驶",@"大众",@"劳斯莱斯",@"吉普",@"悍马"];
        if (self.RMListArray.count<=6) {
            headerView.frame= CGRectMake(0, 0, Main_Screen_Width, 135);
            blakView.frame = CGRectMake(0, 30, Main_Screen_Width, 105);
        }else if (self.RMListArray.count<=12){
            headerView.frame= CGRectMake(0, 0, Main_Screen_Width, 225);
            blakView.frame = CGRectMake(0, 30, Main_Screen_Width, 165);
        }
        CGFloat w = (Main_Screen_Width-30)/3;
        for (int i = 0; i < self.RMListArray.count; i++) {
            CYCarRMListModel * model = self.RMListArray[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15+i%3*w, 15+i/3*45, w-15, 30);
            [btn setTitle:[NSString stringWithFormat:@"%@",model.Title] forState:UIControlStateNormal];
            btn.tag=i+1;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor grayColor];
            [blakView addSubview:btn];
        }
        [self.tableview reloadData];
    } fail:^(NSError *error) {
         NSLog(@"---%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    _RMListArray = [NSMutableArray array];
    _RMListArraySection = [NSMutableArray array];
    _RMListArrayRow = [NSMutableArray array];
    [self getDta];
    CGFloat ViewWid=self.view.frame.size.width;
    CGFloat ViewHigt=self.view.frame.size.height;
    //   初始化tableview
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,64, ViewWid, ViewHigt-64) style:0];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 135+300)];
    headerView.backgroundColor=[UIColor whiteColor];
    _tableview.tableHeaderView = headerView;
    [self.view addSubview:_tableview];
    
    UIView * gralView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    gralView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [headerView addSubview:gralView];
    UILabel * titlelbael=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Main_Screen_Width-30, 30)];
    titlelbael.text = @"热门品牌";
    [gralView addSubview:titlelbael];
    
    blakView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, Main_Screen_Width, 105)];
    [headerView addSubview:blakView];
    
    
    
    //    初始化右边索引条
    _indexView=[[UILabel alloc]initWithFrame:CGRectMake(ViewWid-15,(ViewHigt-300)/2,13,380)];
    _indexView.numberOfLines=0;
    _indexView.font=[UIFont systemFontOfSize:12];
    _indexView.backgroundColor=[UIColor clearColor];
    _indexView.textAlignment=NSTextAlignmentCenter;
    _indexView.userInteractionEnabled=YES;
    _indexView.layer.cornerRadius=5;
    _indexView.layer.masksToBounds=YES;
    _indexView.alpha=0.7;
    [self.view addSubview:_indexView];
    //    初始化索引条内容
    _indexArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<26; i++)
    {
        NSString *str=[NSString stringWithFormat:@"%c",i+65];
        [_indexArr addObject:str];
        _indexView.text=i==0?str:[NSString stringWithFormat:@"%@\n%@",_indexView.text,str];
    }
//    //    初始化显示的索引view
//    _myindex=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    _myindex.font=[UIFont boldSystemFontOfSize:30];
//    _myindex.backgroundColor=RGBAA(153, 153, 153, 0.8);
//    _myindex.textColor=[UIColor whiteColor];
//    _myindex.textAlignment=NSTextAlignmentCenter;
//    _myindex.center=self.view.center;
//    _myindex.layer.cornerRadius=_myindex.frame.size.width/2;
//    _myindex.layer.masksToBounds=YES;
//    _myindex.alpha=0;
//    [self.view addSubview:_myindex];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pop) name:@"pop" object:nil];
    
    
    
}

//点击开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self myTouch:touches];
}


//点击进行中
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self myTouch:touches];
}

//点击结束
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 让中间的索引view消失
    [UIView animateWithDuration:1 animations:^{
        _myindex.alpha=0;
    }];
}

//点击会掉的方法
-(void)myTouch:(NSSet *)touches
{
    //    让中间的索引view出现
    [UIView animateWithDuration:0.3 animations:^{
        _myindex.alpha=1;
    }];
    //    获取点击的区域
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_indexView];
    int index=(int)((point.y/380)*26);
    NSLog(@"--%d",index);
    if (index>25||index<0)return;
    //    给显示的view赋标题
    _myindex.text=_indexArr[index];
    //    跳到tableview指定的区
    NSIndexPath *indpath=[NSIndexPath indexPathForRow:0 inSection:index];
    [_tableview  scrollToRowAtIndexPath:indpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
   
}
#pragma mark =----tableViewDelegate
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][@"ZMList"]];
    CYCarRMListModel * model = self.RMListArrayRow[section];
    return [NSString stringWithFormat:@"%@",model.Title];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return _indexArr.count;
    return self.RMListArraySection.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][@"ZMList"][section][@"List"]];
    NSLog(@"---%@",self.RMListArrayRow);
    return self.RMListArrayRow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundView = nil;
    }
     self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][@"ZMList"][indexPath.section][@"List"]];
    CYCarRMListModel * model = self.RMListArrayRow[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.Title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][@"ZMList"][indexPath.section][@"List"]];
    CYCarRMListModel * model = self.RMListArrayRow[indexPath.row];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:self.rightView];
        self.rightView.frame=CGRectMake(Main_Screen_Width-250, 64, 250, Main_Screen_Height-64);
    }];
    NSDictionary *dict;
    dict = @{@"color":[NSString stringWithFormat:@"%@",model.Title]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gb" object:nil userInfo:dict];
    
}
#pragma mark ------ 手势 -----
-(void)handleSwipeFrom:(UITapGestureRecognizer*)SwipeGesture
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.rightView.frame=CGRectMake(Main_Screen_Width+250, 64, 250, Main_Screen_Height-64);
    }];
}
#pragma mark ------ 懒加载 -----
-(UIView*)rightView{
    if (_rightView==nil) {
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width+250, 64, 250, Main_Screen_Height-64)];
        _rightView.userInteractionEnabled=YES;
        _rightView.backgroundColor=[UIColor redColor];
        UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.rightView addGestureRecognizer:recognizer];
        CYSlideViewController * first = [[CYSlideViewController alloc] init];
        [self addChildViewController:first];
        //addChildViewController 会调用 [child willMoveToParentViewController:self] 方法，但是不会调用 didMoveToParentViewController:方法，官方建议显示调用
        [first didMoveToParentViewController:self];
        [first.view setFrame:CGRectMake(0,0,_rightView.frame.size.width,_rightView.frame.size.height )];
        _currentVC = first;
        [_rightView addSubview:_currentVC.view];
        
    }
    return _rightView;
}
#pragma mark ------ Action -----
-(void)btnClick:(UIButton*)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:self.rightView];
        self.rightView.frame=CGRectMake(Main_Screen_Width-250, 64, 250, Main_Screen_Height-64);
    }];
    CYCarRMListModel * model = self.RMListArray[btn.tag-1];
    NSDictionary *dict;
    if (self.open == 1) {
        dict = @{@"color":[NSString stringWithFormat:@"%@",model.Title]};
    }else if (self.open == 2){
        dict = @{@"color":@"0"};
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gb" object:nil userInfo:dict];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  MyInteractMessageViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyInteractMessageViewController.h"
#import "MyInteractMessageCell.h"
#import "MyinteractModel.h"
@interface MyInteractMessageViewController ()<UITableViewDelegate,UITableViewDataSource,MyInteractMessageCelldelegate>
{
    UIButton * selectButton;
    NSArray * arr1;
    NSInteger show;
}
@property (nonatomic,weak)UIButton *selectedBtn;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation MyInteractMessageViewController
- (void) drawNavigation {
    [self drawTitle:@"我的消息"];
    
}
- (void) drawContent {
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    self.contentView.backgroundColor=[UIColor whiteColor];
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(74);
        make.width.mas_equalTo(Main_Screen_Width-160);
        make.height.mas_equalTo(50);
    }];
    CGFloat width = (Main_Screen_Width-170)/2;
    NSLog(@"--%f",width);
    NSArray * arr=@[@"评论",@"点赞"];
    for (int i =0; i<2; i++) {
        UIButton * TwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        TwoButton.frame =CGRectMake(5+i*width, 5, width, 40);
        [TwoButton setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        TwoButton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0*Main_Screen_Height/667];
        [TwoButton setBackgroundColor:RGBAA(242, 242, 242, 1.0)];
        [TwoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [TwoButton setTitleColor:[UIColor colorFromHex:@"#0161a1"] forState:UIControlStateSelected];
        TwoButton.tag=i+1;
        if (TwoButton.tag == 1) {
            //第一个按钮默认选中
            TwoButton.selected = YES;
            [TwoButton setBackgroundColor:[UIColor whiteColor]];
            //记录原按钮
            self.selectedBtn = TwoButton;
            
        }
        [TwoButton addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:TwoButton];
    }
    show = 0;
    [self.contentView addSubview:self.tableView];
    arr1 = @[@"我是你大爷",@"我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷1",@"我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷我是你大爷"];
    [self getData];
}
-(void)buttonBtnClick:(UIButton*)btn
{
    //每当点击按钮时取消上次选中的
    self.selectedBtn.selected = NO;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [self.selectedBtn setBackgroundColor:RGBAA(242, 242, 242, 1.0)];
    //当前点击按钮选中
    btn.selected = YES;
    self.selectedBtn = btn;
    if (btn.tag==1) {
        show = 0;
    }else if (btn.tag==2){
        show = 0;
    }
    [self getData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyinteractModel * model = self.dataArray[indexPath.row];
    NSString * str = [NSString stringWithFormat:@" %@: %@",model.actModelList[0][@"CommentUserName"],model.actModelList[0][@"Comment"]];
//    NSString * str=[NSString stringWithFormat:@"%@",arr1[indexPath.row]];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(Main_Screen_Width-72, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return 109+size.height;
//    return 107;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"cellID";
    MyInteractMessageCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInteractMessageCell" owner:self options:nil]lastObject];
        cell.delegate=self;
    }
    
//    cell.commentLabel.text=[NSString stringWithFormat:@"%@",arr1[indexPath.row]];
    [cell configCell:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark---cell的代理方法
-(void)cell:(UITableViewCell*)cell button:(NSInteger)btn
{
    NSIndexPath * cellIndex = [_tableView indexPathForCell:cell];
    NSLog(@"---%ld",cellIndex.row);
}
-(UITableView*)tableView{
    if (_tableView ==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 134, Main_Screen_Width, Main_Screen_Height-134) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(void)getData
{
    NSString * url =@"";
    if (show==0) {
        url = @"Activity/MyBicycleCircleComment";
    }else{
        url = @"Activity/MyBicycleCircleGive";
    }
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@%@",Khttp,url] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            //获取json数组

            self.dataArray = (NSMutableArray*)[MyinteractModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];

//            //没有数据的情况下显示
//            if (self.modelArray.count == 0) {
//                self.noneLabel.hidden = NO;
//            }else{
//                self.noneLabel.hidden = YES;
//            }
            
            
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end

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
#import "DSCarClubDetailController.h"
@interface MyInteractMessageViewController ()<UITableViewDelegate,UITableViewDataSource,MyInteractMessageCelldelegate>
{
    UIButton * selectButton;
    NSArray * arr1;
    NSInteger show;
}
@property (nonatomic,weak)UIButton *selectedBtn;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIView * CommentView;
@property (nonatomic,strong) UIView * PraiseView;
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
        show = 1;
    }
    [self getData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyinteractModel * model = self.dataArray[indexPath.row];
    NSString * str =@"";
    if (show==0) {
        str  = [NSString stringWithFormat:@" %@:  %@ 等%@人评论了你",model.actModelList[0][@"CommentUserName"],model.actModelList[0][@"Comment"],model.CommentCount];
    }else{
        str  = [NSString stringWithFormat:@" %@等%@人赞了你",model.Gives,model.GiveCount];
    }
   
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(Main_Screen_Width-72, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return 109+size.height;
//    return 107;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyinteractModel * model = self.dataArray[indexPath.row];
    static NSString * cellID =@"cellID";
    MyInteractMessageCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInteractMessageCell" owner:self options:nil]lastObject];
        cell.delegate=self;
    }
    
    [cell configCell:self.dataArray[indexPath.row]];
    if (show==0) {
        cell.commentLabel.text=[NSString stringWithFormat:@" %@:  %@ 等%@人评论了你",model.actModelList[0][@"CommentUserName"],model.actModelList[0][@"Comment"],model.CommentCount];
    }else{
         cell.commentLabel.text=[NSString stringWithFormat:@"%@等%@人赞了你",model.Gives,model.GiveCount];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyinteractModel * model = self.dataArray[indexPath.row];
    if ([model.ActivityType isEqualToString:@"2"]) {//车友提问
        DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
        detailController.comeTypeString = @"1";
        detailController.showType = @"高兴";
        detailController.hidesBottomBarWhenPushed       = YES;
        detailController.ActivityCode                   = model.ActivityCode;
        NSLog(@"模型中文章号%ld",(long)model.ActivityCode);
        [self.navigationController pushViewController:detailController animated:YES];
    }else if ([model.ActivityType isEqualToString:@"3"]){//热门话题
        DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
        detailController.comeTypeString = @"2";
        detailController.showType = @"高兴";
        detailController.hidesBottomBarWhenPushed       = YES;
        detailController.ActivityCode                   = model.ActivityCode;
        [self.navigationController pushViewController:detailController animated:YES];
    }else if ([model.ActivityType isEqualToString:@"5"]){//二手车
        DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
        detailController.hidesBottomBarWhenPushed       = YES;
        detailController.ActivityCode                   = model.ActivityCode;
        detailController.CarCode = model.ActivityCode;
        detailController.showType = @"二手车";
        detailController.loopNum = @"66";
        detailController.carBrithYear = @"2017";
        [self.navigationController pushViewController:detailController animated:YES];
    }
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
    [self.dataArray removeAllObjects];
    
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
        NSLog(@"--%@",dict);
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            //获取json数组
            self.dataArray = (NSMutableArray*)[MyinteractModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];

        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end

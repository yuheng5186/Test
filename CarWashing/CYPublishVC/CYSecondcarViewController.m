//
//  CYSecondcarViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYSecondcarViewController.h"
#import "CYCarInsertViewController.h"
#import "WSDatePickerView.h"
#import "ACMediaFrame.h"
#import "UIImage+ACGif.h"
@interface CYSecondcarViewController ()<UITextViewDelegate>
{
    UITextView * contentTextField;
    UILabel * numLabel;
    UILabel * placeHoldLabel;
    UILabel * BrandLabel;
    UILabel * yearLabel;
}
@property (nonatomic,strong)  UIScrollView   * backScrollerView;

@property (nonatomic,strong)  NSMutableArray * imageArr;
@property (strong, nonatomic) UIView         *photoImageView;
@property (strong, nonatomic) NSMutableArray         *photoArray;
@end

@implementation CYSecondcarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _photoArray =[NSMutableArray array];
    [self.view addSubview:self.backScrollerView];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel * navlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, Main_Screen_Width-40, 44)];
    navlabel.textColor=[UIColor whiteColor];
    navlabel.text=@"发布二手车信息";
    navlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navlabel];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame =CGRectMake(Main_Screen_Width-80, 20, 80, 44);
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];

    _imageArr=[NSMutableArray array];
    //选择车辆品牌
    BrandLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width-20, 50)];
    BrandLabel.text = @"选择车辆品牌";
    BrandLabel.textAlignment = NSTextAlignmentLeft;
    [self.backScrollerView addSubview:BrandLabel];
    UIImageView * rightImage =[[UIImageView alloc]init];
    rightImage.image =[UIImage imageNamed:@"chakandaijinquan-jiantou"];
    [self.backScrollerView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(BrandLabel.mas_centerY);
        make.right.mas_equalTo(self.backScrollerView.mas_right).mas_offset(self.backScrollerView.width-20);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    UIView * line1 =[[UIView alloc]initWithFrame:CGRectMake(10, 49, Main_Screen_Width-10, 1)];
    line1.backgroundColor= [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.backScrollerView addSubview:line1];
    

    //选择生产年份
    yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, Main_Screen_Width-20, 50)];
    yearLabel.text = @"选择生产年份";
    yearLabel.textAlignment = NSTextAlignmentLeft;
    [self.backScrollerView addSubview:yearLabel];
    UIImageView * rightImage1 =[[UIImageView alloc]init];
    rightImage1.image =[UIImage imageNamed:@"chakandaijinquan-jiantou"];
    [self.backScrollerView addSubview:rightImage1];
    [rightImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yearLabel.mas_centerY);
        make.right.mas_equalTo(self.backScrollerView.mas_right).mas_offset(self.backScrollerView.width-20);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    UIView * line2 =[[UIView alloc]initWithFrame:CGRectMake(10, 99, Main_Screen_Width-10, 1)];
    line2.backgroundColor= [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.backScrollerView addSubview:line2];
    //填写行驶里程
    UITextField * distanceTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,100 ,  Main_Screen_Width-20, 50)];
    distanceTextField.placeholder = @"填写行驶里程";
    [self.backScrollerView addSubview:distanceTextField];
    UIView * line3 =[[UIView alloc]initWithFrame:CGRectMake(10, 149, Main_Screen_Width-10, 1)];
    line3.backgroundColor= [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.backScrollerView addSubview:line3];
    //意见
    contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(10, 150, Main_Screen_Width-20, 80)];
    contentTextField.backgroundColor=[UIColor colorFromHex:@"#f6f6f6"];
    contentTextField.delegate=self;
    [self.backScrollerView addSubview:contentTextField];
    placeHoldLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, Main_Screen_Width-20, 40)];
    placeHoldLabel.text=@"描述您的车辆情况～(例如：车况怎么样？外观情况？保养情况等信息...)";
    placeHoldLabel.numberOfLines = 2;
    placeHoldLabel.font=[UIFont systemFontOfSize:13.0];
    placeHoldLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.backScrollerView addSubview:placeHoldLabel];
    numLabel = [[UILabel alloc]init];
    numLabel.text =@"最多输入400字";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font=[UIFont systemFontOfSize:13.0];
    numLabel.textColor=[UIColor blackColor];
    [self.backScrollerView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentTextField.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(contentTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    //图片
    _photoImageView =[[UIView alloc]init];
    _photoImageView.backgroundColor=[UIColor whiteColor];
    [self.backScrollerView addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextField.mas_bottom);
        make.left.mas_equalTo(contentTextField.mas_left);
        make.right.mas_equalTo(contentTextField.mas_right);
        make.height.mas_equalTo(300);
    }];
    CGFloat height = [ACSelectMediaView defaultViewHeight];
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, height)];
    mediaView.type = ACMediaTypePhoto;
    mediaView.allowMultipleSelection = NO;
    _photoArray = mediaView.mediaArray;
    mediaView.naviBarBgColor = [UIColor colorFromHex:@"#0161a1"];
    [_photoImageView addSubview:mediaView];
    
    //for button
    for (int i=0; i<2; i++) {
        UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame=CGRectMake(0, i*50, Main_Screen_Width, 50);
        selectBtn.tag=i+1;
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backScrollerView addSubview:selectBtn];
    }
    //通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editCarInformation:) name:@"editCarIndorMation" object:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    placeHoldLabel.text =nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (contentTextField.contentSize.height >= 500) {
        contentTextField.frame = CGRectMake(0,500- contentTextField.contentSize.height , 200, 60 + contentTextField.contentSize.height);
    }else{
        contentTextField.frame = CGRectMake(0, 150, Main_Screen_Width, 60 + contentTextField.contentSize.height);
    }
    //对字数进行限制
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = 400 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        numLabel.text = [NSString stringWithFormat:@"%lu/400",contentTextField.text.length+1];
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};

        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];

            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }

    
    
}
-(void)selectBtnClick:(UIButton*)btn
{
    if (btn.tag==1) {
        CYCarInsertViewController * increaseVC = [[CYCarInsertViewController alloc]init];
        increaseVC.hidesBottomBarWhenPushed = YES;
        increaseVC.CyTYpe = @"编辑车辆信息";
        [self.navigationController pushViewController:increaseVC animated:YES];
    }else if (btn.tag==2){
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            NSLog(@"选择的日期：%@",date);
            yearLabel.text = [NSString stringWithFormat:@"%@",date];
        }];
        datepicker.dateLabelColor = [UIColor colorFromHex:@"#0161a1"];//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor colorFromHex:@"#0161a1"];//确定按钮的颜色
        [datepicker show];
    }
}
-(void)editCarInformation:(NSNotification *)notification{
    BrandLabel.text = [NSString stringWithFormat:@"%@-%@",notification.userInfo[@"CYCarname"],notification.userInfo[@"CYCarType"]] ;
}

#pragma mark---选取的图片数组
-(void)rightbtnClick
{
    NSLog(@"图片--%@",_photoArray);
    for (int i=0; i<_photoArray.count; i++) {
        ACMediaModel * model = _photoArray[i];
        NSLog(@"--%@",model.image);
    }
    
}
#pragma mark ----懒加载
-(UIScrollView *)backScrollerView
{
    if (_backScrollerView ==nil) {
        _backScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
        _backScrollerView.contentSize=CGSizeMake(Main_Screen_Width, 1000);
        _backScrollerView.backgroundColor=[UIColor whiteColor];
    }
    return _backScrollerView;
}
@end

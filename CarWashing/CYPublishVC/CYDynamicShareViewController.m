//
//  CYDynamicShareViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYDynamicShareViewController.h"
#import "CXXChooseImageViewController.h"
@interface CYDynamicShareViewController ()<UITextViewDelegate,CXXChooseImageViewControllerDelegate,UITextFieldDelegate>
{
    UITextView * contentTextField;
    UITextField * titleTextField;
    UILabel * numLabel;
    UILabel * placeHoldLabel;
}
@property (nonatomic,strong)  UIScrollView   * backScrollerView;
@property (nonatomic, strong) CXXChooseImageViewController *vc;
@property (nonatomic,strong)  NSMutableArray * imageArr;
@property (strong, nonatomic) UIScrollView         *photoImageView;
@end

@implementation CYDynamicShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel * navlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, Main_Screen_Width-40, 44)];
    navlabel.textColor=[UIColor whiteColor];
    navlabel.text=@"动态分享";
    navlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navlabel];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame =CGRectMake(Main_Screen_Width-80, 20, 80, 44);
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    
    [self.view addSubview:self.backScrollerView];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    _imageArr=[NSMutableArray array];
    //选择车辆品牌
    UILabel * BrandLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width-20, 50)];
    BrandLabel.text = @"你问题是什么？（必填，限40字）";
    BrandLabel.textAlignment = NSTextAlignmentLeft;
    [self.backScrollerView addSubview:BrandLabel];
   
    UIView * line1 =[[UIView alloc]initWithFrame:CGRectMake(10, 49, Main_Screen_Width-10, 1)];
    line1.backgroundColor= [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.backScrollerView addSubview:line1];
    
    //问题
    titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,50,Main_Screen_Width-20, 50)];
    titleTextField.delegate=self;
    titleTextField.placeholder = @"请输入您的问题";
    [self.backScrollerView addSubview:titleTextField];
    //内容
    //意见
    contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(10, 100, Main_Screen_Width-20, 100)];
    contentTextField.backgroundColor=[UIColor colorFromHex:@"#f6f6f6"];
    contentTextField.delegate=self;
    [self.backScrollerView addSubview:contentTextField];
    placeHoldLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, Main_Screen_Width-20, 40)];
    placeHoldLabel.text=@"请详细描述您的问题";
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
    _photoImageView =[[UIScrollView alloc]init];
    _photoImageView.contentSize =CGSizeMake(750, 100);
    _photoImageView.backgroundColor=[UIColor whiteColor];
    [self.backScrollerView addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextField.mas_bottom);
        make.left.mas_equalTo(contentTextField.mas_left);
        make.right.mas_equalTo(contentTextField.mas_right);
        make.height.mas_equalTo(100);
    }];
    //上传图片相关
    CXXChooseImageViewController *vc = [[CXXChooseImageViewController alloc] init];
    self.imageArr=vc.dataArr;
    vc.delegate = self;
    self.vc = vc;
    [self addChildViewController:vc];
    
    [vc setOrigin:CGPointMake(0, 0) ItemSize:CGSizeMake(60, 60) rowCount:6]; //注意要满足 ItemSize的宽度 * rowCount < 屏幕宽度
    [_photoImageView addSubview:vc.view];
    vc.maxImageCount = 9;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger caninputlen = 40 - comcatstr.length;
    
    if (caninputlen >= 0)
    {

        return YES;
    }
    return NO;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    placeHoldLabel.text =nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (contentTextField.contentSize.height >= 500) {
        contentTextField.frame = CGRectMake(0,500- contentTextField.contentSize.height , 200, 100 + contentTextField.contentSize.height);
    }else{
        contentTextField.frame = CGRectMake(0, 100, Main_Screen_Width, 100 + contentTextField.contentSize.height);
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

-(void)rightbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

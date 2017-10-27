//
//  CYPublishViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYPublishViewController.h"
#import "CXXChooseImageViewController.h"
@interface CYPublishViewController ()<UITextViewDelegate,CXXChooseImageViewControllerDelegate>
{
    UITextView * contentTextField;
    UILabel * numLabel;
    UILabel * placeHoldLabel;
}
@property (nonatomic,strong)  UIScrollView   * backScrollerView;
@property (nonatomic, strong) CXXChooseImageViewController *vc;
@property (nonatomic,strong)  NSMutableArray * imageArr;
@property (strong, nonatomic) UIScrollView         *photoImageView;
@end

@implementation CYPublishViewController
//- (void) drawContent {
//
//    self.contentView.height     = self.view.height;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backScrollerView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    _imageArr=[NSMutableArray array];
    UILabel * navlabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, Main_Screen_Width-160, 44)];
    navlabel.textColor=[UIColor whiteColor];
    navlabel.text=@"发布问题";
    navlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navlabel];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame =CGRectMake(Main_Screen_Width-80, 20, 80, 44);
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [self.view addSubview:self.backScrollerView];
    
    contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    contentTextField.backgroundColor=[UIColor colorFromHex:@"#f6f6f6"];
    contentTextField.delegate=self;
    [self.backScrollerView addSubview:contentTextField];
    placeHoldLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width, 20)];
    placeHoldLabel.text=@"一起来聊聊开车中发生有趣的事吧～";
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
    _photoImageView =[[UIScrollView alloc]init];
    _photoImageView.contentSize =CGSizeMake(750, 100);
    _photoImageView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
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

    [vc setOrigin:CGPointMake(0, 0) ItemSize:CGSizeMake(60, 60) rowCount:5]; //注意要满足 ItemSize的宽度 * rowCount < 屏幕宽度
    [_photoImageView addSubview:vc.view];
    vc.maxImageCount = 9;
    
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
- (void)textViewDidBeginEditing:(UITextView *)textView{
     placeHoldLabel.text =nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (contentTextField.contentSize.height >= 500) {
        contentTextField.frame = CGRectMake(0,500- contentTextField.contentSize.height , 200, 30 + contentTextField.contentSize.height);
    }else{
        contentTextField.frame = CGRectMake(0, 0, Main_Screen_Width, 30 + contentTextField.contentSize.height);
    }
    //对字数进行限制
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = 400 - comcatstr.length;
    
    if (caninputlen >= 0&&caninputlen<=399)
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
@end

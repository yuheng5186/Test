//
//  LoginViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuTabBarController.h"
#import "AppDelegate.h"
#import "DSAgreementController.h"


@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *userMobileFieldText;
@property (nonatomic, strong) UITextField *verifyFieldText;

@end

@implementation LoginViewController

- (void) drawNavigation {

//    [self drawTitle:@"登录" Color:[UIColor blackColor]];
}

- (void) drawContent {
    
    self.statusView.backgroundColor         = [UIColor whiteColor];
    self.navigationView.hidden              = YES;
    self.contentView.backgroundColor        = [UIColor whiteColor];
    self.contentView.top                    = self.statusView.bottom;
    self.contentView.height                 = self.view.height;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
}

- (void) createSubView {

    NSString   *headerString     = @"登录";
    UIFont     *headerFont       = [UIFont systemFontOfSize:20];
    UILabel *deaderLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:headerFont text:headerString isCenter:NO];
    deaderLabel.textColor        = [UIColor blackColor];
    deaderLabel.textAlignment    = NSTextAlignmentCenter;

    deaderLabel.centerX          = Main_Screen_Width/2;
    deaderLabel.top              = Main_Screen_Height*20/667;
    
//    UIImage *logoImage          = [UIImage imageNamed:@"WechatIMG3"];
    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*100/667) imageName:@"WechatIMG3"];
    logoImageView.top           = deaderLabel.bottom +Main_Screen_Height*30/667;
    logoImageView.centerX       = Main_Screen_Width/2;
    
    NSString   *titleString     = @"金顶洗车";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:titleString];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-20 * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:25];
    UILabel *titleLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.attributedText   = attributed;
    titleLabel.transform        = matrix;
    titleLabel.textAlignment    = NSTextAlignmentCenter;

    
    titleLabel.centerX          = Main_Screen_Width/2;
    titleLabel.top              = logoImageView.bottom +Main_Screen_Height*20/667;
    
    NSString   *welcomeString     = @"欢迎登录金顶洗车APP";
    UIFont     *welcomeFont       = [UIFont systemFontOfSize:14];
    UILabel *welcomeLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:welcomeFont text:welcomeString isCenter:NO];
    welcomeLabel.textColor        = [UIColor colorFromHex:@"#febb02"];
    welcomeLabel.textAlignment    = NSTextAlignmentCenter;
    welcomeLabel.centerX          = Main_Screen_Width/2;
    welcomeLabel.top              = titleLabel.bottom +Main_Screen_Height*10/667;
    

//    UIImage *backgroundImage            = [UIImage imageNamed:@"dengluditu"];
    UIImageView  *backgroundImageView   = [UIUtil drawCustomImgViewInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width-10, Main_Screen_Height*380/667) imageName:@"dengluditu"];
    backgroundImageView.top             = welcomeLabel.bottom;
    backgroundImageView.centerX         = Main_Screen_Width/2;
    
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*280/375,Main_Screen_Height*90/667) style:UITableViewStyleGrouped];
    self.tableView.top              = backgroundImageView.top +Main_Screen_Height*100/667;
    self.tableView.centerX          = backgroundImageView.centerX;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.tableView.tableFooterView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    
    NSString   *remindString     = @"新用户验证码登录即可完成注册";
    UIFont     *remindFont       = [UIFont systemFontOfSize:12];
    UILabel *remindLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*250/375, Main_Screen_Height*30/667) font:remindFont text:remindString isCenter:NO];
    remindLabel.textColor        = [UIColor colorFromHex:@"#999999"];
    remindLabel.textAlignment    = NSTextAlignmentCenter;
    remindLabel.centerX          = Main_Screen_Width/2;
    remindLabel.top              = self.tableView.bottom +Main_Screen_Height*20/667;
    
    NSString *buttonString        = @"登录";
    UIFont   *buttonFont          = [UIFont systemFontOfSize:16];
    UIButton  *loginButton        = [UIUtil drawButtonInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*280/375, Main_Screen_Height*45/667) text:buttonString font:buttonFont color:[UIColor colorFromHex:@"#ffffff"] target:self action:@selector(loginButtonClick:)];
    loginButton.backgroundColor   = [UIColor colorFromHex:@"#febb02"];
    loginButton.tintColor         = [UIColor whiteColor];
    loginButton.layer.cornerRadius  = 5;
    loginButton.bottom            = backgroundImageView.bottom -Main_Screen_Height*65/667;
    loginButton.centerX           = Main_Screen_Width/2;
    
    
    UIButton *updateRuleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*30/667)];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册即为同意《金顶洗车用户服务协议》"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 6)];
    [updateRuleButton setAttributedTitle:title forState:UIControlStateNormal];
    [updateRuleButton setBackgroundColor:[UIColor clearColor]];
    [updateRuleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [updateRuleButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    updateRuleButton.top              = loginButton.bottom +Main_Screen_Height*20/667;
    updateRuleButton.centerX          = loginButton.centerX;
    [self.contentView addSubview:updateRuleButton];
    
    
}
- (void) loginButtonClick:(id)sender {

    
        MenuTabBarController *menuTabBarController              = [[MenuTabBarController alloc] init];
        [AppDelegate sharedInstance].window.rootViewController  = menuTabBarController;
    

}

- (void) agreeButtonClick:(id)sender {

    DSAgreementController *agreeController      = [[DSAgreementController alloc]init];
    agreeController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:agreeController animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    //    cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
    if (indexPath.row == 0) {
        cell.imageView.image                = [UIImage imageNamed:@"yonghushouji"];
        
        self.userMobileFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150, Main_Screen_Height*40/667)];
        self.userMobileFieldText.placeholder    = @"请输入手机号码";
        self.userMobileFieldText.delegate       = self;
        self.userMobileFieldText.returnKeyType  = UIReturnKeyDone;
        self.userMobileFieldText.textAlignment  = NSTextAlignmentLeft;
        self.userMobileFieldText.font           = [UIFont systemFontOfSize:16];
        self.userMobileFieldText.backgroundColor= [UIColor whiteColor];
        self.userMobileFieldText.centerY        = cell.centerY;
        self.userMobileFieldText.left           = Main_Screen_Width*50/375 ;
        
        [self.userMobileFieldText addTarget:self action:@selector(userPhoneFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.userMobileFieldText];
        
    }else
    {
        cell.imageView.image                = [UIImage imageNamed:@"mimayanzheng"];
        
        self.verifyFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*260/375, Main_Screen_Height*40/667)];
        self.verifyFieldText.placeholder    = @"输入验证码";
        self.verifyFieldText.delegate       = self;
        self.verifyFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyFieldText.font           = [UIFont systemFontOfSize:16];
        //        self.verifyFieldText.backgroundColor= [UIColor grayColor];
        self.verifyFieldText.centerY        = cell.centerY;
        self.verifyFieldText.left           = Main_Screen_Width*50/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(verifyFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyFieldText];
        
        NSString *getVeriifyString      = @"获取验证码";
        UIFont *getVeriifyStringFont          = [UIFont systemFontOfSize:14];
        UIButton *getVeriifyStringButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*95/375, Main_Screen_Height*28/667) text:getVeriifyString font:getVeriifyStringFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyByButtonClick:)];
        getVeriifyStringButton.backgroundColor=  [UIColor colorWithHex:0xFFB500 alpha:1.0];
        getVeriifyStringButton.layer.cornerRadius = 14;
        getVeriifyStringButton.right          = self.tableView.width;
        getVeriifyStringButton.centerY        = self.verifyFieldText.centerY;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}


- (void) userPhoneFieldTextChanged:(UITextField *)sender {
    
    
}
- (void) verifyFieldChanged: (UITextField *) sender
{
    
}
- (void) getVeriifyByButtonClick:(id)sender {
    
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

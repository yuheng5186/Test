//
//  DSPasswordController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSPasswordController.h"

@interface DSPasswordController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *verifyFieldText;
@property (nonatomic, strong) UITextField *passwordNewFieldText;
@property (nonatomic, strong) UITextField *passwordAgainFieldText;



@end

@implementation DSPasswordController

- (void)drawNavigation {
    
    [self drawTitle:@"密码管理" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.top                = self.statusView.bottom;
    self.contentView.height             = self.view.height;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}

- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*280/667) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
//    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    
    UIButton *submitButton      = [UIUtil drawDefaultButton:self.contentView title:@"提交" target:self action:@selector(submitButtonClick:)];
    submitButton.top           = self.tableView.bottom +Main_Screen_Height*30/667;
    submitButton.centerX       = Main_Screen_Width/2;
    
}
- (void) submitButtonClick:(id)sender {

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"15800781856";
    }else if (indexPath.row == 1){
    
        self.verifyFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-240, 40)];
        self.verifyFieldText.placeholder    = @"输入验证码";
        self.verifyFieldText.delegate       = self;
        self.verifyFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyFieldText.font           = [UIFont systemFontOfSize:16];
        self.verifyFieldText.backgroundColor= [UIColor grayColor];
        self.verifyFieldText.centerY        = cell.centerY+Main_Screen_Height*8/667;
        self.verifyFieldText.left           = Main_Screen_Width*90/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(verifyFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyFieldText];
        
        NSString *getVeriifyString      = @"获取验证码";
        UIFont *getVeriifyStringFont          = [UIFont systemFontOfSize:16];
        UIButton *getVeriifyStringButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, 110, 40) text:getVeriifyString font:getVeriifyStringFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyButtonClick:)];
        getVeriifyStringButton.backgroundColor=  [UIColor colorWithHex:0xFFB500 alpha:1.0];
        getVeriifyStringButton.layer.cornerRadius = 20;
        getVeriifyStringButton.left           = self.verifyFieldText.right +Main_Screen_Width*10/375;
        getVeriifyStringButton.centerY        = self.verifyFieldText.centerY;
        
    }else if (indexPath.row == 2){
        self.passwordNewFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-150, 40)];
        self.passwordNewFieldText.placeholder    = @"请输入新密码";
        self.passwordNewFieldText.delegate       = self;
        self.passwordNewFieldText.returnKeyType  = UIReturnKeyDone;
        self.passwordNewFieldText.textAlignment  = NSTextAlignmentLeft;
        self.passwordNewFieldText.font           = [UIFont systemFontOfSize:16];
        self.passwordNewFieldText.backgroundColor= [UIColor whiteColor];
        self.passwordNewFieldText.centerY        = cell.centerY +Main_Screen_Height*8/667;
        self.passwordNewFieldText.left           = Main_Screen_Width*90/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(passwordNewFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.passwordNewFieldText];
    }else {
        self.passwordAgainFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-150, 40)];
        self.passwordAgainFieldText.placeholder    = @"再次输入密码";
        self.passwordAgainFieldText.delegate       = self;
        self.passwordAgainFieldText.returnKeyType  = UIReturnKeyDone;
        self.passwordAgainFieldText.textAlignment  = NSTextAlignmentLeft;
        self.passwordAgainFieldText.font           = [UIFont systemFontOfSize:16];
        self.passwordAgainFieldText.backgroundColor= [UIColor whiteColor];
        self.passwordAgainFieldText.centerY        = cell.centerY +Main_Screen_Height*8/667;
        self.passwordAgainFieldText.left           = Main_Screen_Width*90/375 ;
        
        [self.passwordAgainFieldText addTarget:self action:@selector(passwordAgainFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.passwordAgainFieldText];
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


- (void) verifyFieldTextChanged: (UITextField *) sender
{

}
- (void) getVeriifyButtonClick:(id)sender {
    
}

- (void) passwordNewFieldTextChanged: (UITextField *) sender
{
    
}
- (void) passwordAgainFieldTextChanged: (UITextField *) sender
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {

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

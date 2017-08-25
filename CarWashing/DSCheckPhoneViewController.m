//
//  DSCheckPhoneViewController.m
//  CarWashing
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCheckPhoneViewController.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "UdStorage.h"
#import "HTTPDefine.h"
#import "AppDelegate.h"

@interface DSCheckPhoneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *phoneNumberText;
@property (nonatomic, strong) UITextField *verifyNumberFieldText;

@end

@implementation DSCheckPhoneViewController

- (void)drawNavigation {
    
    [self drawTitle:@"修改手机号"];
    
}

- (void) drawContent
{
    self.contentView.top                = self.statusView.bottom;
    self.contentView.height             = self.view.height;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}

- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*180/667) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    //    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIButton *nextButton      = [UIUtil drawDefaultButton:self.contentView title:@"下一步" target:self action:@selector(nextButtonClick:)];
    nextButton.top           = self.tableView.bottom +Main_Screen_Height*30/667;
    nextButton.centerX       = Main_Screen_Width/2;
    
}
- (void) nextButtonClick:(id)sender {
    
}

#pragma mark-获取短信验证码
-(void)requestVerifyNumAndPhoneNum:(NSString *)phoneNum{
//    NSDictionary *mulDic = @{@"Mobile":phoneNum};
//    
//    NSDictionary *params = @{
//                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
//                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
//                             };
//    
//    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/GetVerCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        NSLog(@"%@",dict);
//        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
//        {
//            self.verifyNumberString=[[dict objectForKey:@"JsonData"] objectForKey:@"VerCode"];
//            [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
//        }else{
//            [self.view showInfo:@"验证码发送失败" autoHidden:YES interval:2];
//            
//        }
//        
//    } fail:^(NSError *error) {
//        NSLog(@"%@",@"fail");
//    }];
    
}

#pragma mark-修改手机号
-(void)updateUserphone:(NSString *)Userphone andverifyNumberStr:(NSString *)verifyNumberstr{
//    NSDictionary *mulDic = @{
//                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
//                             @"ModifyType":@"3",
//                             @"Mobile":Userphone,
//                             @"VerCode":verifyNumberstr
//                             };
//    NSDictionary *params = @{
//                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
//                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
//                             };
//    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/UserInfoEdit",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        
//        NSLog(@"==%@==",dict);
//        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
//        {
//            
//            [UdStorage storageObject:Userphone forKey:UserPhone];
//            NSNotification * notice = [NSNotification notificationWithName:@"updatephonesuccess" object:nil userInfo:@{@"userphone":Userphone}];
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            QWPersonInfoDetailViewController *personVC=[[QWPersonInfoDetailViewController alloc]init];
//            [self.navigationController popToViewController:personVC animated:YES];
//        }
//        else
//        {
//            [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
//        }
//        
//    } fail:^(NSError *error) {
//        NSLog(@"==+++%@+++",error);
//        [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
//    }];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Main_Screen_Height*50/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    if (indexPath.row == 0) {
        self.phoneNumberText                = [[UITextField alloc]initWithFrame:CGRectMake(Main_Screen_Width*10/375, Main_Screen_Height*45/667, Main_Screen_Width-Main_Screen_Width*240/375, Main_Screen_Height*40/667)];
        //        self.phoneNumberText.placeholder    = @"输入验证码";
        self.phoneNumberText.placeholder    = @"请输入新的手机号";
        self.phoneNumberText.delegate       = self;
        self.phoneNumberText.returnKeyType  = UIReturnKeyDone;
        self.phoneNumberText.keyboardType   = UIKeyboardTypeNumberPad;
        self.phoneNumberText.textAlignment  = NSTextAlignmentLeft;
        self.phoneNumberText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.phoneNumberText.backgroundColor= [UIColor whiteColor];
        self.phoneNumberText.top            = Main_Screen_Height*5/667;
        self.phoneNumberText.left           = Main_Screen_Width*10/375 ;
        
        [self.phoneNumberText addTarget:self action:@selector(phoneNumberTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.phoneNumberText];
        
        NSString *getVeriifyStr      = @"获取验证码";
        UIFont *getVeriifyStrFont          = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        UIButton *getVeriifyStrButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*110/375, Main_Screen_Height*30/667) text:getVeriifyStr font:getVeriifyStrFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyBtnClick:)];
        getVeriifyStrButton.backgroundColor= [UIColor colorWithHex:0xFFB500 alpha:1.0];
        getVeriifyStrButton.layer.cornerRadius = Main_Screen_Height*15/667;
        getVeriifyStrButton.right          = Main_Screen_Width -Main_Screen_Width*10/375;
        getVeriifyStrButton.top            = Main_Screen_Height*10/667;
    }else if (indexPath.row == 1){
        self.verifyNumberFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.verifyNumberFieldText.placeholder    = @"请输入验证码";
        self.verifyNumberFieldText.delegate       = self;
        self.verifyNumberFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyNumberFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyNumberFieldText.keyboardType   = UIKeyboardTypeNumberPad;
        
        self.verifyNumberFieldText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.verifyNumberFieldText.backgroundColor= [UIColor whiteColor];
        self.verifyNumberFieldText.top            = Main_Screen_Height*5/667;
        self.verifyNumberFieldText.left           = Main_Screen_Width*10/375;
        
        [self.verifyNumberFieldText addTarget:self action:@selector(verifyNumberFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyNumberFieldText];
        
        
    }else {
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void) phoneNumberTextChanged:(UITextField *)sender {
    
}
- (void) getVeriifyBtnClick:(id)sender {
    
}

- (void) verifyNumberFieldTextChanged:(UITextField *)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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

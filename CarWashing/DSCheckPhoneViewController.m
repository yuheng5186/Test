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
#import "DSUserInfoController.h"
@interface DSCheckPhoneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *phoneNumberText;
@property (nonatomic, strong) UITextField *verifyNumberFieldText;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int second;
@property(nonatomic,strong)NSString *verifyNumberString;
@property (nonatomic, strong)UIButton *getVeriifyStrButton;

@property (nonatomic, strong) UIButton *resendFakeBtn;
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
    
    UIButton *nextButton      = [UIUtil drawDefaultButton:self.contentView title:@"保存" target:self action:@selector(nextButtonClick:)];
    nextButton.top           = self.tableView.bottom +Main_Screen_Height*30/667;
    nextButton.centerX       = Main_Screen_Width/2;
    
}
- (void) nextButtonClick:(id)sender {

        if (self.phoneNumberText.text.length == 11) {
            if (self.verifyNumberFieldText.text.length == 4) {
                //请求数据
                [self updateUserphone:self.phoneNumberText.text andverifyNumberStr:self.verifyNumberFieldText.text];
            }
            else{
                [self.view showInfo:@"请输入4位验证码！" autoHidden:YES interval:2];
            }
            
        }else {
            [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        }
    
    
}

#pragma mark-获取短信验证码
-(void)requestVerifyNumAndPhoneNum:(NSString *)phoneNum{
    if (self.phoneNumberText.text.length == 11) {
        
        
        [self startTimer];
        [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
        
        NSDictionary *mulDic = @{@"Mobile":self.phoneNumberText.text};
        
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/GetVerCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                self.verifyNumberString=[[dict objectForKey:@"JsonData"] objectForKey:@"VerCode"];
                [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
            }else{
                [self.view showInfo:@"验证码发送失败" autoHidden:YES interval:2];
                
            }
            NSLog(@"%@",dict);
        } fail:^(NSError *error) {
            NSLog(@"%@",@"fail");
        }];
        
    }else
    {
        [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        
    }
    
}

#pragma mark-修改手机号
-(void)updateUserphone:(NSString *)Userphone andverifyNumberStr:(NSString *)verifyNumberstr{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ModifyType":@"3",
                             @"Mobile":Userphone,
                             @"VerCode":verifyNumberstr
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/UserInfoEdit",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"==%@==",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            [UdStorage storageObject:Userphone forKey:@"Mobile"];
            APPDELEGATE.currentUser.userPhone = Userphone;
            NSNotification * notice = [NSNotification notificationWithName:@"updatephonesuccess" object:nil userInfo:@{@"userphone":Userphone}];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            int index=[[self.navigationController viewControllers]indexOfObject:self];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
            
            [UdStorage storageObject:APPDELEGATE.currentUser.userName forKey:@"Name"];
            [UdStorage storageObject:APPDELEGATE.currentUser.Accountname forKey:@"UserName"];
            [UdStorage storageObject:APPDELEGATE.currentUser.userImagePath forKey:@"Headimg"];
            [UdStorage storageObject:APPDELEGATE.currentUser.userSex forKey:@"Sex"];
            [UdStorage storageObject:APPDELEGATE.currentUser.userAge forKey:@"Age"];
            [UdStorage storageObject:APPDELEGATE.currentUser.userPhone forKey:@"Mobile"];
            
            
        }
        else
        {
            [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"==+++%@+++",error);
        [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
    }];
    
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
       self.getVeriifyStrButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*110/375, Main_Screen_Height*30/667) text:getVeriifyStr font:getVeriifyStrFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyBtnClick:)];
         self.getVeriifyStrButton.backgroundColor= [UIColor colorWithHex:0xFFB500 alpha:1.0];
         self.getVeriifyStrButton.layer.cornerRadius = Main_Screen_Height*15/667;
         self.getVeriifyStrButton.right          = Main_Screen_Width -Main_Screen_Width*10/375;
         self.getVeriifyStrButton.top            = Main_Screen_Height*10/667;
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
    if (self.phoneNumberText.text.length == 11) {
        
        
        [self startTimer];
        [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
        
        NSDictionary *mulDic = @{@"Mobile":self.phoneNumberText.text};
        
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/GetVerCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                self.verifyNumberString=[[dict objectForKey:@"JsonData"] objectForKey:@"VerCode"];
                [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
            }else{
                [self.view showInfo:@"验证码发送失败" autoHidden:YES interval:2];
                
            }
            NSLog(@"%@",dict);
        } fail:^(NSError *error) {
            NSLog(@"%@",@"fail");
        }];
        
    }else
    {
        [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        
    }
    
}
- (void)startTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.second = 10;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [self.timer fire];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)onTimer
{
    if (self.second == 0) {
        
        [self.view showInfo:@"未收到验证码，请点击重新发送！" autoHidden:YES interval:2];
        self.getVeriifyStrButton.hidden = NO;
        self.resendFakeBtn.hidden = NO;
        self.getVeriifyStrButton.enabled = YES;
        self.resendFakeBtn.enabled = YES;
        [self.getVeriifyStrButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        
    } else {
        //        self.resendBtn.hidden = YES;
        self.getVeriifyStrButton.enabled = NO;
        self.resendFakeBtn.enabled = NO;
       
        NSString *text = [NSString stringWithFormat:@"%d%@",self.second--,@"s"];
        [self.getVeriifyStrButton setTitle:text forState:UIControlStateNormal];
    }
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

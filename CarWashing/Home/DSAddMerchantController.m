//
//  DSAddMerchantController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAddMerchantController.h"

@interface DSAddMerchantController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *merchantFieldText;
@property (nonatomic, strong) UITextField *phoneFieldText;
@property (nonatomic, strong) UITextField *addressFieldText;

@end

@implementation DSAddMerchantController

- (void) drawNavigation {

    [self drawTitle:@"商家入驻"];
    [self drawRightTextButton:@"提交" action:@selector(rightButtonClick:)];
}

- (void) drawContent
{
    self.contentView.top                = self.statusView.bottom;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#111112"];
    
}
- (void) rightButtonClick:(id)sender {

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
}

- (void) createSubView {

    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = -Main_Screen_Height*10/667;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.textLabel.textColor    = [UIColor colorFromHex:@"#999999"];
    if (indexPath.section == 0) {
        cell.textLabel.text                   = @"商家名称";
        self.merchantFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.merchantFieldText.placeholder    = @"请填写商家名称";
        self.merchantFieldText.delegate       = self;
        self.merchantFieldText.returnKeyType  = UIReturnKeyDone;
        self.merchantFieldText.textAlignment  = NSTextAlignmentLeft;
        self.merchantFieldText.font           = [UIFont systemFontOfSize:14];
        self.merchantFieldText.backgroundColor= [UIColor whiteColor];
        self.merchantFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
        self.merchantFieldText.left           = Main_Screen_Width*120/375 ;
        
        [self.merchantFieldText addTarget:self action:@selector(merchantFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.merchantFieldText];
        
    }else if (indexPath.section == 1){
        
        cell.textLabel.text                = @"联系电话";
        self.phoneFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.phoneFieldText.placeholder    = @"请填写联系电话";
        self.phoneFieldText.delegate       = self;
        self.phoneFieldText.returnKeyType  = UIReturnKeyDone;
        self.phoneFieldText.textAlignment  = NSTextAlignmentLeft;
        self.phoneFieldText.font           = [UIFont systemFontOfSize:14];
        self.phoneFieldText.backgroundColor= [UIColor whiteColor];
        self.phoneFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
        self.phoneFieldText.left           = Main_Screen_Width*120/375 ;
        
        [self.phoneFieldText addTarget:self action:@selector(phoneFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.phoneFieldText];
    }
    else{
        cell.textLabel.text                  = @"联系地址";
        self.addressFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.addressFieldText.placeholder    = @"请填写联系地址";
        self.addressFieldText.delegate       = self;
        self.addressFieldText.returnKeyType  = UIReturnKeyDone;
        self.addressFieldText.textAlignment  = NSTextAlignmentLeft;
        self.addressFieldText.font           = [UIFont systemFontOfSize:14];
        self.addressFieldText.backgroundColor= [UIColor whiteColor];
        self.addressFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
        self.addressFieldText.left           = Main_Screen_Width*120/375 ;
        
        [self.addressFieldText addTarget:self action:@selector(addressFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.addressFieldText];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (void) merchantFieldTextChanged:(UITextField *)sender {

    
}
- (void) phoneFieldTextChanged:(UITextField *)sender {
    
    
}
- (void) addressFieldTextChanged:(UITextField *)sender {
    
    
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

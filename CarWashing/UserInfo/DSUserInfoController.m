//
//  DSUserInfoController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSUserInfoController.h"
#import "AppDelegate.h"
#import "DSChangePhoneController.h"
#import "DSChangeNameController.h"
#import<AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureDevice.h>



@interface DSUserInfoController ()<UITableViewDelegate,UITableViewDataSource,LKActionSheetDelegate,LKAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *sexString;
@property (nonatomic, strong) UIImageView *userImageView;

@end

@implementation DSUserInfoController

- (void)drawNavigation {
    
    [self drawTitle:@"个人信息"];
    
}


- (void) drawContent
{
    self.contentView.top                = self.statusView.bottom;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#111112"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sexString = @"未填写";
    [self createSubView];

}

- (void) createSubView {
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
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
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        cell.textLabel.text     = @"头像";
        self.userImageView  = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, cell.contentView.centerY-11, 60, 60) imageName:@"gerenxinxitou"];
        self.userImageView.left          = Main_Screen_Width*280/375;
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text         = @"昵称";
            cell.detailTextLabel.text   = @"15800781856";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text         = @"手机号";
            NSString  *number = @"15800781856";
            NSString *userName              = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

            cell.detailTextLabel.text   = userName;
        }
        else {
            cell.textLabel.text         = @"性别";
            cell.detailTextLabel.text   = self.sexString;
        }
        
    }
    else{
        cell.textLabel.text         = @"微信绑定";
        cell.detailTextLabel.text   = @"去绑定";
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            //无权限 做一个友好的提示
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]; [alart show]; return ;
        } else {
            LKActionSheet *avatarSheet  = [[LKActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
            avatarSheet.tag             = 1001;
            [avatarSheet showInView:[AppDelegate sharedInstance].window.rootViewController.view];
        }
        
        
        

        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            DSChangeNameController  *changeNameController   = [[DSChangeNameController alloc]init];
            changeNameController.hidesBottomBarWhenPushed   = YES;
            [self.navigationController pushViewController:changeNameController animated:YES];
            
        }else if (indexPath.row == 1){
        
            DSChangePhoneController *changePhone    = [[DSChangePhoneController alloc]init];
            changePhone.hidesBottomBarWhenPushed    = YES;
            [self.navigationController pushViewController:changePhone animated:YES];
            
        }else {
            LKActionSheet *actionSheet = [[LKActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
            
            
            [actionSheet showInView:[AppDelegate sharedInstance].window.rootViewController.view];
        }
    }else {
    
        LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:nil message:@"”金顶洗车“想要打开“微信”" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认"];
        [alartView show];
    }
}

#pragma mark - LKActionSheetDelegate
- (void)actionSheet:(LKActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1001) {
        
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
                    UIImagePickerController *picker     = [[UIImagePickerController alloc] init];
                    picker.sourceType                   = sourceType;
                    picker.delegate                     = self;
                    picker.allowsEditing                = YES;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            case 1:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
                    UIImagePickerController *picker     = [[UIImagePickerController alloc] init];
                    picker.sourceType                   = sourceType;
                    picker.delegate                     = self;
                    picker.allowsEditing                = YES;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }

    }
    else {
        UITableViewCell *cell   = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        switch (buttonIndex) {
            case 0:
            {
                self.sexString = @"男";
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
                break;
            case 1:
            {
                self.sexString = @"女";
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
                break;
            default:
                break;
        }
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagePick = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self processImage:imagePick];
}

- (void)processImage:(UIImage *)image
{
    self.userImageView.image = image;
}


#pragma mark ---LKAlertViewDelegate---
- (void)alertView:(LKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == 0) {
            
        }else{
            
            
        }
    
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

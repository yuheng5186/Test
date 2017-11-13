//
//  CareRemindViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CareRemindViewController.h"
#import "RemindViewController.h"
#import "AddCareRemindViewController.h"

@interface CareRemindViewController ()

@end

@implementation CareRemindViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fakeNavigation];
    [self.view addSubview:self.afterView];
    //需要判断是否已经添加保养提醒,目前直接写在这里,点击“添加”按钮时隐藏添加View
    [self.view addSubview:self.addView];
    
    //底部按钮
    UIButton *nearByButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-50, Main_Screen_Width, 50)];
    [nearByButton setTitle:@"查看附近保养商户" forState:(UIControlStateNormal)];
    nearByButton.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
    nearByButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:nearByButton];
}

//需要判断是否已经添加保养提醒
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载fakeNavigation
-(UIView *)fakeNavigation{
    
    if (!_fakeNavigation) {
        _fakeNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 66)];
        _fakeNavigation.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        
        UILabel *fakeTitle = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-100, 26, 200, 30)];
        fakeTitle.text = @"保养提醒";
        fakeTitle.font = [UIFont systemFontOfSize:18 weight:18];
        fakeTitle.textColor = [UIColor whiteColor];
        fakeTitle.textAlignment = NSTextAlignmentCenter;
        [_fakeNavigation addSubview:fakeTitle];
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:backButton];
        
        UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-31,30, 19, 19)];
        [editButton setImage:[UIImage imageNamed:@"bianji"] forState:(UIControlStateNormal)];
        [editButton addTarget:self action:@selector(editingAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:editButton];
        
        
    }
    return _fakeNavigation;
}

//提示添加的View，添加按钮时隐藏
-(UIView *)addView{
    if (!_addView) {
        _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _addView.backgroundColor = [UIColor whiteColor];
        
        //提示信息
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
        addButton.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        [addButton setTitle:@"尚未添加保养信息，点击添加" forState:(UIControlStateNormal)];
        addButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:18];
        [addButton addTarget:self action:@selector(callNewViewController) forControlEvents:(UIControlEventTouchUpInside)];
        [_addView addSubview:addButton];
    }
    return _addView;
}

//添加成功后的View
-(UIView *)afterView{
    if (!_afterView) {
        _afterView = [[UIView alloc]initWithFrame:CGRectMake(0, 66, Main_Screen_Width, Main_Screen_Height-66)];
        _afterView.backgroundColor = [UIColor whiteColor];
        
        UIView *blueBase = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 120)];
        blueBase.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        [_afterView addSubview:blueBase];
        
        //afterView中的属性
        _carNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, Main_Screen_Width, 35)];
        _carNoLabel.textColor = [UIColor whiteColor];
        _carNoLabel.font = [UIFont systemFontOfSize:15];
        _carNoLabel.text = @"沪A-A6549 保养时间";
        _carNoLabel.textAlignment = NSTextAlignmentCenter;
        [_afterView addSubview:_carNoLabel];
        
        _carCareTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 40)];
        _carCareTimeLabel.textColor = [UIColor whiteColor];
        _carCareTimeLabel.font = [UIFont systemFontOfSize:20];
        _carCareTimeLabel.text = @"2018-11-11";
        _carCareTimeLabel.textAlignment = NSTextAlignmentCenter;
        [_afterView addSubview:_carCareTimeLabel];
        
        
    }
    return _afterView;
}
//返回按钮动作
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editingAction{
    AddCareRemindViewController *new = [[AddCareRemindViewController alloc]init];
    [self presentViewController:new animated:YES completion:^{
    }];
}

//addView上present新控制器
-(void)callNewViewController{
    AddCareRemindViewController *new = [[AddCareRemindViewController alloc]init];
    [self presentViewController:new animated:YES completion:^{
        [self.addView removeFromSuperview];
    }];
}



@end

//
//  DSMyCarController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMyCarController.h"
#import "MyCarPortController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import <Masonry.h>
#import "MyCarInfosHeaderView.h"
#import "UIView+Uitls.h"
#import "QFDatePickerView.h"


@interface DSMyCarController ()<UITableViewDelegate, UITableViewDataSource, NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *carImageView;

@property (nonatomic, weak) UITableView *carInfoView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) UIPageControl *pageControl;



@property (nonatomic, weak) UILabel *lbl;
@property (nonatomic, weak) UILabel *lbl2;

@end

static NSString * HeaderId = @"header";

@implementation DSMyCarController{
    CGFloat _totalYOffset;
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

//- (UIImageView *)carImageView {
//    
//    if (_carImageView == nil) {
//        UIImageView *carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 200)];
//        _carImageView = carImageView;
//        [self.view addSubview:_carImageView];
//    }
//    return _carImageView;
//}

- (UITableView *)carInfoView {
    
    if (_carInfoView == nil) {
        
        UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 264 + 5, Main_Screen_Width, Main_Screen_Height - 264) style:UITableViewStyleGrouped];
        _carInfoView = carInfoView;
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
}


- (void)drawNavigation {
    
    [self drawTitle:@"我的爱车"];
    [self drawRightTextButton:@"我的车库" action:@selector(clickMycarPort)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.carImageView.image = [UIImage imageNamed:@"02"];
    
    for (int index = 0; index < 3; index++) {
        UIImage *image = [UIImage imageNamed:@"aicheditu"];
        [self.imageArray addObject:image];
    }
    
    self.carInfoView.delegate = self;
    self.carInfoView.dataSource = self;
    
    [self.carInfoView registerClass:[MyCarInfosHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderId];
    
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (void)setupUI {
    
    //无限轮播图
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, (Main_Screen_Width - 60) * 9 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    //pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    [self.view addSubview:pageFlowView];
    [pageFlowView reloadData];
    
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.numberOfPages = self.imageArray.count;
//    pageControl.userInteractionEnabled = NO;
//    [pageControl setValue:[UIImage imageNamed:@"xuanzhong"] forKey:@"currentPageImage"];
//    [pageControl setValue:[UIImage imageNamed:@"wei_xuanzhong"] forKey:@"pageImage"];
//    self.pageControl = pageControl;
//    [pageFlowView addSubview:pageControl];
//    
//    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(pageFlowView);
//        make.bottom.equalTo(pageFlowView).mas_offset(-1);
//    }];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Main_Screen_Width - 84, (Main_Screen_Width - 84) / 2);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 84, (Main_Screen_Width - 84) / 2)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    UIImageView *containImageView = [[UIImageView alloc] initWithFrame:bannerView.bounds];
    containImageView.image = self.imageArray[index];
    [bannerView addSubview:containImageView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"aichemoren"];
    [containImageView addSubview:iconImageView];
    
    UIImageView *carImageView = [[UIImageView alloc] init];
    carImageView.image = [UIImage imageNamed:@"aiche1"];
    [containImageView addSubview:carImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(containImageView);
        make.width.height.mas_equalTo(30);
    }];
    
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(containImageView);
        make.left.equalTo(containImageView).mas_equalTo(24);
        make.width.height.mas_equalTo(67);
    }];
    
    bannerView.mainImageView = containImageView;
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    //self.pageControl.currentPage = pageNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *id_carCell = @"id_carCell";
    UITableViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carCell];
    
    carCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carCell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            carCell.textLabel.text = @"车牌号";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            UILabel *provinceLabel = [[UILabel alloc] init];
            provinceLabel.text = @"沪";
            provinceLabel.textColor = [UIColor colorFromHex:@"#868686"];
            provinceLabel.font = [UIFont systemFontOfSize:14];
            [carCell.contentView addSubview:provinceLabel];
            
            UITextField *numTF = [[UITextField alloc] init];
            numTF.placeholder = @"请输入车牌号";
            numTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            numTF.font = [UIFont systemFontOfSize:12];
            numTF.delegate = self;
            [carCell.contentView addSubview:numTF];
            
            [provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(carCell.textLabel);
                make.left.equalTo(carCell.contentView).mas_offset(110);
            }];
            
            [numTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(provinceLabel);
                make.leading.equalTo(provinceLabel.mas_trailing).mas_offset(16);
                make.width.mas_equalTo(200);
            }];
        }else{
            carCell.textLabel.text = @"品牌车系";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            
            UITextField *brandTF = [[UITextField alloc] init];
            brandTF.placeholder = @"请填写";
            brandTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            brandTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:brandTF];
            
            [brandTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12);
            }];
        }
    }
    
    if (indexPath.section == 1) {
        
        NSArray *arr = @[@"车架号码",@"生产年份",@"上路时间",@"行驶里程"];
        carCell.textLabel.text = arr[indexPath.row];
        carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
        carCell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            UITextField *textTF = [[UITextField alloc] init];
            textTF.placeholder = @"请填写";
            textTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            textTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:textTF];
            
            [textTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12);
            }];
        }else {
            
            carCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 1) {
                UILabel *lbl = [[UILabel alloc] init];
                _lbl = lbl;
                lbl.text = @"请选择";
                lbl.textColor = [UIColor colorFromHex:@"#868686"];
                lbl.font = [UIFont systemFontOfSize:12];
                [carCell.contentView addSubview:lbl];
                
                [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110);
                    make.centerY.equalTo(carCell);
                }];
            }else {
                UILabel *lbl2 = [[UILabel alloc] init];
                _lbl2 = lbl2;
                lbl2.text = @"请选择";
                lbl2.textColor = [UIColor colorFromHex:@"#868686"];
                lbl2.font = [UIFont systemFontOfSize:12];
                [carCell.contentView addSubview:lbl2];
                
                [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110);
                    make.centerY.equalTo(carCell);
                }];
            }
            
        }
        
        
    }
    
    return carCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MyCarInfosHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderId];
    headView.infosLabel.textColor = [UIColor colorFromHex:@"#868686"];
    headView.infosLabel.font = [UIFont systemFontOfSize:15];
    
    if (section == 0) {
        headView.infosLabel.text = @"基本信息";
        headView.imgV.image = [UIImage imageNamed:@"xinxi"];
    }else {
        headView.infosLabel.text = @"其他信息";
        headView.imgV.image = [UIImage imageNamed:@"qitaxinxi"];
    }
    
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1)
    {
        
        if (indexPath.row == 1) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl.text = str;
            }];
            [datePickerView show];
        }
        
        if (indexPath.row == 2) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl2.text = str;
            }];
            [datePickerView show];
        }
    }
    
}
    
    



#pragma mark - 键盘
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;;
    [self.view.layer removeAllAnimations];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponderView = [keyWindow performSelector:@selector(findFirstResponder)];
    
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:firstResponderView.frame fromView:firstResponderView.superview];
    
    CGFloat bottom = rect.origin.y + rect.size.height;
    CGFloat keyboardY = self.view.window.size.height - keyboardHeight;
    if (bottom > keyboardY) {
        _totalYOffset += bottom - (self.view.window.size.height - keyboardHeight);
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                              delay:0
                            options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                         animations:^{
                             self.view.y -= _totalYOffset;
                         }
                         completion:nil];
    }
    
    
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         self.view.y += _totalYOffset;
                     }
                     completion:nil];
    _totalYOffset = 0;
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    
}

- (void)keyboardDidShow:(NSNotification *)noti
{
}

- (void)keyboardDidHide:(NSNotification *)noti
{
}

- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
}

- (void)endEditing
{
    [self.view endEditing:YES];
}

#pragma mark -点击我的车库
- (void)clickMycarPort {
    
    MyCarPortController *carPortVC = [[MyCarPortController alloc] init];
    
    carPortVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carPortVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

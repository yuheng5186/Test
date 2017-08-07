//
//  OrderCommentController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OrderCommentController.h"
#import <Masonry.h>

@interface OrderCommentController ()<UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;
@property (nonatomic, weak) UIButton *firstButton;

@end

@implementation OrderCommentController

- (NSMutableArray<UIButton *> *)buttonArray{
    
    if (nil == _buttonArray) {
        
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)drawNavigation {
    
    [self drawTitle:@"发表评价"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *containStarView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, Main_Screen_Width, 110)];
    containStarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containStarView];
    
//    [containStarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(10 + 64);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(110);
//    }];
    
    UILabel *gradeLabel = [[UILabel alloc] init];
    gradeLabel.text = @"打分星评";
    gradeLabel.textColor = [UIColor colorFromHex:@"4a4a4a"];
    gradeLabel.font = [UIFont systemFontOfSize:16];
    [containStarView addSubview:gradeLabel];
    
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *starButton = [[UIButton alloc] init];
        [starButton setImage:[UIImage imageNamed:@"huixingxing"] forState:UIControlStateNormal];
        [starButton setImage:[UIImage imageNamed:@"huangxingxing"] forState:UIControlStateSelected];
        [starButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        starButton.tag = i;
//        [starButton setImage:[UIImage imageNamed:@"huangxingxing"] forState:UIControlStateNormal];
//        [starButton setImage:[UIImage imageNamed:@"huixingxing"] forState:UIControlStateSelected];
        [containStarView addSubview:starButton];
        [self.buttonArray addObject:starButton];
    }
    
//    UIButton *starButton = [[UIButton alloc] init];
//    [starButton setImage:[UIImage imageNamed:@"huangxingxing"] forState:UIControlStateNormal];
//    [starButton setImage:[UIImage imageNamed:@"huixingxing"] forState:UIControlStateSelected];
//    [containStarView addSubview:starButton];
    
    //约束
    
    
    [gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containStarView).mas_offset(22);
        make.centerX.equalTo(containStarView);
    }];
    
    _firstButton = self.buttonArray[0];
    
    [self.buttonArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containStarView).mas_offset(89);
        make.top.equalTo(gradeLabel.mas_bottom).mas_offset(25);
        make.width.height.mas_equalTo(26);
    }];
    
    [self.buttonArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[0]);
        make.leading.equalTo(self.buttonArray[0].mas_trailing).mas_offset(16.75);
        make.size.equalTo(self.buttonArray[0]);
    }];
    
    [self.buttonArray[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[1]);
        make.leading.equalTo(self.buttonArray[1].mas_trailing).mas_offset(16.75);
        make.size.equalTo(self.buttonArray[1]);
    }];
    
    [self.buttonArray[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[2]);
        make.leading.equalTo(self.buttonArray[2].mas_trailing).mas_offset(16.75);
        make.size.equalTo(self.buttonArray[2]);
    }];
    
    [self.buttonArray[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[3]);
        make.leading.equalTo(self.buttonArray[3].mas_trailing).mas_offset(16.75);
        make.size.equalTo(self.buttonArray[3]);
    }];
    
    
    UITextView *commentTextView = [[UITextView alloc] init];
    commentTextView.text = @"亲,您的评价可以帮助到别人哦";
    commentTextView.textColor = [UIColor colorFromHex:@"#999999"];
    commentTextView.delegate = self;
    [self.view addSubview:commentTextView];
    
    [commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containStarView.mas_bottom).mas_offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    UIButton *signinButton = [UIUtil drawDefaultButton:self.view title:@"发表评价" target:self action:@selector(clickSigninButton:)];
    
    [signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-25);
        make.width.mas_equalTo(350);
        make.height.mas_equalTo(38);
        make.centerX.equalTo(self.view);
    }];
}

- (void)clickSigninButton:(UIButton *)button {
    
    
}


- (void)clickButton:(UIButton *)button {
    

    if (button.selected) {
        
        [button setImage:[UIImage imageNamed:@"huangxingxing"] forState:UIControlStateSelected];
    }
    
    button.selected = !button.selected;
}

//初始化button
- (UIButton *)buttonWithNormalImage:(UIImage *)normalImage SelectedImage:(UIImage *)selectedImage {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}



- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"亲,您的评价可以帮助到别人哦"]) {
        textView.text = @"";
        textView.textColor = [UIColor colorFromHex:@"#999999"];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length < 1) {
        textView.text = @"亲,您的评价可以帮助到别人哦";
        textView.font = [UIFont systemFontOfSize:13];
        textView.textColor = [UIColor colorFromHex:@"#999999"];
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

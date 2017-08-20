//
//  DSCarClubDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarClubDetailController.h"

#import "DSActivityDetailCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IQKeyboardManager.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页


@interface DSCarClubDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray    *modelsArray;
@property (nonatomic, strong) UIImageView       *userImageView;
@property (nonatomic, strong) UIImageView       *seeImageView;
@property (nonatomic, strong) UILabel           *seeNumber;
@property (nonatomic, strong) UILabel           *textTitleLabel;
@property (nonatomic, strong) UILabel           *textContentLabel;
@property (nonatomic, strong) UIImageView       *textImageView;
@property (nonatomic, strong) UIButton          *goodButton;
@property (nonatomic, strong) UILabel           *goodNumberLabel;

@property (nonatomic, strong) UILabel           *userName;
@property (nonatomic, strong) UILabel           *sayTime;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *contentLab;
@property (nonatomic, strong) UILabel           *sayNumberLab;

@property (nonatomic, strong) UITextField       *userSayTextField;
@property (nonatomic, strong) UIButton          *sayButton;
@property (nonatomic, strong) UIButton          *downGoodButton;
@property (nonatomic, strong) UILabel           *sayShowLabel;
@property (nonatomic, strong) UILabel           *goodShowLabel;
@property (nonatomic, strong)UIView *downView;

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;

@end

@implementation DSCarClubDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"活动详情"];
    
}

- (void) drawContent
{
    self.contentView.top                = Main_Screen_Height*44/667;
    self.contentView.height             = self.view.height;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//     [IQKeyboardManager sharedManager].enable = YES;
    // Do any additional setup after loading the view.
    //添加监听，当键盘出现时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    //添加监听，当键盘退出时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
    [self createSubView];
}
// 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    // 获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;

    if (self.userSayTextField.text.length ==0) {//键盘弹出
        
        self.downView.frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667-height, Main_Screen_Width, Main_Screen_Height*60/667);
    }else{
        CGRect rect =CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667-height, Main_Screen_Width, Main_Screen_Height*60/667);
        self.downView.frame = rect;
    }
}
// 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{

    if (self.userSayTextField.text.length ==0) {//键盘弹出
        
        self.downView.frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    }else{
        CGRect rect =CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
        self.downView.frame = rect;
    }

}


- (void) createSubView {

    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height+64) style:UITableViewStylePlain];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
#pragma maek-空白页
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    //    self.tableView.scrollEnabled    = NO;
    //    self.tableView.tableFooterView  = [UIView new];
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 380, 0);
    [self.contentView addSubview:self.tableView];
    self.tableView.backgroundColor=[UIColor clearColor];
    
    [self createHeaderView];
    [self creatModelsWithCount:10];
}

- (void) createHeaderView {
    UIView *header = [UIView new];
    header.width = [UIScreen mainScreen].bounds.size.width;
    header.backgroundColor  = [UIColor whiteColor];
    

    
    
    UIImageView *userImageView  = [UIImageView new];
    userImageView.image         = [UIImage imageNamed:@"icon0.jpg"];
    self.userImageView          = userImageView;
    [header addSubview:userImageView];
    
    
    userImageView.sd_layout
    .leftSpaceToView(header, 10)
    .topSpaceToView(header, 10)
    .heightIs(40)
    .widthIs(40);
    userImageView.sd_cornerRadiusFromWidthRatio     = @(0.5);
    
    
    UILabel *userName                   = [UILabel new];
    userName.textColor                  = [UIColor blackColor];
    userName.font                       = [UIFont systemFontOfSize:14];
    userName.textColor                  = [UIColor colorFromHex:@"#3a3a3a"];
    userName.text                       = @"15800781856";
    self.userName                       = userName;
    [header addSubview:userName];
    
    userName.sd_layout
    .leftSpaceToView(userImageView, 10)
    .topSpaceToView(header, 10)
    .heightIs(20)
    .widthIs(150);
    
    
    UILabel *seeNumberLabel                   = [UILabel new];
    seeNumberLabel.textColor                  = [UIColor blackColor];
    seeNumberLabel.font                       = [UIFont systemFontOfSize:12];
    seeNumberLabel.textColor                  = [UIColor colorFromHex:@"#868686"];
    seeNumberLabel.text                       = @"369";
    self.userName                            = seeNumberLabel;
    [header addSubview:seeNumberLabel];
    
    seeNumberLabel.sd_layout
    .rightSpaceToView(header, 10)
    .topSpaceToView(header, 10)
    .heightIs(20)
    .widthIs(40);
    
    
    UIImageView *seeImageView  = [UIImageView new];
    seeImageView.image         = [UIImage imageNamed:@"yanjing.jpg"];
    self.seeImageView          = seeImageView;
    [header addSubview:seeImageView];
    
    
    seeImageView.sd_layout
    .rightSpaceToView(seeNumberLabel, 5)
    .topSpaceToView(header, 12)
    .heightIs(15)
    .widthIs(15);
    
    
    
    
    UILabel *sayTimeLab                 = [UILabel new];
    sayTimeLab.textColor                = [UIColor colorFromHex:@"#999999"];
    sayTimeLab.text                     = @"2017-7-31 15:30:56";
    sayTimeLab.font                     = [UIFont systemFontOfSize:11];
    self.sayTime                        = sayTimeLab;
    [header addSubview:sayTimeLab];
    
    
    sayTimeLab.sd_layout
    .leftEqualToView(userName)
    .topSpaceToView(userName, 5)
    .widthIs(150)
    .heightIs(20);
    
    
    
    
    
    UIView *backgroudView               = [UIView new];
    backgroudView.width                 = [UIScreen mainScreen].bounds.size.width;
    backgroudView.backgroundColor       = [UIColor colorFromHex:@"#f6f6f6"];
    [header addSubview:backgroudView];
    
    backgroudView.sd_layout
    .topSpaceToView(sayTimeLab, 10)
    .leftEqualToView(header)
    .heightIs(300);
    
    UILabel *textTitleLabel                 = [UILabel new];
    textTitleLabel.textColor                = [UIColor colorFromHex:@"#4a4a4a"];
    textTitleLabel.text                     = @"夏天如何防止高温？";
    textTitleLabel.font                     = [UIFont systemFontOfSize:14];
    self.textTitleLabel                     = textTitleLabel;
    [backgroudView addSubview:textTitleLabel];
    
    
    textTitleLabel.sd_layout
    .leftSpaceToView(backgroudView, 10)
    .topSpaceToView(backgroudView, 10)
    .widthIs(250)
    .heightIs(40);
    
    UILabel *textContentLabel                 = [UILabel new];
    textContentLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    textContentLabel.text                     = @"夏天到来,随着温度越来越高,很多抵抗力差的人在高温环境下很容易中暑.今天太阳城管理网分享几条经验,教亲们如何采取措施,防止中暑.每天要喝7-8杯水,夏天是个严重缺水的季节,所以要增加水量,做到水分充足.补充水分也可以选择喝茶,因为茶味略苦性寒，具有消暑、解毒、去火等功能,但饮茶不能过量，茶水以清淡适中为宜哦.还有水果跟蔬菜也可补充水分.记住不要等到口渴了才喝水, 因为口渴表示身体已经缺水了.吃的东西越多，为了消化这些食物，身体产生的代谢热量就越多.一定要注意少吃高蛋白的食物，因为它们产生的代谢热量特别多.高蛋白质的食物如:牛奶,肉,鸡蛋,豆类等.还要吃得清淡,像黄瓜,西红柿等,这些蔬菜含水量多.夏天的衣服一定要尽量穿透气、浅色的.散热的棉质衣服而且要宽松的.浅色的衣服不会吸热.所以尽量不要穿暗色的衣服易吸热,像黑色,灰色等.";
    textContentLabel.font                     = [UIFont systemFontOfSize:14];
    textContentLabel.numberOfLines            = 0;
    self.textContentLabel                     = textContentLabel;
    [backgroudView addSubview:textContentLabel];
    
    
    textContentLabel.sd_layout
    .leftEqualToView(textTitleLabel)
    .rightSpaceToView(backgroudView, 10)
    .topSpaceToView(textTitleLabel, 10)
    .autoHeightRatio(0);
    
    UIImageView *textImageView  = [UIImageView new];
    textImageView.image         = [UIImage imageNamed:@"hangdiantu"];
    self.textImageView          = textImageView;
    [backgroudView addSubview:textImageView];
    
    textImageView.sd_layout
    .topSpaceToView(textContentLabel, 10)
    .leftEqualToView(textContentLabel)
    .widthRatioToView(textContentLabel, 1)
    .heightIs(200);
    
    
    UIButton    *goodButton = [UIButton new];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
    goodButton.backgroundColor  = [UIColor whiteColor];
    [goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.goodButton         = goodButton;
    [backgroudView addSubview:goodButton];
    
    goodButton.sd_layout
    .topSpaceToView(textImageView, 10)
    .centerXEqualToView(textImageView)
    .heightIs(50)
    .widthIs(50);
    goodButton.layer.cornerRadius = goodButton.size.width/2;
    
    
    
    UILabel  *goodNumberLabel                = [UILabel new];
    goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    goodNumberLabel.text                     = @"共有168人点赞过";
    goodNumberLabel.font                     = [UIFont systemFontOfSize:14];
    self.goodNumberLabel                     = goodNumberLabel;
    goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
    [backgroudView addSubview:goodNumberLabel];
    
    goodNumberLabel.sd_layout
    .topSpaceToView(goodButton, 10)
    .centerXEqualToView(goodButton)
    .widthIs(150)
    .heightIs(20);
    
    
    [backgroudView setupAutoHeightWithBottomView:goodNumberLabel bottomMargin:10];
    
    
    
    UILabel *sayNumberLab                   = [UILabel new];
    sayNumberLab.textColor                  = [UIColor blackColor];
    sayNumberLab.font                       = [UIFont systemFontOfSize:16];
    sayNumberLab.text                       = @"评论（28）";
    self.sayNumberLab                       = sayNumberLab;
    [header addSubview:sayNumberLab];
    
    sayNumberLab.sd_layout
    .leftSpaceToView(header, 10)
    .topSpaceToView(backgroudView, 10)
    .widthIs(100)
    .heightIs(20);
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:bottomLine];
    
    bottomLine.sd_layout
    .topSpaceToView(sayNumberLab, 10)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(1);
    
    
    [header setupAutoHeightWithBottomView:bottomLine bottomMargin:10];
    [header layoutSubviews];
    self.tableView.tableHeaderView  = header;
    
    self.downView = [UIView new];
    self.downView .frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    self.downView .backgroundColor  = [UIColor whiteColor];
    
    
    self.userSayTextField                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150, Main_Screen_Height*40/667)];
    self.userSayTextField.placeholder    = @"    我来说两句...";
    self.userSayTextField.delegate       = self;
    self.userSayTextField.returnKeyType  = UIReturnKeyDone;
    self.userSayTextField.textAlignment  = NSTextAlignmentLeft;
    self.userSayTextField.font           = [UIFont systemFontOfSize:12];
    self.userSayTextField.backgroundColor= [UIColor whiteColor];
    self.userSayTextField.layer.cornerRadius    = 20;
    self.userSayTextField.layer.borderWidth     = 1;
    self.userSayTextField.layer.borderColor     = [UIColor colorFromHex:@"#b4b4b4"].CGColor;
    self.userSayTextField.left           = Main_Screen_Width*10/375 ;
    self.userSayTextField.top            = Main_Screen_Height*10/667;
    [self.userSayTextField addTarget:self action:@selector(userSayTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.downView  addSubview:self.userSayTextField];
    
    
    UIButton    *sayButton = [UIButton new];
    [sayButton setImage:[UIImage imageNamed:@"huodongxiangqingxiaoxi"] forState:UIControlStateNormal];
    sayButton.backgroundColor  = [UIColor whiteColor];
    [sayButton addTarget:self action:@selector(sayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sayButton         = sayButton;
    [self.downView  addSubview:sayButton];
    
    sayButton.sd_layout
    .leftSpaceToView(self.userSayTextField, 10)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20)
    .widthIs(20);
    
    
    UILabel *sayShowLabel                   = [UILabel new];
    sayShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    sayShowLabel.font                       = [UIFont systemFontOfSize:12];
    sayShowLabel.text                       = @"369";
    self.sayShowLabel                       = sayShowLabel;
    [self.downView  addSubview:sayShowLabel];
    
    sayShowLabel.sd_layout
    .leftSpaceToView(sayButton, 5)
    .topSpaceToView(self.downView , 12)
    .widthIs(40)
    .heightIs(20);
    
    UIButton    *downGoodButton = [UIButton new];
    [downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    downGoodButton.backgroundColor  = [UIColor whiteColor];
    [downGoodButton addTarget:self action:@selector(downGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downGoodButton         = downGoodButton;
    [self.downView  addSubview:downGoodButton];
    
    downGoodButton.sd_layout
    .leftSpaceToView(self.sayShowLabel, 5)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20)
    .widthIs(20);
    
    
    UILabel *goodShowLabel                   = [UILabel new];
    goodShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    goodShowLabel.font                       = [UIFont systemFontOfSize:12];
    goodShowLabel.text                       = @"369";
    self.sayShowLabel                       = goodShowLabel;
    [self.downView  addSubview:goodShowLabel];
    
    goodShowLabel.sd_layout
    .leftSpaceToView(downGoodButton, 0)
    .topSpaceToView(self.downView , 12)
    .widthIs(40)
    .heightIs(20);
    
    
    [self.downView  layoutSubviews];

    [self.contentView addSubview:self.downView ];
    
//    [self.scrollView addSubview:self.contentView];
//    [self.view addSubview:self.scrollView];

}

- (TPKeyboardAvoidingScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.contentView.bounds];
    }
    return _scrollView;
}


- (void) userSayTextFieldChanged:(UITextField *)sender {


    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
       return YES;
}
- (void) sayButtonClick:(id)sender {

    [self.userSayTextField resignFirstResponder];
    
}
- (void) downGoodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
        self.sayShowLabel.text                     = @"170";
        [self.view showInfo:@"点赞成功!" autoHidden:YES];
    }else {
        [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
        self.sayShowLabel.text                     = @"169";
        [self.view showInfo:@"取消点赞!" autoHidden:YES];
        
    }
    
    sender.selected = !sender.selected;
}
- (void) goodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
        self.goodNumberLabel.text                     = @"共有169人点赞过";
        [self.view showInfo:@"点赞成功!" autoHidden:YES];
    }else {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
        self.goodNumberLabel.text                     = @"共有168人点赞过";
        [self.view showInfo:@"取消点赞!" autoHidden:YES];

    }

    sender.selected = !sender.selected;
    
    
}

- (void) creatModelsWithCount:(NSInteger)count {
    
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *starImageArray      = @[@"5xing.jpg",
                                     @"4xing.jpg",
                                     @"3xing.jpg",
                                     @"2xing.jpg",
                                     @"1xing.jpg",
                                     ];
    
    NSArray *namesArray = @[@"158****1856",
                            @"风口上的猪",
                            @"梅超风",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"游泳。 最重要的是保持平和安详的心态。正所谓：心静自然凉。我经常用这一招，很有效果。",
                           @"在饮食方面，一方面体弱人群要适量饮用淡盐水；另一方面，少吃油腻食品。",
                           @"少吃多餐且清淡",
                           @"合理的安排休息时间，每天保证8小时足够的睡眠以保持充分的体能，可有效达到防暑目的哦.",
                           @"尽量不要上午10点至下午16点出门"
                           ];
    
    
    
    for (int i = 0; i < iconImageNamesArray.count; i++) {
        //        int iconRandomIndex = arc4random_uniform(5);
        //        int nameRandomIndex = arc4random_uniform(5);
        //        int contentRandomIndex = arc4random_uniform(5);
        
        DSUserModel *model = [DSUserModel new];
        model.iconName = iconImageNamesArray[i];
        model.name = namesArray[i];
        model.content = textArray[i];
        model.sayTime   = @"2017-7-31";
        model.starName  = starImageArray[i];
        
        //        DSUserModel *model = [DSUserModel new];
        //        model.iconName = iconImageNamesArray[i];
        //        model.name = namesArray[i];
        //        model.content = textArray[i];
        
        // 模拟“有或者无图片”
        
        [self.modelsArray addObject:model];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
    
//    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    DSActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[DSActivityDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStatic];
    }
    cell.thumbOnclick=^(UIButton *btn){
        if (btn.selected) {
            
             [self.view showInfo:@"取消点赞!" autoHidden:YES];
        }else{
             [self.view showInfo:@"点赞成功!" autoHidden:YES];
            
        }
        btn.selected=!btn.selected;
    
    };
    cell.model  = self.modelsArray[indexPath.row];
    
    
    return cell;
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pinglun_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"pinglun_kongbai"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
//设置文字（上图下面的文字，我这个图片默认没有这个文字的）是富文本样式，扩展性很强！

//这个是设置标题文字的
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无评论信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor greenColor];
}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"afdfdgfd" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"pinglun_kongbai"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return NO;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    return NSLog(@"空白页按钮点击事件");
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{//偏移量计算逻辑 ->
//    当前屏幕一半的高度 = (获取屏幕的的高度->减去导航栏高度)/2
    //判断headerView高度是否超过屏幕的一半
    BOOL isHeader =  (CGRectGetHeight(self.tableView.tableHeaderView.frame)>(self.view.bounds.size.height-64)/2);
    //计算偏移量 (bgView 为空白占位图)
//    CGFloat height=CGRectGetHeight(self.tableView.tableHeaderView.frame.size.height-(self.view.bounds.size.height-64)/2));
//    return isHeader?self.tableView.tableHeaderView.frame.size.height-(self.view.bounds.size.height-64)/2:-64;
    return 450;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.userSayTextField resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model" cellClass:[DSActivityDetailCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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

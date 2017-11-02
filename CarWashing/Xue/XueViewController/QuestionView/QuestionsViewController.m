//
//  QuestionsViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuesTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIImageView+WebCache.h"


@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SDWeiXinPhotoContainerView *picContainerView;

@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self.view addSubview:self.quesTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
-(void)getData{
    //获取数据
    NSString *URLStringJpg = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1509604874541&di=5cfaf6d8a3ddb781ea369e1bd2e3e948&imgtype=0&src=http%3A%2F%2Fi1.ymfile.com%2Fuploads%2Fllc%2Fphb%2F06%2F27%2Fx2_1.1403838708_2048_1536_264311.jpg";
    NSArray *oneData = [NSArray new];
    NSArray *twoData = @[URLStringJpg,URLStringJpg];
    NSArray *threeData = @[URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg];
    NSArray *fourArray = @[URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg];
    NSArray *fiveArray = @[URLStringJpg];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:oneData];
    [_dataArray addObject:twoData];
    [_dataArray addObject:threeData];
    [_dataArray addObject:fourArray];
    [_dataArray addObject:fiveArray];

    
    _mainImfoArray = @[@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"项目中我们有时以",@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高。"];

    

}


#pragma mark - TableView
-(UITableView *)quesTableView{
    if(_quesTableView == nil){
        _quesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-106) style:(UITableViewStylePlain)];
        _quesTableView.delegate = self;
        _quesTableView.dataSource = self;
        _quesTableView.backgroundColor = [UIColor whiteColor];
        _quesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_quesTableView registerClass:[QuesTableViewCell class] forCellReuseIdentifier:@"question"];

    }
    return _quesTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    if(tempArray.count == 1){
        return 300;
    }else if(tempArray.count > 1 && tempArray.count <= 3){
        return 230;
    }else if (tempArray.count <= 6 && tempArray.count > 3){
        return 315;
    }else if (tempArray.count <= 9 && tempArray.count > 6){
        return 400;
    }
    //没有图片
    return 150;
}

//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //重用cell
    static NSString *quesCellID = @"question";
    QuesTableViewCell *cell = [_quesTableView dequeueReusableCellWithIdentifier:quesCellID forIndexPath:indexPath];
    
    //////////////////////
    NSDictionary *font123 = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize maxSize = CGSizeMake(Main_Screen_Width-70, MAXFLOAT);
    CGSize labelSize = [_mainImfoArray[indexPath.section] boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:font123 context:nil].size;
    /////////////////////
    
    //九宫格图片
    cell.largeImageView.frame = CGRectMake(56, 80+labelSize.height, Main_Screen_Width-70, 240);
    _picContainerView = [SDWeiXinPhotoContainerView new];
    _picContainerView.frame=CGRectMake(0, 0,cell.largeImageView.frame.size.width, cell.largeImageView.frame.size.height);
    [cell.largeImageView addSubview:_picContainerView];
    
    
    //cell中逻辑判断
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    
    if(tempArray.count == 0){
        cell.largeImageView.hidden = YES;
    }else if (tempArray.count == 1) {
        cell.largeImageView.height = 150;
        
        cell.realLargeImage.frame = CGRectMake(0, 0, Main_Screen_Width-70, 150);
        NSURL *imageURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1509604874541&di=5cfaf6d8a3ddb781ea369e1bd2e3e948&imgtype=0&src=http%3A%2F%2Fi1.ymfile.com%2Fuploads%2Fllc%2Fphb%2F06%2F27%2Fx2_1.1403838708_2048_1536_264311.jpg"];
        [cell.realLargeImage sd_setImageWithURL: imageURL];
    }else if (tempArray.count <= 3 && tempArray.count > 1) {
        cell.largeImageView.hidden = NO;
        cell.largeImageView.height = 80;
        _picContainerView.picPathStringsArray = tempArray;
    }else if (tempArray.count <= 6 && tempArray.count > 3){
        cell.largeImageView.hidden = NO;
        cell.largeImageView.height = 165;
        _picContainerView.picPathStringsArray = tempArray;
    }else if (tempArray.count <= 9&& tempArray.count > 6){
        cell.largeImageView.hidden = NO;
        cell.largeImageView.height = 250;
        _picContainerView.picPathStringsArray = tempArray;
    }
    
    cell.mailLabel.height = labelSize.height;
    cell.mailLabel.text = _mainImfoArray[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end

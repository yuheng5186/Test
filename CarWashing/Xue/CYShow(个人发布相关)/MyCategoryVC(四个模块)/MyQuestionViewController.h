//
//  MyQuestionViewController.h
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseController.h"

@interface MyQuestionViewController : BaseController
@property(strong,nonatomic)UITableView *quesTableView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)NSArray *mainImfoArray;
@property(nonatomic)CGSize *mainSize;
@end

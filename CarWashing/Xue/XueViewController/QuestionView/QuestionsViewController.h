//
//  QuestionsViewController.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuestionsViewController : UIViewController
@property(strong,nonatomic)UITableView *quesTableView;

@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)NSArray *mainImfoArray;
@property(nonatomic)CGSize *mainSize;
@end

//
//  QuestionNewView.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionNewView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *questionTableView;
-(void)setTable;
@end

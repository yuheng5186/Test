//
//  QuestionNewView.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionNewView.h"
#import "QuestionNewTableViewCell.h"

@implementation QuestionNewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setTable{
    _questionTableView = [[UITableView alloc]initWithFrame:self.frame style:(UITableViewStylePlain)];
    _questionTableView.backgroundColor = [UIColor cyanColor];
    _questionTableView.delegate = self;
    _questionTableView.dataSource = self;
    
    [self addSubview:_questionTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"question";
    QuestionNewTableViewCell *questionCell = [_questionTableView dequeueReusableCellWithIdentifier:cellId];
    if(questionCell==nil){
        questionCell = [[QuestionNewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return questionCell;
}


@end

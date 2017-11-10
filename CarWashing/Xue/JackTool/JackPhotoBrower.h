//
//  JackPhotoBrower.h
//  JackImageViewTool
//
//  Created by Wuxinglin on 2017/11/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JackPhotoBrower : UIView
-(void)showYourself:(UIImageView *)imageSender;
@property(nonatomic)CGRect oldFrame;
@property(strong,nonatomic)UIImageView *imageOnBlack;
@property(strong,nonatomic)UIWindow *window;
@end

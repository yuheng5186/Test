//
//  JackPhotoBrower.m
//  JackImageViewTool
//
//  Created by Wuxinglin on 2017/11/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "JackPhotoBrower.h"

@implementation JackPhotoBrower

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)showYourself:(UIImageView *)imageSender{
    
    //跳到新view上，背景变色
    _window = [UIApplication sharedApplication].keyWindow;
    self.frame = _window.bounds;
    self.alpha = 0;
    [_window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [_window addSubview:self];
    
    //image变换
    UIImage *tempImage = imageSender.image;
    self.oldFrame = [imageSender convertRect:imageSender.bounds toView:_window];
    _imageOnBlack = [[UIImageView alloc]initWithFrame:self.oldFrame];
    _imageOnBlack.image = tempImage;
    [self addSubview:_imageOnBlack];
    
    //准备关闭
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        _imageOnBlack.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-tempImage.size.height*[UIScreen mainScreen].bounds.size.width/tempImage.size.width)/2, [UIScreen mainScreen].bounds.size.width, tempImage.size.height*[UIScreen mainScreen].bounds.size.width/tempImage.size.width);
        self.alpha = 1;
    }];
    
    
    //保存按钮
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 600, 50, 50)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:saveButton];
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:(UIControlEventTouchUpInside)];
}

//退出动画
-(void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        _imageOnBlack.frame = self.oldFrame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//保存图片到系统相册
-(void)saveImage{
    //调用保存到相册的方法
    UIImageWriteToSavedPhotosAlbum(_imageOnBlack.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//保存图片后反馈到UI
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = @"保存图片失败";
    }   else {
        label.text = @"保存图片成功";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}


@end

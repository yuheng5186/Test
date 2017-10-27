//
//  CXXCollectionViewCell.m
//  JLProject
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 CY. All rights reserved.
//

#import "CXXCollectionViewCell.h"

@implementation CXXCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addImageBtn.userInteractionEnabled = NO;
}
- (void)setPhotoImg:(UIImage *)photoImg{
    _photoImg = photoImg;
    if (photoImg == nil) {
        [self.addImageBtn setImage:[UIImage imageNamed:@"pic_sc"] forState:UIControlStateNormal];
        self.addImageBtn.userInteractionEnabled = NO;
        self.closeBtn.hidden = YES;
    }else{
        [self.addImageBtn setImage:photoImg forState:UIControlStateNormal];
        self.addImageBtn.userInteractionEnabled = YES;
        self.closeBtn.hidden = NO;
        
    }
}


- (IBAction)closeBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(photoCellRemovePhotoBtnClickForCell:)]) {
        [self.delegate photoCellRemovePhotoBtnClickForCell:self];
    }
}

@end

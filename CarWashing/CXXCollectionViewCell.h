//
//  CXXCollectionViewCell.h
//  JLProject
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXXCollectionViewCell;
@protocol CXXCollectionViewCellDelegate <NSObject>
@optional
- (void)photoCellRemovePhotoBtnClickForCell:(CXXCollectionViewCell *)cell;
@end
@interface CXXCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
/** 传递过来的图片 */
@property (nonatomic, strong) UIImage *photoImg;
/** <#name#> */
@property (nonatomic, weak) id <CXXCollectionViewCellDelegate>delegate;
@end

//
//  CYPublishViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYPublishViewController.h"
//#import "ACMediaFrame.h"
//#import "UIImage+ACGif.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

#import "UdStorage.h"
#import "HTTPDefine.h"
#import "AFNetworkingTool.h"
#import "AFNetworkingTool+GetToken.h"
#import "LCMD5Tool.h"
@interface CYPublishViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    UITextView * contentTextField;
    UILabel * numLabel;
    UILabel * placeHoldLabel;
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    LxGridViewFlowLayout *_layout;
}
@property (nonatomic,strong)  UIScrollView   * backScrollerView;
@property (nonatomic,strong)  NSMutableArray * imageArr;
@property (strong, nonatomic) UIView         *photoImageView;
@property (strong, nonatomic) NSMutableArray         *photoArray;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *maxCountTF;///< 照片最大可选张数，设置为1即为单选模式

@property(nonatomic,strong)UIImageView *jackImageView;
@end

@implementation CYPublishViewController
//- (void) drawContent {
//
//    self.contentView.height     = self.view.height;
//}
-(UITextField*)maxCountTF{
    if (_maxCountTF==nil) {
        _maxCountTF=[[UITextField alloc]init];
        _maxCountTF.text = @"9";
       
    }
    return _maxCountTF;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.view addSubview:_maxCountTF];
    _photoArray =[NSMutableArray array];
    self.backScrollerView.backgroundColor=[UIColor whiteColor];
    _imageArr=[NSMutableArray array];
    UILabel * navlabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, Main_Screen_Width-160, 44)];
    navlabel.textColor=[UIColor whiteColor];
    navlabel.text=@"发布问题";
    navlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navlabel];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame =CGRectMake(Main_Screen_Width-80, 20, 80, 44);
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [self.view addSubview:self.backScrollerView];
    
    contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    contentTextField.backgroundColor=[UIColor colorFromHex:@"#f6f6f6"];
    contentTextField.delegate=self;
    [self.backScrollerView addSubview:contentTextField];
    placeHoldLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width, 20)];
    placeHoldLabel.text=@"一起来聊聊开车中发生有趣的事吧～";
    placeHoldLabel.font=[UIFont systemFontOfSize:13.0];
    placeHoldLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.backScrollerView addSubview:placeHoldLabel];
    numLabel = [[UILabel alloc]init];
    numLabel.text =@"最多输入400字";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font=[UIFont systemFontOfSize:13.0];
    numLabel.textColor=[UIColor blackColor];
    [self.backScrollerView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentTextField.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(contentTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
   //上传图片相关

    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];
    
    
    
    ///////////////////////////////////
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    _jackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
    _jackImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_jackImageView];
    
    UIButton *upLoadButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 200, 200)];
    upLoadButton.backgroundColor = [UIColor greenColor];
    [upLoadButton addTarget:self action:@selector(rightbtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:upLoadButton];
    ///////////////////////////////////

    
}

-(void)buttonAction{
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *getImage = info[UIImagePickerControllerOriginalImage];
    self.jackImageView.image = getImage;
    NSLog(@"我看看%@",info);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//////////////////////////////////////////////
#pragma mark ----懒加载
-(UIScrollView *)backScrollerView
{
    if (_backScrollerView ==nil) {
        _backScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
        _backScrollerView.contentSize=CGSizeMake(Main_Screen_Width, 1000);
        _backScrollerView.backgroundColor=[UIColor whiteColor];
    }
    return _backScrollerView;
}

#pragma mark---上传按钮
-(void)rightbtnClick
{
    
    //开始菊花
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_collectionView animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"发布中";
    
    NSDictionary *mulDic = @{
                                 @"ActivityType":@(2),
                                 @"Account_Id":[UdStorage getObjectforKey:Userid],
                                 @"ActivityName":[NSString stringWithFormat:@"%@",contentTextField.text],
                                 @"Comment":@"12345",
                                 };
    
    
    NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://192.168.2.152:8090/api/Activity/AddActivityInfo" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(self.jackImageView.image, 0.7);
        [formData appendPartWithFileData:imageData name:@"123" fileName:@"345.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);

    }];
    
//    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivityInfoIOS",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        NSLog(@"可算成功了%@",dict);
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"成功!";
//        [hud hide:YES afterDelay:0.5];
//
//        [self.navigationController popViewControllerAnimated:YES];
//    } fail:^(NSError *error) {
//        NSLog(@"你失败了%@",error);
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"上传失败，请重新上传!";
//        [hud hide:YES afterDelay:0.5];
//    }];
    
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
     placeHoldLabel.text =nil;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (contentTextField.contentSize.height >= 500) {
        contentTextField.frame = CGRectMake(0,500- contentTextField.contentSize.height , 200, 30 + contentTextField.contentSize.height);
    }else{
        contentTextField.frame = CGRectMake(0, 0, Main_Screen_Width, 30 + contentTextField.contentSize.height);
    }
    
    
    //对字数进行限制
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = 400 - comcatstr.length;
    
    if (caninputlen >= 0&&caninputlen<=399)
    {
        
        numLabel.text = [NSString stringWithFormat:@"%lu/400",contentTextField.text.length+1];
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
   
    
    
}
#pragma mark---图片相关
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
- (void)configCollectionView {
    _layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 4;
    if (Main_Screen_Width==320) {
        _itemWH = 80;
    }else{
        _itemWH = 100;
    }
    
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = _margin;
    _layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_layout];
//    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_backScrollerView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextField.mas_bottom);
        make.left.mas_equalTo(contentTextField.mas_left).mas_equalTo(5);
        make.right.mas_equalTo(contentTextField.mas_right).mas_equalTo(-5);
        make.height.mas_equalTo(500);
    }];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"shangchuantupian"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
#pragma clang diagnostic pop
            [sheet showInView:self.view];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
#pragma clang diagnostic pop
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                _layout.itemCount = _selectedPhotos.count;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_collectionView reloadData];
    }
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    if (self.maxCountTF.text.integerValue <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCountTF.text.integerValue delegate:self];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (self.maxCountTF.text.integerValue > 1) {
        // 1.如果你需要将拍照按钮放在外面，不要传这个参数
        imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    }
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}


/*
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) { // 如果保存失败，基本是没有相册权限导致的...
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法保存图片" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                alert.tag = 1;
                [alert show];
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [_collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}

*/

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            if (alertView.tag == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"]];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"]];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
// - (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
// NSLog(@"cancel");
// }

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    _layout.itemCount = _selectedPhotos.count;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    _layout.itemCount = _selectedPhotos.count;
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

#pragma mark Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    _layout.itemCount = _selectedPhotos.count;
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}
@end

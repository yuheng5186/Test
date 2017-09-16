//
//  ScanController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZFMaskView.h"
#import <ImageIO/ImageIO.h>

#import "DSScanPayController.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"
#import "ScanCode.h"

#import "DSStartWashingController.h"

@interface ScanController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    MBProgressHUD *HUD;
    
}

/** 设备 */
@property (nonatomic, strong) AVCaptureDevice * device;
/** 输入输出的中间桥梁 */
@property (nonatomic, strong) AVCaptureSession * session;
/** 相机图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
/** 扫描支持的编码格式的数组 */
@property (nonatomic, strong) NSMutableArray * metadataObjectTypes;
/** 遮罩层 */
@property (nonatomic, strong) ZFMaskView * maskView;
/** 返回按钮 */
@property (nonatomic, strong) UIButton * backButton;
/** 手电筒 */
@property (nonatomic, strong) UIButton * flashlight;
/** 返回提示Label */
@property (nonatomic, strong) UILabel * backHintLabel;
/** 手电筒提示Label */
@property (nonatomic, strong) UILabel * flashlightHintLabel;

@property (nonatomic, strong) ScanCode *scan;

@end

@implementation ScanController

- (void)drawNavigation {
    
    [self drawTitle:@"扫码洗车"];
    
}

- (NSMutableArray *)metadataObjectTypes{
    if (!_metadataObjectTypes) {
        _metadataObjectTypes = [NSMutableArray arrayWithObjects:AVMetadataObjectTypeAztecCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode, nil];
        
        // >= iOS 8
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            [_metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code, AVMetadataObjectTypeITF14Code, AVMetadataObjectTypeDataMatrixCode]];
        }
    }
    
    return _metadataObjectTypes;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.maskView removeAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self capture];
    [self addUI];
}

/**
 *  添加遮罩层
 */
- (void)addUI{
    
    self.maskView = [[ZFMaskView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.maskView];
    
//    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*44/667) color:[UIColor clearColor]];
//    upView.top                      = 20;
//    
//    //返回按钮
//    CGFloat back_width = 50;
//    CGFloat back_height = self.navigationView.size.height;
//    
//    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.backButton.frame = CGRectMake(0, 0, back_width, back_height);
//    [self.backButton setImage:[[UIImage imageNamed:@"icon_titlebar_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [self.backButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//    self.backButton.left        = 10;
//    self.backButton.top         = 10;
//    [upView addSubview:self.backButton];
    
    //返回提示Label
//    CGFloat backHint_width = 120;
//    CGFloat backHint_height = 30;
//    
//    self.backHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backHint_width, backHint_height)];
//    self.backHintLabel.text = @"扫码洗车";
//    self.backHintLabel.textAlignment = NSTextAlignmentCenter;
//    self.backHintLabel.textColor = ZFWhite;
//    self.backHintLabel.centerX  = upView.centerX;
//    self.backHintLabel.centerY  = self.backButton.centerY;
//    [upView addSubview:self.backHintLabel];
    
    //手电筒
    CGFloat flashlight_width = 40*Main_Screen_Height/667;
    CGFloat flashlight_height = 40*Main_Screen_Height/667;
    
    self.flashlight = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flashlight.frame = CGRectMake(0, 0, flashlight_width, flashlight_height);
    self.flashlight.center = CGPointMake(SCREEN_WIDTH - 100*Main_Screen_Height/667, SCREEN_HEIGHT / 2+150*Main_Screen_Height/667);

    [self.flashlight setImage:[UIImage imageNamed:@"Flashlight_N"] forState:UIControlStateNormal];
    [self.flashlight addTarget:self action:@selector(flashlightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashlight];
    
    //手电筒提示Label
    CGFloat flashlightHint_width = 100*Main_Screen_Height/667;
    CGFloat flashlightHint_height = 30*Main_Screen_Height/667;
    
    self.flashlightHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, flashlightHint_width, flashlightHint_height)];
    self.flashlightHintLabel.text = @"打开手电筒";
    self.flashlightHintLabel.textAlignment = NSTextAlignmentCenter;
    self.flashlightHintLabel.textColor = ZFWhite;
    self.flashlightHintLabel.top       = self.flashlight.bottom+10;
    self.flashlightHintLabel.centerX    = self.flashlight.centerX;
    [self.view addSubview:self.flashlightHintLabel];
    
}

/**
 *  扫描初始化
 */
- (void)capture{
    //获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [self.session addInput:input];
    [self.session addOutput:metadataOutput];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.backgroundColor = [UIColor yellowColor].CGColor;
    
    [self.view.layer addSublayer:self.previewLayer];
    
    //设置扫描支持的编码格式(如下设置条形码和二维码兼容)
    metadataOutput.metadataObjectTypes = self.metadataObjectTypes;
    
    //开始捕获
    [self.session startRunning];
}

#pragma mark - 取消事件

/**
 * 取消事件
 */
- (void)cancelAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 打开/关闭 手电筒

- (void)flashlightAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"kaishoudiantong"] forState:UIControlStateSelected];
        self.flashlightHintLabel.textColor = ZFColor(133*Main_Screen_Height/667, 235*Main_Screen_Height/667, 0, 1);
        
        //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
        
    }else{
        [sender setImage:[UIImage imageNamed:@"Flashlight_N"] forState:UIControlStateSelected];
        self.flashlightHintLabel.textColor = ZFWhite;
        
        //关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    if (metadataObjects.count > 0) {
//        [self.session stopRunning];
//        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
//        self.returnScanBarCodeValue(metadataObject.stringValue);
//        
//        if (self.navigationController) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSString *qaMessage = metadataObject.stringValue;
        
        [self handleScanData:qaMessage];
        
    }
}

- (void)handleScanData:(NSString *)outMessage {
    NSString *imei                          = outMessage;
    
    if (imei != nil) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.removeFromSuperViewOnHide =YES;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"加载中";
        HUD.minSize = CGSizeMake(132.f, 108.0f);
        
        NSDictionary *mulDic = @{
                                 @"DeviceCode":imei,
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@ScanCode/DeviceScanCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                
                NSDictionary *arr = [NSDictionary dictionary];
                arr = [dict objectForKey:@"JsonData"];
                
                self.scan = [[ScanCode alloc]init];
                [self.scan setValuesForKeysWithDictionary:arr];
                
                
                __weak typeof(self) weakSelf = self;
                HUD.completionBlock = ^(){
                    
                    if(weakSelf.scan.ScanCodeState == 1)
                    {
                        DSScanPayController *payVC           = [[DSScanPayController alloc]init];
                        payVC.hidesBottomBarWhenPushed            = YES;
                        
                        payVC.SerMerChant = weakSelf.scan.DeviceName;
                        payVC.SerProject = weakSelf.scan.ServiceItems;
                        payVC.Jprice = [NSString stringWithFormat:@"￥%@",weakSelf.scan.OriginalAmt];
                        payVC.Xprice = [NSString stringWithFormat:@"￥%@",weakSelf.scan.Amt];
                        
                        
                        
                        NSRange
                        startRange = [weakSelf.scan.DeviceCode rangeOfString:@":"];
                        
                        NSRange
                        endRange = [weakSelf.scan.DeviceCode rangeOfString:@":"];
                        
                        NSRange
                        range = NSMakeRange(startRange.location
                                            + startRange.length,
                                            endRange.location
                                            - startRange.location
                                            - startRange.length);
                        
                        NSString *result = [weakSelf.scan.DeviceCode substringWithRange:range];
                        payVC.DeviceCode = result;
                        
                        [weakSelf.navigationController pushViewController:payVC animated:YES];
                    }
                    else
                    {
                        [UdStorage storageObject:[NSString stringWithFormat:@"￥%@",weakSelf.scan.OriginalAmt] forKey:@"Jprice"];
                        [UdStorage storageObject:[NSString stringWithFormat:@"%ld",weakSelf.scan.RemainCount] forKey:@"RemainCount"];
                        [UdStorage storageObject:[NSString stringWithFormat:@"%ld",weakSelf.scan.IntegralNum] forKey:@"IntegralNum"];
                        [UdStorage storageObject:[NSString stringWithFormat:@"%ld",weakSelf.scan.CardType] forKey:@"CardType"];
                        [UdStorage storageObject:weakSelf.scan.CardName forKey:@"CardName"];

                        DSStartWashingController *start = [[DSStartWashingController alloc]init];
                        start.hidesBottomBarWhenPushed            = YES;
                        [weakSelf.navigationController pushViewController:start animated:YES];
                    }
                };
                
                [HUD hide:YES afterDelay:1.f];
            }
            else
            {
                [HUD hide:YES];
                [self.view showInfo:@"信息获取失败" autoHidden:YES interval:2];
                //                [self.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSError *error) {
            [HUD hide:YES];
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
            //            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}




- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

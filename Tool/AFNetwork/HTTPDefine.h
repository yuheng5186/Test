#ifndef HTTPDefine_h
#define HTTPDefine_h

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "UdStorage.h"
#import "UIImageView+WebCache.h"

//#pragma mark-服务器
//#define Khttp @"http://api.qiangweilovecar.com/api/"
//
//#define kHTTPImg @"http://api.qiangweilovecar.com"
//#pragma mark-本地
#define Khttp @"http://192.168.2.152:8090/api/"

#define kHTTPImg @"http://192.168.2.152:8090"


#define RGBAA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#endif

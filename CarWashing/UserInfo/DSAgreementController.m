//
//  DSAgreementController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAgreementController.h"

@interface DSAgreementController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation DSAgreementController

- (void) drawNavigation {

    [self drawTitle:@"《蔷薇爱车》用户服务协议"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentView.top                = Main_Screen_Height*30/667;
    self.contentView.backgroundColor    = [UIColor grayColor];
    self.contentView.height             = self.view.height;
    self.webView                        = [[UIWebView alloc] initWithFrame: self.contentView.frame];
//    self.webView.backgroundColor        = [UIColor colorFromHex: @"#111112"];
    self.webView.opaque                 = NO;
    self.webView.delegate               = self;

//    self.webView.scrollView.bounces = NO;
//    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
//    self.webView.scrollView.scrollEnabled = NO;
    [self.webView sizeToFit];
    
    
    [self.contentView addSubview: self.webView];
    
    [self showBlackLoading];

    NSURL * url                     = [NSURL URLWithString: @"http://www.honglisale.cn/qw/index.html"];
    NSURLRequest* request           = [NSURLRequest requestWithURL: url];
    
    [self.webView loadRequest:request];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake (0.0f, 0.0f, 80.0f, 0.0f);

//     [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];
    
//    NSString *string        = @"感谢您成为蔷薇爱尚车的注册用户。\n《蔷薇爱车用户服务协议》《蔷薇爱尚车用户服务协议》（以下简称“本协议”）是由蔷薇爱尚车 (包括PC端、移动端及应用程序)的用户（以下简称“用户或您”）与蔷薇爱尚车的运营方，青岛蔷薇联合实业有限公司即及其关联公司（以下简称“蔷薇”）之间，就APP交易服务等相关事宜共同缔结。 本协议具有合同效力，您应当阅读并遵守本协议。请您务必仔细阅读、充分理解各条款内容，特别是以黑体加粗形式提示您注意的条款。1、本站的各项电子服务的所有权和运作权归蔷薇所有。在您完成用户注册程序后，即表示您自愿接受本协议，正式成为蔷薇的注册用户，并认可本协议全部条款内容。若您不同意本协议，或对本协议中的条款存在任何疑问，请您立即停止蔷薇用户注册程序，并可以选择不使用本APP服务。\n一、协议的确认和接纳2、根据国家法律法规变化及蔷薇运营需要，蔷薇有权对本协议条款不时进行修改，修改后的协议一经发布即刻生效，并代替原来的协议。您可在蔷薇APP随时查阅最新协议。您若不同意更新后的协议，可以且应立即停止接受蔷薇APP依据本协议提供的服务；如您继续使用本APP提供的服务的，即视为同意更新后的协议。蔷薇强烈建议您在使用本APP之前阅读本协议及APP的公告。本协议包括协议正文及所有蔷薇已经发布的，或未来可能发布或更新的各类规则。所有规则为本协议不可分割的组成部分，与本协议正文具有同等法律效力。在您申请注册成为蔷薇注册用户前，请仔细阅读本协议的内容及各类规则。\n二、账户管理1、用户应自行诚信地提供注册资料，用户同意其提供的注册资料真实、准确、完整、合法有效，用户注册资料如有变动的，应及时更新其注册资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应。";
//    UIFont  *stringFont     = [UIFont systemFontOfSize:14];
//    UILabel *agreeLabel     = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, self.contentView.height) font:stringFont text:string isCenter:NO];
//    agreeLabel.numberOfLines    = 0;
//    agreeLabel.top  = 100;
//    agreeLabel.centerX  = Main_Screen_Width/2;
    
}
- (void) webViewDidFinishLoad:(UIWebView *) webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    
    [self drawTitle: title];
    
    [self hideBlackLoading];
    
//    NSInteger height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] intValue];
//    self.webView.frame = CGRectMake(0, 0, Main_Screen_Width, height);
//    
//    NSString *javascript    = [NSString stringWithFormat:@"window.scrollBy(0,%ld)",(long)height];
//    [self.webView stringByEvaluatingJavaScriptFromString:javascript];
    
    
}

- (void) webView: (UIWebView *) webView didFailLoadWithError: (NSError *) error
{
    [self hideBlackLoading];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  GTDetailViewController.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/8.
//

#import "GTDetailViewController.h"
//因为web相关内容不属于UIKit，所以需要引入WebKit
#import <WebKit/WebKit.h>
@interface GTDetailViewController ()<WKNavigationDelegate>
@property(nonatomic,strong,readwrite)WKWebView *webView;
@property(nonatomic,strong,readwrite)UIProgressView *progessView;
@property (nonatomic,copy,readwrite)NSString * URLString;
@end

@implementation GTDetailViewController
-(void)dealloc{
    //在dealloc中移除监听
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (instancetype)initWithURLString:(NSString *)urlString{
    if (self = [super init]) {
        self.URLString = urlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    //添加一个UIProgerssView的子视图
    [self.view addSubview:({
        self.progessView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 20)];
        self.progessView;
    })];
    
    //加载url
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
    
    
    //注册监听 监听加载百分比estimateProgress的值变化
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
//请求代理根据指定的首选项和操作信息导航到新内容的权限。
- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //调用以允许或取消导航，该参数时枚举类型WKNavigationActionPolicy的常量之一
    decisionHandler(WKNavigationActionPolicyAllow);
}
//完成加载后的方法
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"加载完成的方法");
}

//KVO监听接收通知。   当监听到estimatedProgess值变为1时，再执行didFinishNavigation方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context{
    //监听到对象或对象属性值改变后就行的业务逻辑
    self.progessView.progress = self.webView.estimatedProgress;
}
@end

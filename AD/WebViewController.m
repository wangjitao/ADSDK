//
//  WebViewController.m
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 16/9/8.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  广告详情页

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "XHLaunchAd.h"

@interface WebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建webview，并设置大小，"20"为状态栏高度
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 20;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,20,width,height)];
    // 2.创建URL
    NSURL *url = [NSURL URLWithString:self.URLString];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:webView];
    
    webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //完成加载
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

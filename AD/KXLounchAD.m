//
//  KXLounchAD.m
//  ADSDK
//
//  Created by 张永晶 on 2017/10/31.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXLounchAD.h"
#import "XHLaunchAd.h"
#import "WebViewController.h"
#import "Global.h"

@interface KXLounchAD ()

@end

@implementation KXLounchAD

+(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram:(CGRect)rect{
    __block BOOL loadSuccess = NO;
    __block BOOL clickSuccess = NO;
    __block BOOL closeSuccess = NO;
    if (dic[@"code"]!=0) {
        NSLog(@"请求错误");
        return;
    }
    if (dic[@"outputSource"]==0) {
        NSLog(@"不开启广告位");
        return;
    }
    NSArray * arr = dic[@"url_config"];
    NSDictionary * dic1 = arr[0];
    NSString *imgUrlString = dic1[@"img_url"];
    NSString *url = dic1[@"click_url"];
    //1.初始化启动页广告(初始化后,自动添加至视图,不用手动添加)
    if (rect.size.height == 0) {
        rect.size.height = [UIScreen mainScreen].bounds.size.height;
    }
    XHLaunchAd *launchAd = [[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,rect.size.height) andDuration:20];
    //2.设置启动页广告图片的url(必须)---(支持jpg/png静态图,及gif动态图)
    
    
    [launchAd imgUrlString:imgUrlString options:XHWebImageRefreshCached completed:^(UIImage *image, NSURL *url) {
        //异步加载图片完成回调(若需根据图片实际尺寸,刷新广告frame,可在这里操作)
        //launchAd.adFrame = ...;
        loadSuccess = YES;//展示成功
        load(loadSuccess);
    }];
    //是否影藏'倒计时/跳过'按钮[默认显示](可选)
    if (dic[@"ad_icon_visible"]==0) {
        launchAd.hideSkip = YES;
    }else{
        
        launchAd.hideSkip = NO;
    }
    
    
    launchAd.returnValueBlock = ^(BOOL res){
        if (res) {
            closeSuccess = YES;
            close(closeSuccess);
        }
    };
    
    //广告点击事件(可选)
    launchAd.clickBlock = ^()
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        clickSuccess = YES;
        click(clickSuccess);
    };
    
}

//图片开屏广告 - 网络数据

+(void)imageTypeWithVC:(UIViewController *)vc AndAppKey:(NSString *)key andDict:(NSDictionary *)dic andFram:(CGRect)rect{
    
    //1.初始化启动页广告(初始化后,自动添加至视图,不用手动添加)
    if (rect.size.height == 0) {
        rect.size.height = [UIScreen mainScreen].bounds.size.height;
    }
    XHLaunchAd *launchAd = [[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,rect.size.height) andDuration:20];
    //2.设置启动页广告图片的url(必须)---(支持jpg/png静态图,及gif动态图)
    //静态图url

    NSArray * arr = dic[@"url_config"];
    NSDictionary * dic1 = arr[0];
    NSString *imgUrlString = dic1[@"img_url"];
    NSString *url = dic1[@"click_url"];
    
    [launchAd imgUrlString:imgUrlString options:XHWebImageRefreshCached completed:^(UIImage *image, NSURL *url) {
        //异步加载图片完成回调(若需根据图片实际尺寸,刷新广告frame,可在这里操作)
        //launchAd.adFrame = ...;
    }];
    //是否影藏'倒计时/跳过'按钮[默认显示](可选)
    launchAd.hideSkip = NO;
    //广告点击事件(可选)
    launchAd.clickBlock = ^()
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    };
    
    
    
    
}



@end

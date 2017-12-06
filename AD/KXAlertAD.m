//
//  KXAlertAD.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXAlertAD.h"
#import "DLAlertView.h"
#import "WebViewController.h"
@implementation KXAlertAD
+(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close{
    NSLog(@"111");
    BOOL loadSuccess = NO;
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
    if (imgUrlString) {
        loadSuccess = YES;//展示成功
        load(loadSuccess);
    }

    DLAlertView *alertView = [[DLAlertView alloc] initWithImageURL:imgUrlString AndClickCallBack:^{
        WebViewController * WV = [[WebViewController alloc] init];
        WV.URLString = url;
        [vc.navigationController pushViewController:WV animated:YES];
        clickSuccess = YES;
        click(clickSuccess);
    } andCloseCallBack:^{
        closeSuccess = YES;
        close(closeSuccess);
    }];
    
    [alertView show];
    
    
    
}
@end

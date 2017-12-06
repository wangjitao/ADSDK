//
//  KXButtonAD.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXButtonAD.h"
#import "WebViewController.h"
#import "zyjbtn.h"
#import "UIImageView+XHWebCache.h"
//屏幕宽
#define kScreenW [UIScreen mainScreen] .bounds.size.width
//屏幕高
#define kScreenH [UIScreen mainScreen] .bounds.size.height

@implementation KXButtonAD


+(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram: (CGRect)rect{
    
    BOOL loadSuccess = NO;
    __block BOOL clickSuccess = NO;
    BOOL closeSuccess = NO;

    
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
    //__block zyjbtn *bButton=[zyjbtn buttonWithType:UIButtonTypeCustom];
    //bButton.frame = rect;
    if (imgUrlString) {
        loadSuccess = YES;//展示成功
        load(loadSuccess);
    }
    
//
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//
//    [window addSubview:bButton];
   
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlString]];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
#warning 改。。。
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:rect];
    [imageV xh_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:nil options:XHWebImageDefault completed:nil];
    imageV.userInteractionEnabled = YES;
    
    __block zyjbtn *bButton=[zyjbtn buttonWithType:UIButtonTypeCustom];
    bButton.frame = imageV.bounds;
    
    [imageV addSubview:bButton];
    
    //[bButton addSubview:imageV];
#warning 改。。。
    //UIImage* resultImage = [UIImage imageWithData: imageData];
    //[bButton setImage:resultImage forState: UIControlStateNormal];
    //[vc.navigationController.view addSubview:bButton];
     
    //[bButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imgUrlString] forState:UIControlStateNormal];
//    [vc.view addSubview:bButton];
    
    [vc.view insertSubview:imageV aboveSubview:vc.view];
    [bButton setBlock:^(UIButton *button) {
  
//        [bButton removeFromSuperview];
        WebViewController * WV = [[WebViewController alloc]init];
        WV.URLString = url;
        [vc.navigationController pushViewController:WV animated:YES];
        clickSuccess = YES;
        click(clickSuccess);
    }];
    close(closeSuccess);    
}


@end

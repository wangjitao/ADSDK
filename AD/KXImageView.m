//
//  KXImageView.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXImageView.h"
#import "zyjbtn.h"
#import "WebViewController.h"
//#import "UIButton+WebCache.h"
@implementation KXImageView
+(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram:(CGRect)rect{
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
    
#warning 改。。。
    float Y = rect.origin.y;

    zyjbtn *bButton=[zyjbtn buttonWithType:UIButtonTypeCustom];
    bButton.frame=CGRectMake(0,Y,vc.view.frame.size.width, rect.size.height);
    
    if (imgUrlString) {
        loadSuccess = YES;//展示成功
        load(loadSuccess);
    }
   
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlString]];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
    UIImage* resultImage = [UIImage imageWithData: imageData];
    [bButton setImage:resultImage forState: UIControlStateNormal];
    [bButton setBlock:^(UIButton *button) {
        
        WebViewController * WV = [[WebViewController alloc]init];
        WV.URLString = url;
        [vc.navigationController pushViewController:WV animated:YES];
        clickSuccess = YES;
        click(clickSuccess);
    }];
    [vc.view addSubview:bButton];
    zyjbtn *bButton2=[zyjbtn buttonWithType:UIButtonTypeCustom];
    float Y2;
    if (Y == 64){
        
        Y2 = 64;
        
    }else{
        
        Y2 = vc.view.frame.size.height-vc.view.frame.size.width*2/5;
    }
    
    bButton2.frame=CGRectMake(vc.view.frame.size.width-20,Y2,20, 20);
    [bButton2 setImage:[UIImage imageNamed:@"banner_close.png"] forState:UIControlStateNormal];
    [vc.view addSubview:bButton2];
    [bButton2 setBlock:^(UIButton *button) {
        
        [bButton2 removeFromSuperview];
        [bButton removeFromSuperview];
        closeSuccess = YES;
        close(closeSuccess);
    }];
    
    
   
}
@end

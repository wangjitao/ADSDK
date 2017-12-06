//
//  ADConfig.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/6.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "ADConfig.h"
#import "Global.h"
#import "KXBanner.h"
#import "KXLounchAD.h"
#import "KXAlertAD.h"
#import "KXButtonAD.h"
#import "KXImageView.h"
#import "KXTableView.h"
#import "Singleton.h"
static NSString * AppKey;
@implementation ADConfig

+ (void)setAppKey:(NSString *)key{
    
    AppKey = key;
    
}

+ (void)initAdWithAdslotID:(NSString *)adslot_id AndPresentViewController:(UIViewController *)vc AndFram: (CGRect)rect AndLoad:(ReturnloadSuccess) load_S AndClick:(ReturnclickSuccess) click_S AndClose:(Returnclose) close_S{
    
    __block BOOL loadSuccess1 = NO;
    __block BOOL clickSuccess1 = NO;
    __block BOOL close1 = NO;
    
    NSString * key = AppKey;
    NSData * data = [Global getJSONDateWithAdslotId:adslot_id AndAppKey:key];
    NSDictionary * dict = [Global getJSONObjectWithData:data];
    NSLog(@"appkey==%@",key);
    NSDictionary * da_ta = dict[@"data"];
    NSString * ad_type = da_ta[@"ad_type"];
    
    NSLog(@"=========%@",ad_type);
    
    if (!ad_type) {
        NSLog(@"请保证您的appkey,和AdslotID是正确的");
        load_S(loadSuccess1);
        click_S(clickSuccess1);
        close_S(close1);
        return;
    }
    
    if ([ad_type isEqualToString:@"1"]) {
        //      插屏
        [KXAlertAD initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        }];
        return;
    } else if ([ad_type isEqualToString:@"2"]){
        // 横幅
        KXBanner *banner = [[KXBanner alloc] init];
        [banner initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        } AndFram_Y:rect.origin.y];
        return;
    }else if ([ad_type isEqualToString:@"3"]){
        // 浮标
        [KXButtonAD initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        } AndFram: rect];
        return;
    }else if ([ad_type isEqualToString:@"4"]){
        //开屏
        
        [KXLounchAD initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
        } AndFram:rect];
    }else if ([ad_type isEqualToString:@"5"]){
        //banner
        [KXImageView initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        } AndFram:rect];
        return;
    }else if ([ad_type isEqualToString:@"7"]){
        //信息流小
        if (rect.size.height < 300) {
            rect.size.height = 300;
        }
        KXTableView * table = [[KXTableView alloc]init];
        [table initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        } AndSizeType:@"1" AndFrame:CGRectMake(0, rect.origin.y,vc.view.frame.size.width, rect.size.height)];
        
        return;
    }else if ([ad_type isEqualToString:@"6"]){
        // 信息流大
        if (rect.size.height < 300) {
            rect.size.height = 300;
        }
        KXTableView * table = [[KXTableView alloc]init];
        [table initWithAppKey:key AndPresentViewController:vc AndDictionary:da_ta AndLoad:^(BOOL loadSuccess) {
            
            if (loadSuccess) {
                loadSuccess1 = YES;//展示成功
                load_S(loadSuccess1);
            }
        } AndClick:^(BOOL clickSuccess) {
            if (clickSuccess) {
                clickSuccess1 = YES;
                click_S(clickSuccess1);
            }
        } AndClose:^(BOOL close) {
            if (close) {
                close1 = YES;
                close_S(close1);
            }
            
        } AndSizeType:@"2" AndFrame:CGRectMake(0, rect.origin.y,vc.view.frame.size.width, rect.size.height)];
        
        
        return;
    }else{
        load_S(loadSuccess1);
        click_S(clickSuccess1);
        close_S(close1);
        NSLog(@"请保证您的appkey和AdslotID是正确的");
        return;
    }
    
    
}

@end


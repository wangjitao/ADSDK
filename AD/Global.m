//
//  Global.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/6.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "Global.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "CHKeychain.h"
@implementation Global


//数据请求，获取json数据
+(NSData *)getJSONDateWithAdslotId: (NSString *)AdslotId AndAppKey:(NSString *)appKey {
    NSString * urlString = @"https://www.remaibd.cn/index.php?r=/v1/activity/postweb";
    NSString * args = [self getReqUrlString];
    NSString * url_str = [NSString stringWithFormat:@"%@&adslotId=%@&appKey=%@",args,AdslotId,appKey];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    
    //1.确定请求路径
    NSURL * url = [NSURL URLWithString:urlString];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [url_str dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:10];
    //3.获得会话对象
    NSURLSession * session = [NSURLSession sharedSession];
    //4.根据会话对象创建一个Task(发送请求）
    __block NSData * _data;
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            //6.解析数据
            _data = data;
            dispatch_semaphore_signal(semaphore);   //发送信号
        }
    }];
    
    //5.执行任务
    [dataTask resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
    return _data;
    
    
}
//数据解析
+ (NSDictionary *)getJSONObjectWithData:(NSData *)data{
    
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dict;
    
}
+(NSString *)getReqUrlString{
    
    NSString * req_id = [self getRequestID];
    NSString * device_id = [CHKeychain load:@"idfv"];
    if (!device_id) {
        device_id = [self getIDFV];
        [CHKeychain save:@"idfv" data:device_id];
        
    }
    NSString * IDFA = [self getIDFA];
    NSDictionary *device_info = @{@"idfa" : IDFA};
    BOOL isYes = [NSJSONSerialization isValidJSONObject:device_info];
    
    NSString * jsonStr;
    if (isYes) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:device_info options:NSJSONWritingPrettyPrinted error:NULL];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonStr);
        
    } else {
        
        NSLog(@"JSON数据生成失败，请检查数据格式");
        
    }
    
    
    NSString * device_type = @"1";
    NSString * urlStr = [NSString stringWithFormat:@"request_id=%@&device_id=%@&device_type=%@&device_info=%@",req_id,device_id,device_type,jsonStr];
    return urlStr;
}
+(NSString *)getIDFA{
    
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}
+(NSString *)getIDFV{
    
    NSString * idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return idfv;
}
+(NSString *)getRequestID{
    NSString * req_id1 = [self randomStringWithLength:35];
    NSString * req_id2 = [self currentTimeStr];
    NSString * req_id = [NSString stringWithFormat:@"%@%@",req_id1,req_id2];
    return req_id;
}
+(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}
//获取当前时间戳
+(NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


@end


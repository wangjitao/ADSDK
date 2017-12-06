//
//  Global.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/6.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject
+(NSData *)getJSONDateWithAdslotId: (NSString *)AdslotId AndAppKey:(NSString *)appKey;
+(NSDictionary *)getJSONObjectWithData:(NSData *)data;
@end

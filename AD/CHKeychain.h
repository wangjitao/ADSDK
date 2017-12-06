//
//  CHKeychain.h
//  Test
//
//  Created by caojunrui on 15/4/18.
//  Copyright (c) 2015年 Junrui Cao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKeychain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end

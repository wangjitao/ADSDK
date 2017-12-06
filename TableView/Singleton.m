//
//  Singleton.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/20.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "Singleton.h"

#import "Singleton.h"
@implementation Singleton
// 单例对象
static Singleton *instance;

// 单例
+ (Singleton *) GetInstance {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
            
        }
    }
    return instance;
}
-(id) init
{
    if (self = [super init]) {

        self.isClick = NO;
        self.isLoad = NO;
    }
    return self;
}
@end



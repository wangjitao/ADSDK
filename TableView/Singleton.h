//
//  Singleton.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/20.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
//单例方法
@property(assign,nonatomic)BOOL isLoad;
@property(assign,nonatomic)__block BOOL isClick;
+ (Singleton *) GetInstance;
@end

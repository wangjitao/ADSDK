//
//  ADConfig.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/6.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ReturnloadSuccess) (BOOL loadSuccess);
typedef void (^ReturnclickSuccess) (BOOL clickSuccess);
typedef void (^Returnclose) (BOOL close);
@interface ADConfig : NSObject

+(void)initAdWithAdslotID:(NSString *)adslot_id AndPresentViewController:(UIViewController *)vc AndFram: (CGRect)rect AndLoad:(ReturnloadSuccess) load_S AndClick:(ReturnclickSuccess) click_S AndClose:(Returnclose) close_S;

+(void)setAppKey:(NSString *)key;
@end

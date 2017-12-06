//
//  KXButtonAD.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^ReturnloadSuccess) (BOOL loadSuccess);
typedef void (^ReturnclickSuccess) (BOOL clickSuccess);
typedef void (^Returnclose) (BOOL close);
@interface KXButtonAD : NSObject
+(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram: (CGRect)rect;

@end

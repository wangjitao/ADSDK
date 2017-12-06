//
//  KXBanner.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/1.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ReturnloadSuccess) (BOOL loadSuccess);
typedef void (^ReturnclickSuccess) (BOOL clickSuccess);
typedef void (^Returnclose) (BOOL close);
@interface KXBanner : NSObject
@property (nonatomic,copy)  ReturnloadSuccess is_load;
@property (nonatomic,copy)  ReturnclickSuccess is_click;

-(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram_Y:(float)y;
@end


//
//  KXTableView.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ReturnloadSuccess) (BOOL loadSuccess);
typedef void (^ReturnclickSuccess) (BOOL clickSuccess);
typedef void (^Returnclose) (BOOL close);
@interface KXTableView : NSObject
@property (nonatomic,copy)  ReturnloadSuccess is_load;
@property (nonatomic,copy)  ReturnclickSuccess is_click;
-(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndSizeType:(NSString *)type AndFrame:(CGRect)rect;
@end

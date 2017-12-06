//
//  zyjViewController.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnResult) (NSString * res);
typedef void (^ReturnloadSuccess) (BOOL loadSuccess);
typedef void (^ReturnclickSuccess) (BOOL clickSuccess);
@interface zyjViewController : UIViewController
@property(nonatomic,strong)NSDictionary * dict;
@property(nonatomic,strong)NSString * sizeType;
@property(nonatomic,assign)CGRect rect;

@end

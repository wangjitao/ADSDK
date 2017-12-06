//
//  zyjbtn.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(UIButton * button);
@interface zyjbtn : UIButton
@property (nonatomic, copy) Block block;
@property (nonatomic,assign) BOOL click;
@end

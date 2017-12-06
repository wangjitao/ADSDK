//
//  zyjbtn.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/2.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "zyjbtn.h"

@implementation zyjbtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)doAction:(UIButton *)button {
    self.click = YES;
    self.block(button);
}
@end

//
//  zyjCellTableViewCell.h
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zyjbtn.h"
@interface zyjCellTableViewCell : UITableViewCell
@property (weak, nonatomic) UIImageView *imageViewBackground;
@property (weak, nonatomic)  zyjbtn*imagebtn;
@property (weak,nonatomic) UILabel * lab;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndSizeType:(NSString *)type;
@end

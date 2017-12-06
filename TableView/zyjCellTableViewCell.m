//
//  zyjCellTableViewCell.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "zyjCellTableViewCell.h"
@interface zyjCellTableViewCell ()

@end
@implementation zyjCellTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndSizeType:(NSString *)type{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([type isEqualToString:@"1"]) {
            CGRect rect = CGRectMake(10, 10,100, 20);
            
            UILabel * lable = [[UILabel alloc] initWithFrame:rect];
            lable.numberOfLines = 0;
            self.lab = lable;
            
            [self.contentView addSubview:_lab];
            zyjbtn * bt = [zyjbtn buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-250,10,225,140 );
            self.imagebtn = bt;
            [self.contentView addSubview:self.imagebtn];
        }else{
            
            CGRect rect = CGRectMake(10, 10,self.contentView.frame.size.width, 20);
            
            UILabel * lable = [[UILabel alloc] initWithFrame:rect];
            lable.numberOfLines = 0;
            self.lab = lable;
            
            [self.contentView addSubview:_lab];
            zyjbtn * bt = [zyjbtn buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(5,35,[UIScreen mainScreen].bounds.size.width-10,([UIScreen mainScreen].bounds.size.width-10)*3/7 );
            self.imagebtn = bt;
            [self.contentView addSubview:self.imagebtn];
        }
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  KXTableView.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXTableView.h"
#import "zyjCellTableViewCell.h"
#import "WebViewController.h"
#import "zyjViewController.h"
//#import "UIButton+WebCache.h"
#import "Singleton.h"

@interface KXTableView ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _imgArr;
    NSMutableArray * _urlArr;
    NSString * _tit;
    UIViewController *_VC;
    NSString * _sizeType;
    Singleton * sing ;
    ReturnclickSuccess _click;
    CGFloat  _cell_Height;
}
@end
@implementation KXTableView


-(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndSizeType:(NSString *)type AndFrame:(CGRect)rect{
    if (dic[@"code"]!=0) {
        NSLog(@"请求错误");
        return;
    }
    if (dic[@"outputSource"]==0) {
        NSLog(@"不开启广告位");
        return;
    }
    _click = click;
    sing = [Singleton GetInstance];
    _VC = [[UIViewController alloc]init];
    _VC = vc;
    _sizeType = type;
    _cell_Height = rect.size.height;
    UITableView *myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [myTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.showsVerticalScrollIndicator = NO;
    //添加到父视图
    [vc.view addSubview: myTableView];
    myTableView.delegate = self;//负责外观
    myTableView.dataSource = self;//负责数据
#warning 改。。。
    _tit = dic[@"information_title"];
    NSArray * arr = dic[@"url_config"];
    _imgArr = [[NSMutableArray alloc]init];
    _urlArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<arr.count; i++) {
        [_imgArr addObject:arr[i][@"img_url"]];
        [_urlArr addObject:arr[i][@"click_url"]];
    }
    
    [myTableView reloadData];
    
    load(YES);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imgArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"zyj";
    zyjCellTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[zyjCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid AndSizeType:_sizeType];
    }
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_imgArr[indexPath.row]]];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
    UIImage* resultImage = [UIImage imageWithData: imageData];
    [cell.imagebtn setImage:resultImage forState: UIControlStateNormal];
//    [cell.imagebtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_imgArr[indexPath.row]] forState:UIControlStateNormal];
    [cell.lab setText:_tit];
    [cell.imagebtn setBlock:^(UIButton *button) {
        _click(YES);
        WebViewController * WV = [[WebViewController alloc]init];
        WV.URLString = _urlArr[indexPath.row];
        [_VC.navigationController pushViewController:WV animated:YES];
     
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_sizeType isEqualToString:@"1"]) {
        return 160;
    } else {
        return 250;
    }
    //return _cell_Height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController * WV = [[WebViewController alloc]init];
    WV.URLString = _urlArr[indexPath.row];
    [_VC.navigationController pushViewController:WV animated:YES];
    _click(YES);
}

@end

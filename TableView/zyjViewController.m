//
//  zyjViewController.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/5.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "zyjViewController.h"
#import "zyjCellTableViewCell.h"
#import "WebViewController.h"
#import "Singleton.h"
@interface zyjViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * imgArr;
@property(nonatomic,strong)NSMutableArray * urlArr;
@property(nonatomic,strong)NSString * tit;
@property(nonatomic,strong)NSString * res;
@property(nonatomic,strong)__block Singleton * sing ;
@end

@implementation zyjViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.imgArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"zyj";
    zyjCellTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[zyjCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid AndSizeType:self.sizeType];
    }
//    [cell.imagebtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imgArr[indexPath.row]] forState:UIControlStateNormal];
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgArr[indexPath.row]]];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
    UIImage* resultImage = [UIImage imageWithData: imageData];
    [cell.imagebtn setImage:resultImage forState: UIControlStateNormal];
    [cell.lab setText:self.tit];
    [cell.imagebtn setBlock:^(UIButton *button) {
        
        WebViewController * WV = [[WebViewController alloc]init];
        WV.tableviewStr = @"1";
        WV.URLString = _urlArr[indexPath.row];
        [self.navigationController pushViewController:WV animated:YES];
        
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sizeType isEqualToString:@"1"]) {
        return 160;
    }else{
        
        return 250;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sing = [Singleton GetInstance];
    //Grouped属性，在滚动时分区头部一起移动
    UITableView *myTableView = [[UITableView alloc]initWithFrame:_rect style:UITableViewStylePlain];
    [myTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //添加到父视图
    [self.view addSubview: myTableView];
    myTableView.delegate = self;//负责外观
    myTableView.dataSource = self;//负责数据
    self.tit = _dict[@"ad_title"];
    NSArray * arr = _dict[@"url_config"];
    self.imgArr = [[NSMutableArray alloc]init];
    self.urlArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<arr.count; i++) {
        [self.imgArr addObject:arr[i][@"img_url"]];
        [self.urlArr addObject:arr[i][@"click_url"]];
    }
    _sing.isLoad = YES;
    [myTableView reloadData];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController * WV = [[WebViewController alloc]init];
    WV.URLString = self.urlArr[indexPath.row];
    WV.tableviewStr = @"1";
    [self.navigationController pushViewController:WV animated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

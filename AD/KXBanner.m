//
//  KXBanner.m
//  ADSDK
//
//  Created by 张永晶 on 2017/11/1.
//  Copyright © 2017年 张永晶. All rights reserved.
//

#import "KXBanner.h"
#import "WebViewController.h"

#define ScreenSize      [UIScreen mainScreen].bounds.size
#define SELF_WIDTH     ScreenSize.width
#define SELF_HEIGHT    100

ReturnclickSuccess _click;
NSMutableArray * img_arr;
NSMutableArray * url_arr;
UIViewController *_VC;
//CCCycleScrollView *_cyclePlayView;

@interface KXBanner()<UIScrollViewDelegate>{
    
    
    NSTimer *_timer;
    
    UIPageControl *_pageControl;
    
    UIScrollView *_scrollView;
    
    NSInteger _imageTotalCount;
}

@end
@implementation KXBanner

-(void)initWithAppKey:(NSString *)Key AndPresentViewController:(UIViewController *)vc AndDictionary:(NSDictionary *)dic AndLoad:(ReturnloadSuccess) load AndClick:(ReturnclickSuccess) click AndClose:(Returnclose) close AndFram_Y:(float)y{
    
    _VC = [[UIViewController alloc] init];
    _VC = vc;
    _click = click;
    if (dic[@"code"]!=0) {
        NSLog(@"请求错误");
        return;
    }
    if (dic[@"outputSource"]==0) {
        NSLog(@"不开启广告位");
        return;
    }
    NSArray * arr = dic[@"url_config"];
#warning 改。。。。。
    img_arr = [[NSMutableArray alloc]init];
    url_arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<arr.count; i++) {
        [img_arr addObject:arr[i][@"img_url"]];
        [url_arr addObject:arr[i][@"click_url"]];
    }
    _imageTotalCount = img_arr.count;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, vc.view.frame.size.width, 100)];
    
    //_scrollView.backgroundColor = [UIColor redColor];
    
    _scrollView.contentOffset = CGPointZero;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    _scrollView.scrollEnabled = NO;
#warning 改。。。
    _scrollView.contentSize = CGSizeMake(vc.view.frame.size.width*(img_arr.count+1), 100);
    
    [vc.view addSubview:_scrollView];
    
    for (int i = 0; i<img_arr.count ; i++) {
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*vc.view.frame.size.width, 0, vc.view.frame.size.width, _scrollView.frame.size.height)];
        
        //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[i]]];
        
        //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
        UIImage* resultImage = [UIImage imageWithData: imageData];
        [imageV setImage:resultImage];
        imageV.userInteractionEnabled = YES;
        
        imageV.tag = 100+i;
        
        [_scrollView addSubview:imageV];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        
        [imageV addGestureRecognizer:tap];
    }
#warning 改。。。
    UIImageView *lastView = [[UIImageView alloc]initWithFrame:CGRectMake(vc.view.frame.size.width * img_arr.count, 0, vc.view.frame.size.width, _scrollView.frame.size.height)];
    lastView.userInteractionEnabled = YES;
    lastView.tag = 100;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
    
    [lastView addGestureRecognizer:tap];
    
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
    NSData* imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[0]]];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
    UIImage* resultImage1 = [UIImage imageWithData: imageData1];
    [lastView setImage:resultImage1];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runLoopImages) userInfo:nil repeats:YES];
    
    [_scrollView addSubview:lastView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((vc.view.frame.size.width - 300)/2, vc.view.frame.size.height - 20 - 20, 300, 20)];
    
    _pageControl.currentPage = 1;
    
    //    _pageControl.backgroundColor = [UIColor blackColor];
    
    _pageControl.numberOfPages = img_arr.count;
    
    _pageControl.alpha = 0.5;
    
    [vc.view addSubview:_pageControl];
    
    load(YES);
    
    
    
    
    
}



-(void)clickImage:(UITapGestureRecognizer *)tap{
    
    //    [self.delegate clickImageTag:tap.view.tag];
    WebViewController * WV = [[WebViewController alloc]init];
#warning 改。。。
    WV.URLString = url_arr[tap.view.tag-100];
    [_VC.navigationController pushViewController:WV animated:YES];
    _click(YES);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/_VC.view.frame.size.width;
    _pageControl.currentPage = page;
    
}
-(void)runLoopImages{
    
    CGFloat w = _VC.view.frame.size.width;
    
    
    [UIView animateWithDuration:1 animations:^{
        
        
        _scrollView.contentOffset=CGPointMake(_scrollView.contentOffset.x+w, 0);
        
    } completion:^(BOOL finished) {
        
        
        if(_scrollView.contentOffset.x==_VC.view.frame.size.width*_imageTotalCount)
            
            _scrollView.contentOffset=CGPointMake(0, 0);
        
    }];
    
    _pageControl.currentPage = _scrollView.contentOffset.x/w  ;
    
    if (_scrollView.contentOffset.x == _imageTotalCount*_VC.view.frame.size.width) {
        
        _pageControl.currentPage = 0;
    }
}


@end






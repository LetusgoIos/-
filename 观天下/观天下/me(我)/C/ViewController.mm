//
//  ViewController.m
//  POI搜索百度地图
//
//  Created by MS on 15/9/1.
//  Copyright (c) 2015年 MS. All rights reserved.
//
#import "RDVTabBarController.h"
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _poisearch = [[BMKPoiSearch alloc]init];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 20+64, 19, 27)];
    label1.text = @"在";
    
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(137, 20+64, 68, 27)];
    label2.text = @"市内查找";
    [self.view addSubview:label2];
    
    
    
    _cityText = [[UITextField alloc]initWithFrame:CGRectMake(51, 20+64, 78, 31)];
    [self.view addSubview:_cityText];
    _cityText.borderStyle = UITextBorderStyleRoundedRect;
    _cityText.delegate = self;
    
    _keyText = [[UITextField alloc]initWithFrame:CGRectMake(219 , 20+64, 110, 31)];
    _keyText.borderStyle = UITextBorderStyleRoundedRect;
    _keyText.delegate = self;
    
    _cityText.text = @"北京";
    _keyText.text  = @"千锋";
    
    
    
    
    //    地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 82 +64, self.view.frame.size.width, self.view.frame.size.height-82)];
    
    // 设置地图级别
    [_mapView setZoomLevel:13];
    _nextPageButton.enabled = false;
    _mapView.isSelectedAnnotationViewFront = YES;
    
    [self.view addSubview:_keyText];
    

    
    [self.view addSubview:_mapView];
    
    
//    按钮
    _nextPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextPageButton.frame = CGRectMake(30, 47 +64, 100, 31);
    [_nextPageButton setTitle:@"开始搜索" forState:UIControlStateNormal];
    [_nextPageButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_nextPageButton addTarget:self action:@selector(onClickOk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextPageButton];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(180 +30, 47 +64, 100, 31);
    [btn setTitle:@"下一组数据" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClickNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    
    
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil
    
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}



- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)onClickOk
{
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
    
    
}


-(void)onClickNextPage
{
    curPage++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
 }
#pragma mark -
#pragma mark implement BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

@end

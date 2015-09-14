//
//  ViewController.h
//  POI搜索百度地图
//
//  Created by MS on 15/9/1.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface ViewController : UIViewController<BMKMapViewDelegate, BMKPoiSearchDelegate,UITextFieldDelegate>
{
    BMKMapView* _mapView;
    UITextField* _cityText;
    UITextField* _keyText;
    UIButton* _nextPageButton;
    
    
    BMKPoiSearch* _poisearch;
    int curPage;
}


@end


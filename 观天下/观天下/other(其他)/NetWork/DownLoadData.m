//
//  DownLoadData.m
//  007AFN的使用
//
//  Created by 黎跃春 on 15/5/18.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import "DownLoadData.h"
#import "AFAppDotNetAPIClient.h"
#import "GDataXMLNode.h"
#import "NewsMode.h"
#import "TitileMode.h"
#import "CharacterMode.h"
#import "PictureMode.h"
@implementation DownLoadData

#pragma mark --新闻模块
+ (NSURLSessionDataTask *)getNewsPageData:(void (^) (id obj, NSError *err))block withPage:(int)page
{
    
        NSString *url = [NSString stringWithFormat:@"http://zaijiawan.com/news/news/getNews.jsp?appname=readingnews360junshi&version=2.2.1&os=ios&hardware=iphone&timestamp=0&page=%d",page];
    return [[AFAppDotNetAPIClient sharedClient]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        存放数据某型
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:responseObject options:0 error:nil];
//      XML解析
        NSArray * titlesArr = [document nodesForXPath:@"//news" error:nil];
        for (GDataXMLElement * newsElement in titlesArr) {
           
            
            NewsMode *newsMode = [[NewsMode alloc]init];
            
            GDataXMLElement *newEle =  [newsElement elementsForName:@"newUrl"][0];
            NSString *newsUrl  = newEle.stringValue;
              newsMode.newsUrl = newsUrl;

         
            
            
            GDataXMLElement *newsTitleEle =  [newsElement elementsForName:@"newsTitle"][0];
            NSString *newsTitle  = newsTitleEle.stringValue;
            newsMode.newsTitle = newsTitle;
            
            
            GDataXMLElement *imgUrlEle =  [newsElement elementsForName:@"imgUrl"][0];
            NSString *imgUrl  = imgUrlEle.stringValue;
            newsMode.imgUrl = imgUrl;
            
            
            GDataXMLElement *newsCommentsEle =  [newsElement elementsForName:@"newsComments"][0];
            NSString *newsComments  = newsCommentsEle.stringValue;
            newsMode.newsComments = newsComments;
            
            
            GDataXMLElement *timeEle =  [newsElement elementsForName:@"time"][0];
            NSString *time  = timeEle.stringValue;
            newsMode.time = time;
            
            [arr addObject:newsMode];
        }
        
        
        if (block) {
            block(arr,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        if (block) {
            block(nil,error);
        }
    }];
    

}
#pragma mark -- 标题模块
+ (NSURLSessionDataTask *)getTitlePageData:(void (^) (id obj, NSError *err))block withPage:(int)page
{
    
    NSString *url = [NSString stringWithFormat:@"http://zaijiawan.com/news/news/getGalleryNews.jsp?appname=readingnews360junshi&version=2.2.1&os=ios&hardware=iphone"];
    return [[AFAppDotNetAPIClient sharedClient]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

        
        //        存放数据某型
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:responseObject options:0 error:nil];
        //      XML解析
        NSArray * titlesArr = [document nodesForXPath:@"//news" error:nil];
        for (GDataXMLElement * newsElement in titlesArr) {
            

            TitileMode *newsMode = [[TitileMode alloc]init];
            
            GDataXMLElement *newEle =  [newsElement elementsForName:@"newUrl"][0];
            NSString *newsUrl  = newEle.stringValue;
            newsMode.newsUrl = newsUrl;
            
            GDataXMLElement *newsTitleEle =  [newsElement elementsForName:@"newsTitle"][0];
            NSString *newsTitle  = newsTitleEle.stringValue;
            newsMode.newsTitle = newsTitle;
            
            
            GDataXMLElement *imgUrlEle =  [newsElement elementsForName:@"imgUrl"][0];
            NSString *imgUrl  = imgUrlEle.stringValue;
            newsMode.imgUrl = imgUrl;
            
            [arr addObject:newsMode];
         }
          if (block) {
            block(arr,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        if (block) {
            block(nil,error);
        }
    }];

}
#pragma mark -- 笑文模块
+ (NSURLSessionDataTask *)getCharacterPageData:(void (^) (id obj, NSError *err))block withPage:(int)page
{
    
    NSString *url = [NSString stringWithFormat:@"http://jbls.qingyou.cn/inter/inter/shiwen?page=%d&userid=3869",page];
    return [[AFAppDotNetAPIClient sharedClient]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = json[@"alljson"];
               //        存放数据某型
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
            CharacterMode *character = [CharacterMode appCharaWithDic:obj];
            [arr addObject:character];
        }];
         if (block) {
            block(arr,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        
        if (block) {
            block(nil,error);
        }
    }];
    
}
#pragma mark -- 笑图模块

+ (NSURLSessionDataTask *)getPicPageData:(void (^) (id obj, NSError *err))block withPage:(int)page
{
    NSString *url = [NSString stringWithFormat:@"http://jbls.qingyou.cn/inter/inter/shipic?page=%d&userid=3869",page];
    return [[AFAppDotNetAPIClient sharedClient]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = json[@"alljson"];
        //        存放数据某型
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        [dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            PictureMode *character = [PictureMode appWithDic:obj];
            [arr addObject:character];
        }];
        if (block) {
            block(arr,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        if (block) {
            block(nil,error);
        }
    }];
    
}

#pragma mark -- 笑文详情页
+ (NSURLSessionDataTask *)getChDetailsPageData:(void (^) (id obj, NSError *err))block withPage:(int)page
{
    
        NSString *url = [NSString stringWithFormat:@"http://jbls.qingyou.cn/inter/inter/Comment?sid=%d&type=1",page];
    return [[AFAppDotNetAPIClient sharedClient]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
    
}

@end










//
//  DownLoadData.h
//  007AFN的使用
//
//  Created by 黎跃春 on 15/5/18.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadData : NSObject
//限免页面接口
//block   void (^) (id obj, NSError *err)
//+ (NSURLSessionDataTask *)getILimitFreePageData:(void (^) (id obj, NSError *err))block withPage:(int)page;

//新闻模块
+ (NSURLSessionDataTask *)getNewsPageData:(void (^) (id obj, NSError *err))block withPage:(int)page;

//标题模块
+ (NSURLSessionDataTask *)getTitlePageData:(void (^) (id obj, NSError *err))block withPage:(int)page;

//笑文模块
+ (NSURLSessionDataTask *)getCharacterPageData:(void (^) (id obj, NSError *err))block withPage:(int)page;

//笑文笑图
+ (NSURLSessionDataTask *)getPicPageData:(void (^) (id obj, NSError *err))block withPage:(int)page;
@end
















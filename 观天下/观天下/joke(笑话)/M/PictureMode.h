//
//  PictureMode.h
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureMode : NSObject
@property(nonatomic,copy)NSString *collsta;
@property(nonatomic,copy)NSString *myId;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *pathimg;
@property(nonatomic,copy)NSArray *img;
@property(nonatomic,copy)NSString *praise;
@property(nonatomic,copy)NSString *nopraise;
@property(nonatomic,copy)NSString *coll;
@property(nonatomic,copy)NSString *forward;
@property(nonatomic,assign)int *coms;
@property(nonatomic,copy)NSString *addtime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(PictureMode *)appWithDic:(NSDictionary *)dic;

@end

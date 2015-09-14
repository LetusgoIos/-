//
//  CharaNextMode.h
//  观天下
//
//  Created by MS on 15/9/12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharaNextMode : NSObject
@property(nonatomic,strong)NSString *addtime;
@property(nonatomic,strong)NSString *pathimg;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *comment;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(CharaNextMode *)appWithDic:(NSDictionary *)dic;

@end

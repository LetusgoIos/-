//
//  CharacterMode.h
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterMode : NSObject
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *pathimg;
@property(nonatomic,copy)NSString *nopraise;
@property(nonatomic,copy)NSString *Mypraise;
@property(nonatomic,copy)NSString *coll;
@property(nonatomic,copy)NSString *Myforward;
@property(nonatomic,assign)int coms;
@property(nonatomic,copy)NSString *addtime;
//@property(nonatomic,copy)NSString *comall;
@property(nonatomic,copy)NSString *content;


-(instancetype)initWithDic:(NSDictionary *)Dic;
+(CharacterMode *)appCharaWithDic:(NSDictionary *)Dic;
@end

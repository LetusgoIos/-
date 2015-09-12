//
//  PicNextMode.m
//  观天下
//
//  Created by MS on 15/9/12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PicNextMode.h"

@implementation PicNextMode
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(PicNextMode *)appWithDic:(NSDictionary *)dic
{
    PicNextMode *app = [[PicNextMode alloc]initWithDic:dic];
    return app;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForKey:(NSString *)key
{
    return nil;
}

@end

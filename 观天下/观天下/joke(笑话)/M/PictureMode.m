//
//  PictureMode.m
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PictureMode.h"

@implementation PictureMode

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(PictureMode *)appWithDic:(NSDictionary *)dic
{
    PictureMode *app = [[PictureMode alloc]initWithDic:dic];
    return app;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
}
-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end

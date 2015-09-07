//
//  CharacterMode.m
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "CharacterMode.h"

@implementation CharacterMode

-(instancetype)initWithDic:(NSDictionary *)Dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:Dic];
    }
    return self;
    
}
+(CharacterMode *)appCharaWithDic:(NSDictionary *)Dic
{
    CharacterMode *app = [[CharacterMode alloc]initWithDic:Dic];
    return app;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"praise"]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.Mypraise = value;
        }else{
            int a = (int)value;
            NSString *string = [NSString stringWithFormat:@"%d",a];
            self.Mypraise = string;
            
        }
    }
    
    if ([key isEqualToString:@"forward"]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.Myforward = value;
        }else{
            int a = (int)value;
            NSString *string = [NSString stringWithFormat:@"%d",a];
            self.Myforward = string;
            
        }
    }
    
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}


@end

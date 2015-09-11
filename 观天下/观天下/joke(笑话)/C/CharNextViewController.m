//
//  JokeNextViewController.m
//  观天下
//
//  Created by MS on 15/9/11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "CharNextViewController.h"

@interface CharNextViewController ()

@end

@implementation CharNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)downData{
    [DownLoadData getChDetailsPageData:^(id obj, NSError *err) {
        
    } withPage:103681];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

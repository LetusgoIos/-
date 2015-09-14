//
//  QianDaoViewController.m
//  观天下
//
//  Created by MS on 15/9/14.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "QianDaoViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "MainUITabBarController.h"
@interface QianDaoViewController ()

@end

@implementation QianDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
        NSString *path = [[NSBundle mainBundle]pathForResource:@"前导" ofType:@"gif"];

    
        NSData *data = [NSData dataWithContentsOfFile:path];
        FLAnimatedImage * animatedImage2 = [FLAnimatedImage animatedImageWithGIFData:data];
    
        FLAnimatedImageView *iangeView = [[FLAnimatedImageView alloc]init];
    
        iangeView.frame = CGRectMake(0, 0,WScreen, HScreen);
    
        iangeView.animatedImage = animatedImage2;
    
        [self.view addSubview:iangeView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((WScreen-100)/2, HScreen - 100,100, 44);
    [btn addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"进入" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:32];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.alpha = 0.5;
    [self.view addSubview:btn];
}
-(void)insert:(id)btn
{
    MainUITabBarController *main = [[MainUITabBarController alloc]init];
    self.view.window.rootViewController = main;
    
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

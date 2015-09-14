//
//  NextViewController.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "NextViewController.h"
#import "RDVTabBarController.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:web];
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [web loadRequest:request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
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

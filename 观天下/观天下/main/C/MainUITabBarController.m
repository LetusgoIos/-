//
//  MainUITabBarController.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "MainUITabBarController.h"
#import "MainUINavigationController.h"
#import "JokeViewController.h"
#import "NewsViewController.h"
#import "MeViewController.h"
#import "RDVTabBarItem.h"
@interface MainUITabBarController ()

@end

@implementation MainUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    1.新闻
    NewsViewController *new = [[NewsViewController alloc]init];
    MainUINavigationController *newNav = [[MainUINavigationController alloc] initWithRootViewController:new];
    
    //    2.笑话
    JokeViewController *Joke = [[JokeViewController alloc]init];
    MainUINavigationController *JokeNav = [[MainUINavigationController alloc] initWithRootViewController:Joke];
    
    
    //   3.我
    MeViewController *Me = [[MeViewController alloc]init];
    MainUINavigationController *MeNav = [[MainUINavigationController alloc] initWithRootViewController:Me];
    [self setViewControllers:@[newNav,JokeNav,MeNav]];
    
    
    [self customizeTabBarForController:self];

    
    
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"xinwen", @"tugua", @"user"];
    
    NSArray *titles = @[@"新闻",@"笑话",@"我"];
    
    NSInteger index = 0;
    
    NSDictionary *textAttributes_normal = nil;
    NSDictionary *textAttributes_selected = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes_normal = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName: [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0],
                                  };
        textAttributes_selected = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:214.0/255 green:102.0/255 blue:64.0/255 alpha:1.0],
                                    };
    }
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        
        item.unselectedTitleAttributes = textAttributes_normal;
        item.selectedTitleAttributes = textAttributes_selected;
        
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_select",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.title = titles[index];
        
        index++;
        
        
        
    }
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

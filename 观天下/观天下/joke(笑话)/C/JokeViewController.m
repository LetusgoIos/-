//
//  JokeViewController.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "JokeViewController.h"
#import "SwitchView.h"
#import "CharacterViewController.h"
#import "PictureViewController.h"
@interface JokeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *scrollView;
    int currentIndex;
    CharacterViewController *tableView1;
    PictureViewController *tableView2;

    float titleHeight;
    float bgViewHeight;
    SwitchView *switchView;
    
}


@end

@implementation JokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initTitle];
    
    
    titleHeight=35;
    bgViewHeight=HScreen-64-titleHeight;
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    
    switchView=[[SwitchView alloc] initWithFrame:CGRectMake(0, 0, WScreen, titleHeight)];
    [self.view addSubview:switchView];
    
    [self initScroll];
    [self initTable];

}
-(void)initTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor colorWithRed:214.0/255 green:102.0/255 blue:64.0/255 alpha:1.0];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.text = @"笑话";
    self.navigationItem.titleView = titleLabel;
}
-(void)initScroll{

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, WScreen, bgViewHeight)];
    scrollView.alwaysBounceHorizontal=YES;
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    [scrollView setContentSize:CGSizeMake(WScreen * (2), bgViewHeight)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(0,0,WScreen,bgViewHeight) animated:NO];
    
}

-(void)initTable{
    
    
    tableView1=[[CharacterViewController alloc]init];
    tableView1.view.frame = CGRectMake(0, 0-64, WScreen, HScreen -64-44);
    [scrollView addSubview:tableView1.view];

    
    tableView1.view.tag=11;
    
    
    switchView.ButtonActionBlock=^(int buttonTag){
        
        currentIndex=buttonTag-100;
        [scrollView scrollRectToVisible:CGRectMake(WScreen * (currentIndex-1),0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(WScreen* (currentIndex-1),0)];
        
        if (currentIndex==1) {
            
            NSLog(@"currentIndex==1");
        }else if (currentIndex==2){
            if (tableView2==nil) {
          
                tableView2=[[PictureViewController alloc]init];
                tableView2.view.frame = CGRectMake(WScreen, 0-64, WScreen, HScreen -64-44);
                [scrollView addSubview:tableView2.view];

            }
            
        }
    };
    currentIndex=1;
    
    
}


#pragma mark scrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (2)) / pagewidth) + 1;
    
    if (currentPage==0)
    {
        
        [scrollView scrollRectToVisible:CGRectMake(0,0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(0,0)];
    }
    else if (currentPage==(1))
    {
        
        [scrollView scrollRectToVisible:CGRectMake(WScreen ,0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(WScreen,0)];
    }
    
    currentIndex=currentPage+1;
    
    [switchView swipeAction:(100+currentPage+1)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

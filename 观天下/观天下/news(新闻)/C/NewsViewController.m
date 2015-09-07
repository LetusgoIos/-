//
//  NewsViewController.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "NewsViewController.h"
#import "TitleTableViewCell.h"
#import "NewsTableViewCell.h"
#import "NextViewController.h"
#import "NewsMode.h"
#import "TitileMode.h"

static int n = 0;
@interface NewsViewController ()
{
    NSMutableArray *imageArr;
    MBProgressHUD * HUD;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"军事";
    [self downData];
    
    
   HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    [self.view addSubview:HUD];
    
    [HUD show:YES];
   
    
    //    =========下拉刷新==========
    __weak typeof(self) weakSelf = self;
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableAll addLegendFooterWithRefreshingBlock:^{
        [weakSelf downData];
    }];

 }
#pragma mark -- 下载数据
-(void)downData
{
    
#pragma mark -- 新闻数据
    [DownLoadData getNewsPageData:^(id obj, NSError *err) {
        
        if (obj) {
            [HUD hide:YES];
            n ++;
            [self.tableAll.footer endRefreshing];
            [self.dataSouce addObjectsFromArray:obj];
    
            
            [self.tableAll reloadData];
            //            NSLog(@"%@",self.dataSouce);
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            alert = nil;
        }
    } withPage:n];
    
#pragma mair --    标题图片
    [DownLoadData getTitlePageData:^(id obj, NSError *err) {
        
        if (obj) {
            
            imageArr = obj;
            [self.tableAll reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            alert = nil;
        }
    } withPage:0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *ID2 = @"CELLID2";
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (cell == nil) {
            cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];

        }
    if (self.dataSouce.count >0) {
        NewsMode *newsMode = self.dataSouce[indexPath.row];
        [cell updateCellWithActApp:newsMode anIndexPath:indexPath];
    }

        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NextViewController *next = [[NextViewController alloc]init];
        NewsMode *newsMode = self.dataSouce[indexPath.row];
        next.urlString = newsMode.newsUrl;
    
    next.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:next animated:YES];
     
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    TitleTableViewCell *cell = [[TitleTableViewCell alloc]init];
    cell.frame = CGRectMake(0, 0,self.view.frame.size.width, 150);
    [cell setBlock:^(NSInteger index) {
        TitileMode *titileMode = imageArr[index -1];
        NextViewController *next = [[NextViewController alloc]init];
        next.urlString = titileMode.newsUrl;
        [self.navigationController pushViewController:next animated:YES];
    }];
    [cell updataSouce:imageArr];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 250; //section的高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

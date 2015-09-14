//
//  PictureViewController.m
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureViewCell.h"
#import "PictureMode.h"
#import "PicharNextViewController.h"
//页码
static int n = 1;
@interface PictureViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    
    
    [self downData];
}


-(void)downData
{
    [DownLoadData getPicPageData:^(id obj, NSError *err) {
        

    if (obj) {
            n ++;
        [HUD hide:YES];
            [self.dataSouce addObjectsFromArray:obj];
        [self.tableAll reloadData];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } withPage:n];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"ID";
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PictureViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.dataSouce.count > 0) {
        PictureMode *PictureMode = self.dataSouce[indexPath.row];
        
        [cell updateCellWithApp:PictureMode anIndexPath:indexPath];
        [cell setBlock:^(NSIndexPath *index) {
                 [self.tableAll reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.dataSouce.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PicharNextViewController *charNext = [[PicharNextViewController alloc]init];
    PictureMode *mode = self.dataSouce[indexPath.row];
    charNext.picharNextMode = mode;
    [self presentViewController:charNext animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

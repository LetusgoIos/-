//
//  CharacterViewController.m
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "CharacterViewController.h"
#import "CharacterViewCell.h"

static int n = 1;
@interface CharacterViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation CharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downData];
    self.navigationItem.title = @"笑话";
    
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


#pragma mark -- 数据下载
-(void)downData
{
    [DownLoadData getCharacterPageData:^(id obj, NSError *err) {
        
        
        if (obj) {
            n ++;
            [HUD hide:YES];
//            self.dataSouce = obj;
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
    static NSString *ID = @"string";
    CharacterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CharacterViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellStyleDefault];
    }
    if (self.dataSouce.count > 0) {
        CharacterMode *character = self.dataSouce[indexPath.row];
        
        [cell updateCellWithActApp:character anIndexPath:indexPath];
    }

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CharacterViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count ;
}

@end

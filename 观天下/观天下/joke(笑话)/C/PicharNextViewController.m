//
//  PicharNextViewController.m
//  观天下
//
//  Created by MS on 15/9/11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PicharNextViewController.h"
#import "PictureMode.h"
#import "PictureViewCell.h"
#import "PharAndCharTableViewCell.h"

@interface PicharNextViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;
    UIView *logView;
    NSMutableArray *dataSouce;
}

@end

@implementation PicharNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    logView = [[UIView alloc]init];
    logView.backgroundColor = [UIColor lightGrayColor];
    logView.frame = CGRectMake(0, 20, WScreen, 64);
    
    self.view.frame = CGRectMake(0, 64, WScreen, HScreen);
    self.view.backgroundColor = [UIColor whiteColor];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WScreen, HScreen) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 16, 44 , 44);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Return:) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:btn];
    
    //    开辟空间
    dataSouce = [[NSMutableArray alloc]init];
    
    
    //    加载数据
    [self downData];
}

//返回
-(void)Return:(id)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return dataSouce.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==  0) {
        static NSString *ID = @"CELLID";
        PictureViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[PictureViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        [cell updateCellWithApp:self.picharNextMode  anIndexPath:indexPath];
        return cell;
    }else{
        NSString *CD2 = @"CD2";
        PharAndCharTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CD2];
        if (cell == nil) {
            cell = [[PharAndCharTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CD2];
        }
        PictureMode *nextMode = dataSouce[indexPath.row];
        [cell updateCellWithApp2:nextMode anIndexPath:indexPath];
        return cell;
    }
    
    
}
#pragma mark -- 下载数据
-(void)downData{
    
    [DownLoadData getPicNextPageData:^(id obj, NSError *err) {
        
        if (obj) {
            dataSouce = obj;
            [table reloadData];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } withPage:[_picharNextMode.myId intValue]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 64;
    }else{
        return 44;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return logView;
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor lightGrayColor];
    label.alpha = 0.5;
    
    label.text = @"  所有评论";
    return label;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 350;
    }
    return 150;
    
}

@end

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
@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self downData];
}


-(void)downData
{
    [DownLoadData getPicPageData:^(id obj, NSError *err) {
        

    if (obj) {
            self.dataSouce = obj;
        [self.tableAll reloadData];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } withPage:1];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

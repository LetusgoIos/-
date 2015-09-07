//
//  CharacterViewController.m
//  观天下
//
//  Created by MS on 15/9/6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "CharacterViewController.h"
#import "CharacterViewCell.h"

@interface CharacterViewController ()

@end

@implementation CharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downData];
    
}
#pragma mark -- 数据下载
-(void)downData
{
    [DownLoadData getCharacterPageData:^(id obj, NSError *err) {
        
        
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

//
//  MeViewController.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()


@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else{
        return 44;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        UILabel *txtLab = [[UILabel alloc] init];
        txtLab.frame = CGRectMake(0, 80, 200, 60);
        txtLab.center = CGPointMake(WScreen / 2.0f, 60);
        txtLab.numberOfLines = 0;
        txtLab.font = [UIFont systemFontOfSize:12];
        [txtLab setTextAlignment:NSTextAlignmentCenter];
          txtLab.text = @"登录后，你可以：\n签到领逗比,点赞；\n 评论 \n 收藏好的新闻和搞笑图文。";
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(0, 100, 200, 30);
         loginBtn.center = CGPointMake(WScreen / 2.0f, 120);
        [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor colorWithRed:214.0/255 green:102.0/255 blue:64.0/255 alpha:1.0] forState:UIControlStateNormal];
        [loginBtn.layer setCornerRadius:5];
        

        [loginBtn.layer setBorderWidth:1.0f];
        [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:txtLab];
        [cell addSubview:loginBtn];
       

    }
    
    if (indexPath.section == 1) {
        
        NSArray *array = @[@{@"img":@"ico_cnleft_download.png",@"title":@"本地下载"},@{@"img":@"ico_cnleft_list.png",@"title":@"购买清单"}];
        NSDictionary *dict = array[indexPath.row];
        [cell.imageView setImage:[UIImage imageNamed:[dict objectForKey:@"img"]]];
        [cell.textLabel setText:[dict objectForKey:@"title"]];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.section == 2){
        [cell.imageView setImage:[UIImage imageNamed:@"ico_cnleft_setting.png"]];
        [cell.textLabel setText:@"设置"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
}
-(void)loginBtnClick:(id)btn
{
   
    
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

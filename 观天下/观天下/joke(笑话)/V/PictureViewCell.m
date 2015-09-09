//
//  PictureViewCell.m
//  观天下
//
//  Created by MS on 15/9/7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PictureViewCell.h"
#import "PictureMode.h"
@implementation PictureViewCell
{
    UIView *view;
}

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *superView = self.contentView;
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
        
#pragma mark -- 头像
        _pathimg = [[UIImageView alloc]init];
        [superView addSubview:_pathimg];
        
        [_pathimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(15);
            make.top.equalTo(superView.top).offset(10);
            make.height.equalTo(superView.width).multipliedBy(1/6.0);
            make.width.equalTo(_pathimg.height);
    }];
        
#pragma mark --用户名
        
        _nickname =[[UILabel alloc]init];
        [superView addSubview:_nickname];
        [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pathimg.right).offset(10);
            make.centerY.equalTo(_pathimg.centerY);
            make.width.equalTo(200);
            make.height.equalTo(40);
            
        }];
        
#pragma mark -- 描述
        
        _content = [[UILabel alloc]init];

        [superView addSubview:_content];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pathimg.left);
            make.top.equalTo(_nickname.bottom).offset(5);
            make.right.equalTo(superView.right).offset(-15);
            make.height.equalTo(40);
        
        }];
        
#pragma mark -- 内容图片
        _img = [[FLAnimatedImageView alloc]init];
        [superView addSubview:_img];
        [_img makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_content.left);
            make.top.equalTo(_content.bottom).offset(5);
            make.right.equalTo(superView.right).offset(-15);
            make.bottom.equalTo(superView.bottom).offset(-40);
        }];
        
        
        
        
#pragma mark - 下方
        
        view = [[UIView alloc]init];
        [superView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_img.left);
            make.top.equalTo(_img.bottom);
            make.right.equalTo(_img.right);
            make.bottom.equalTo(superView.bottom);
        }];
     }
  
    //        屏幕宽
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //        分界线的间距
    int line = (width-6)/4;
    for (int i = 0; i < 3; i ++) {
        UIView *viewline = [[UIView alloc]init];
        viewline.alpha = 0.5;
        viewline.backgroundColor = [UIColor grayColor];
         [view addSubview:viewline];
        [viewline makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(line + i *line);
            make.centerY.equalTo(view.centerY);
            make.width.equalTo(2);
            make.height.equalTo(20);
        }];
}
#pragma mark -- 按钮的创建
    NSArray *image = @[@"dianzan01@2x.png",@"zhuanfa01@2x.png",@"pinglun01@2x.png",@"shoucang01@2x.png"];
    NSArray *imageSelected = @[@"dianzan02@2x.png",@"zhuanfa02@2x.png",@"pinglun02@2x.png",@"shoucang02@2x.png"];
    
    for (int i = 0 ; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageSelected[i]] forState:UIControlStateSelected];
        btn.tag = i+1;
         btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [view addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(line*i+8);
            make.width.equalTo(80);
            make.height.equalTo(20);
            make.centerY.equalTo(view.centerY);
        }];
    }
    
    return self;
}

-(void)updateCellWithApp:(PictureMode *)app anIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = app.pathimg;
    NSURL *url = [NSURL URLWithString:path];
    [self.pathimg setImageWithURL:url];
    
    self.nickname.text = app.nickname;
    self.content.text = app.content;
    
    
    NSString *path1 = app.img[0];
    NSURL *url1 = [NSURL URLWithString:path1];
//    [self.img setImageWithURL:url1];
    
    
    
    FLAnimatedImage * __block animatedImage2 = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *url2 = [NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"];
        NSData *data2 = [NSData dataWithContentsOfURL:url1];
        animatedImage2 = [FLAnimatedImage animatedImageWithGIFData:data2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.img.animatedImage = animatedImage2;
    
        });
    });

    
    
    
    
    
    
    
    UIButton *praise = (UIButton *)[view viewWithTag:1];
    [praise setTitle:app.praise forState:UIControlStateNormal];
    
    UIButton *forward = (UIButton*)[view viewWithTag:2];
    [forward setTitle:app.forward forState:UIControlStateNormal];
    

    NSString *coms1 = [NSString stringWithFormat:@"%d",(int)app.coms];
    UIButton *coms = (UIButton*)[view viewWithTag:3];
    [coms setTitle:coms1 forState:UIControlStateNormal];

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

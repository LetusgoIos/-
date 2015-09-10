//
//  PictureViewCell.m
//  观天下
//
//  Created by MS on 15/9/7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PictureViewCell.h"
#import "PictureMode.h"
static NSMutableDictionary *operrations;
static NSMutableDictionary *images;
static NSOperationQueue *queue;
@interface PictureViewCell ()
//存放所有下载操作的队列
@property(nonatomic,strong)NSOperationQueue *queue;
//存放所有下载操作
//@property(nonatomic,strong)NSMutableDictionary *operrations;
//存放所有下载完的图片
//@property(nonatomic,strong)NSMutableDictionary *images;
@end

@implementation PictureViewCell
{
    UIView *view;
    
}

#pragma mark -- 懒加载
-(NSOperationQueue *)queue
{
    if (queue == nil) {
        queue = [[NSOperationQueue alloc]init];
    }
    return queue;
}

-(NSMutableDictionary *)operrations
{
    if (operrations == nil) {
        operrations = [[NSMutableDictionary alloc]init];
    }
    return operrations;
}
-(NSMutableDictionary *)images
{
    if (images == nil) {
        images = [[NSMutableDictionary alloc]init];
    }
    return images;
}

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *superView = self.contentView;
        [self queue];
        [self images];
        [self operrations];
        
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
    [self.pathimg sd_setImageWithURL:url];
    
    self.nickname.text = app.nickname;
    self.content.text = app.content;

#pragma mark -- 加载gif 图片
    
    NSString *path1 = app.img[0];
    NSURL *url1 = [NSURL URLWithString:path1];
    
    
    FLAnimatedImage *image = self.images[path1];
    
    if (image) {
        NSLog(@"从缓存种取图片");
         self.img.animatedImage = image;
    }else{
        
//        天占位图片
        self.img.image = [UIImage imageNamed:@"bjtp"];
        
        NSBlockOperation *operation1 = self.operrations[path1];
        NSLog(@"%@",operation1);
        if (operation1 == nil) {
            NSLog(@"下载图片");
            FLAnimatedImage * __block animatedImage2 = nil;
            
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                NSData *data2 = [NSData dataWithContentsOfURL:url1];
                animatedImage2 = [FLAnimatedImage animatedImageWithGIFData:data2];
    
                
                //        回到主线程
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    self.img.animatedImage = animatedImage2;
                    
                    //                存放图片倒字典
                    if (animatedImage2) {
                        self.images[path1] = animatedImage2;
                    }
                    
                    //                从字典种删除下载操作
                    [self.operrations removeObjectForKey:path1];
//                    self.block(indexPath);
                }];
            }];
            
            
            //    添加操作倒队列
            [self.queue addOperation:operation];
            
            //        添加倒字典
            if (operation) {
                
//                [self.operrations setObject:operation forKey:path1];
                NSLog(@"====%@",self.operrations);
            self.operrations[path1] = operation;
            }
      
        }

    }
    
   


    
    
    
    
    
    
    
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

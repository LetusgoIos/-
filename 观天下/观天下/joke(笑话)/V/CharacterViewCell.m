//
//  CharacterViewCell.m
//  笑文
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "CharacterViewCell.h"
#import "CharacterMode.h"

@implementation CharacterViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * superView = self.contentView;
        
#pragma mark -- 头像
        UIImageView * iconImageView = [[UIImageView alloc] init];
        self.pathimg = iconImageView;
        [self.contentView addSubview:iconImageView];
        
#pragma mark -- 名字
        UILabel * imageLabel = [[UILabel alloc] init];
        self.nickname = imageLabel;
        [self.contentView addSubview:imageLabel];
  
#pragma mark -- 内容
        UILabel * contentLabel = [[UILabel alloc] init];
        self.content = contentLabel;
        [self.contentView addSubview:contentLabel];
   
        
        UIView * bottomView = [[UIView alloc] init];
        [self.contentView addSubview:bottomView];
        
        [bottomView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(15);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.bottom.equalTo(superView.mas_bottom).offset(-15);
            make.height.equalTo(superView).multipliedBy(1.0/8.0);
        }];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(15);
            make.top.equalTo(superView.mas_top).offset(15);
//            make.bottom.equalTo(contentLabel.mas_top).offset(-5);
           // make.height.equalTo(superView).multipliedBy(1.0/6.0);
//            make.width.equalTo(iconImageView.mas_height);
            
            make.width.equalTo(superView.width).multipliedBy(1/6.0);
            make.height.equalTo(iconImageView.width);
            
        }];
        
        
#pragma mark -- 分界线
        //        屏幕宽
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        //        分界线的间距
        int line = (width-6)/4;
        for (int i = 0; i < 3; i ++) {
            UIView *viewline = [[UIView alloc]init];
            viewline.backgroundColor = [UIColor grayColor];
            viewline.alpha = 0.5;
            [bottomView addSubview:viewline];
            [viewline makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.left).offset(line + i *line + 15);
                make.centerY.equalTo(bottomView.centerY);
                make.width.equalTo(2);
                make.height.equalTo(20);
            }];
        }
        
        
        
        
        [imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset(5);
            make.top.equalTo(superView.mas_top).offset(20);
            make.right.equalTo(superView.mas_right).offset(-15);
            make.bottom.equalTo(contentLabel.mas_top).offset(-10);
           // make.height.equalTo(@[iconImageView]);
        }];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(15);
            make.top.equalTo(iconImageView.mas_bottom).offset(5);
            make.right.equalTo(superView.mas_right).offset(-5);
            make.bottom.equalTo(bottomView.mas_top).offset(-5);
//            make.height.equalTo(superView).multipliedBy(55.0/120.0);
        }];
        
        UIButton * goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //goodButton.backgroundColor = [UIColor orangeColor];
        [goodButton setImage:[UIImage imageNamed:@"dianzan01@2x.png"] forState:UIControlStateNormal];
        [goodButton setImage:[UIImage imageNamed:@"dianzan02@2x.png"] forState:UIControlStateHighlighted];
        //[goodButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchDown];
        [bottomView addSubview:goodButton];
        
#pragma mark -- 赞
        UILabel * goodNumLabel = [[UILabel alloc]init];
        self.praise = goodNumLabel;
        goodNumLabel.textColor = [UIColor grayColor];
        goodNumLabel.font = [UIFont systemFontOfSize:14];
        [bottomView addSubview:goodNumLabel];
        
        UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //shareButton.backgroundColor = [UIColor cyanColor];
        [shareButton addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        
        [shareButton setImage:[UIImage imageNamed:@"zhuanfa01@2x.png"] forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageNamed:@"zhuanfa02@2x.png"] forState:UIControlStateHighlighted];
        [bottomView addSubview:shareButton];
        
        
#pragma mark -- 分享
        UILabel * shareNumLabel = [[UILabel alloc]init];
        self.forward = shareNumLabel;
        shareNumLabel.textColor = [UIColor grayColor];
        shareNumLabel.font = [UIFont systemFontOfSize:14];
        [bottomView addSubview:shareNumLabel];
        
        UIButton * messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [messageButton setImage:[UIImage imageNamed:@"pinglun01@2x.png"] forState:UIControlStateNormal];
        [messageButton setImage:[UIImage imageNamed:@"pinglun02@2x.png"] forState:UIControlStateHighlighted];
        [bottomView addSubview:messageButton];
       
#pragma mark -- 评论
        UILabel * messageNumLabel = [[UILabel alloc]init];
        self.coms = messageNumLabel;
        messageNumLabel.textColor = [UIColor grayColor];
        messageNumLabel.font = [UIFont systemFontOfSize:14];
          [bottomView addSubview:messageNumLabel];
        
        UIButton * loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //loveButton.backgroundColor = [UIColor blueColor];
        [loveButton setImage:[UIImage imageNamed:@"shoucang01@2x.png"] forState:UIControlStateNormal];
        [loveButton setImage:[UIImage imageNamed:@"shoucang@2x.png"] forState:UIControlStateHighlighted];
        [bottomView addSubview:loveButton];
        
        [goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
           make.width.equalTo(@[goodNumLabel,shareButton,shareNumLabel,messageButton,messageNumLabel,loveButton]);
        }];

        [goodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodButton.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        }];

        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodNumLabel.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        }];

        [shareNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shareButton.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        }];

        [messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shareNumLabel.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        }];

        [messageNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(messageButton.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        }];
        [loveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(messageNumLabel.mas_right).offset(0);
            make.top.equalTo(bottomView.mas_top).offset(0);
            make.bottom.equalTo(bottomView.mas_bottom).offset(0);
            make.right.equalTo(bottomView.mas_right).offset(0);
        }];
        

        
        
        
    }
    return self;
}


-(void)updateCellWithActApp:(CharacterMode *)app anIndexPath:(NSIndexPath *)indexPath
{
      NSString *path = app.pathimg;
    NSURL *url = [NSURL URLWithString:path];
    [self.pathimg setImageWithURL:url];
    self.nickname.text = app.nickname;
    NSString *string = [NSString stringWithFormat:@"     %@",app.content];
    self.content.text = string;
    
    
    
    self.praise.text = app.Mypraise;
    self.forward.text = app.Myforward;
    NSString *tag = [NSString stringWithFormat:@"%d",app.coms];
    self.coms.text = tag;

    
//    ========自动调整表格高度=========
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
//    self.content.text = app.content;
    //设置label的最大行数
    self.content.numberOfLines = 10;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.content.text sizeWithFont:self.content.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    self.content.frame = CGRectMake(self.content.frame.origin.x, self.content.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+100;
    self.frame = frame;
    
    
    
    
    
    
     
}

-(void)change:(UIButton *)btn
{
    NSLog(@"点击");
}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

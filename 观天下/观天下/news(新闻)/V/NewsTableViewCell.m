//
//  NewsTableViewCell.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsMode.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.selectionStyle = UITableViewCellAccessoryNone;
        
       UIView *superView = self.contentView;
#pragma mark -- 标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];

        
#pragma mark -- 图片
        self.ImageView = [[UIImageView alloc]init];
        self.ImageView.backgroundColor = [UIColor grayColor];
        [superView addSubview:self.ImageView];
        
        
        [self.ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView).offset(8);
            make.right.equalTo(superView.right).offset(-20);
            make.width.equalTo(70);
            make.height.equalTo(60);
            
           
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(20);
            make.top.equalTo(superView.mas_top).offset(8);
            make.right.equalTo(self.ImageView.left).offset(-8);
            make.height.equalTo(50);
          }];
        
#pragma mark -- 评论
        
        self.commentLabel = [[UILabel alloc]init];
        self.commentLabel.textColor = [UIColor grayColor];
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        [superView addSubview:self.commentLabel];
        
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.left).offset(0);
            make.bottom.equalTo(superView.bottom).offset(0);
            make.height.equalTo(20);
            make.width.equalTo(70);
        }];
        
        
#pragma mark -- 时间
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        [superView addSubview:self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(0);
            make.right.equalTo(superView.right).offset(-5);
            make.height.equalTo(20);
            make.width.equalTo(70);
        }];
     }
     return self;
}
-(void)updateCellWithActApp:(NewsMode *)app anIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = app.newsTitle;
    self.commentLabel.text = [NSString stringWithFormat:@"评论 %@",app.newsComments];
    self.timeLabel.text = app.time;
    NSURL *url = [NSURL URLWithString:app.imgUrl];
    [self.ImageView setImageWithURL:url];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end

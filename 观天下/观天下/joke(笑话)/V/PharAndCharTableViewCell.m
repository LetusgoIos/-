//
//  PharAndCharTableViewCell.m
//  观天下
//
//  Created by MS on 15/9/12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "PharAndCharTableViewCell.h"
#import "CharaNextMode.h"
#import "PicNextMode.h"
@implementation PharAndCharTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *superView = self.contentView;
#pragma mark -- 头像
        self.pathimg = [[UIImageView alloc]init];
        _pathimg.backgroundColor = [UIColor orangeColor];
        [superView addSubview:_pathimg];
        
        [_pathimg makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(5);
            make.top.equalTo(superView.top).offset(5);
            make.height.equalTo(50);
            make.width.equalTo(50);
        }];
#pragma mark -- 名字
        _nickname = [[UILabel alloc]init];
        [superView addSubview:_nickname];
        [_nickname  makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pathimg.right).offset(5);
            make.centerY.equalTo(_pathimg.centerY).offset(0);
            make.height.equalTo(40);
            make.width.equalTo(100);
        }];
        
#pragma mark -- 时间
        _addtime = [[UILabel alloc]init];
        _addtime.font = [UIFont systemFontOfSize:12];
        _addtime.textColor = [UIColor grayColor];
        _addtime.alpha = 0.7;
        _addtime.textAlignment = NSTextAlignmentRight;
        [superView addSubview:_addtime];
        [_addtime makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-5);
            make.centerY.equalTo(_pathimg.centerY).offset(0);
            make.width.equalTo(150);
            make.height.equalTo(25);
            
        }];
        
#pragma mark -- 内容
        _comment = [[UILabel alloc]init];
        _comment.numberOfLines = 10;
        [superView addSubview:_comment];
        [_comment makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pathimg.left);
            make.top.equalTo(_pathimg.bottom).offset(5);
            make.right.equalTo(superView.right).offset(-5);
            make.height.equalTo(50);
        }];
        
#pragma mark - 自动调整cell大小
        
        //    ========自动调整表格高度=========
        //获得当前cell高度
        CGRect frame = [self frame];
        //文本赋值
        //    self.content.text = app.content;
        //设置label的最大行数
        _comment.numberOfLines = 20;
        CGSize size = CGSizeMake(WScreen, 1000);
        CGSize labelSize = [_comment.text sizeWithFont:_comment.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
        
        _comment.frame = CGRectMake(_comment.frame.origin.x, _comment.frame.origin.y, labelSize.width, labelSize.height);
        
        //计算出自适应的高度
        frame.size.height = labelSize.height+100;
        self.frame = frame;
        
        
        
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)updateCellWithApp:(CharaNextMode *)app anIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = app.pathimg;
    NSURL *url = [NSURL URLWithString:path];
    [self.pathimg sd_setImageWithURL:url];
    self.nickname.text = app.nickname;
    _addtime.text = app.addtime;
    _comment.text = app.comment;
 
    
    
    
}
-(void)updateCellWithApp2:(PicNextMode *)app anIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = app.pathimg;
    NSURL *url = [NSURL URLWithString:path];
    [self.pathimg sd_setImageWithURL:url];
    self.nickname.text = app.nickname;
    _addtime.text = app.addtime;
    _comment.text = app.comment;
}

@end

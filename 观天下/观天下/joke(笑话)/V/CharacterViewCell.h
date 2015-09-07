//
//  CharacterViewCell.h
//  笑文
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharacterMode;

@interface CharacterViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *pathimg;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *content;
//赞扬
@property(nonatomic,strong)UILabel *praise;
//转发
@property(nonatomic,strong)UILabel *forward;
//评论
@property(nonatomic,strong)UILabel *coms;


-(void)updateCellWithActApp:(CharacterMode *)app anIndexPath:(NSIndexPath *)indexPath;
@end

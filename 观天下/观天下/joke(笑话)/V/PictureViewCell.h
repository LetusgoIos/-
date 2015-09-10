//
//  PictureViewCell.h
//  观天下
//
//  Created by MS on 15/9/7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
@class PictureMode;
@interface PictureViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *pathimg;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,copy)UILabel *content;
@property(nonatomic,strong)FLAnimatedImageView *img;
@property(nonatomic,copy)void(^block)(NSIndexPath * indexPath);

//赞
//@property(nonatomic,copy)NSString *praise;
//转发
//@property(nonatomic,copy)NSString *forward;
//评论
//@property(nonatomic,copy)NSString *coms;

-(void)updateCellWithApp:(PictureMode *)app anIndexPath:(NSIndexPath *)indexPath;

@end

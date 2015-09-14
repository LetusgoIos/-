//
//  NewsTableViewCell.h
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsMode;

@interface NewsTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *ImageView;
-(void)updateCellWithActApp:(NewsMode *)app anIndexPath:(NSIndexPath *)indexPath;
@end

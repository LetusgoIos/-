//
//  PharAndCharTableViewCell.h
//  观天下
//
//  Created by MS on 15/9/12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharaNextMode;
@class PicNextMode;
@interface PharAndCharTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *pathimg;
@property (strong, nonatomic)  UILabel *nickname;
@property (strong, nonatomic)  UILabel *addtime;
@property (strong, nonatomic)  UILabel *comment;
-(void)updateCellWithApp:(CharaNextMode *)app anIndexPath:(NSIndexPath *)indexPath;
-(void)updateCellWithApp2:(PicNextMode *)app anIndexPath:(NSIndexPath *)indexPath;
@end

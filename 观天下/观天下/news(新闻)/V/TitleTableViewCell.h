//
//  TitleTableViewCell.h
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"

@interface TitleTableViewCell : UITableViewCell<EScrollerViewDelegate>

@property(nonatomic,copy)void(^block)(NSInteger indext);
-(void)updataSouce:(NSMutableArray *)imageArr;
@end

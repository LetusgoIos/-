//
//  TitleTableViewCell.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "TitleTableViewCell.h"
#import "TitileMode.h"


@implementation TitleTableViewCell


- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        
    }
    return self;
}
-(void)updataSouce:(NSMutableArray *)imageArr
{
    NSMutableArray *imageS = [[NSMutableArray alloc]init];
    NSMutableArray *titleS = [[NSMutableArray alloc]init];
    for (TitileMode *object in imageArr) {
        NSString *image = object.imgUrl;
        [imageS addObject:image];

        NSString *title = object.newsTitle;
        [titleS addObject:title];

    }

    if (imageS.count != 0 && titleS.count != 0) {
        EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, 150)
                                                              ImageArray:imageS
                                                              TitleArray:titleS];
        scroller.delegate=self;
        [self.contentView addSubview:scroller];
        
    }
 
}
-(void)EScrollerViewDidClicked:(NSUInteger)index
{

    self.block(index);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

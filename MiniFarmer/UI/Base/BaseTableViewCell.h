//
//  BaseTableViewCell.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *line;


- (void)setHiddenLine:(BOOL)hidden;

- (void)refreshDataWithModel:(id)model;
+ (CGFloat)cellHeightWihtModel:(id)model;

@end

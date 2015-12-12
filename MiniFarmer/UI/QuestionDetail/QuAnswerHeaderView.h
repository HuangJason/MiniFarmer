//
//  QuAnswerHeaderView.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionAnsModel.h"

@interface QuAnswerHeaderView : UITableViewHeaderFooterView<UIAlertViewDelegate>

- (void)refreshWithAnsModel:(QuestionAnsModel *)ansModel;
+ (CGFloat)headerHeightWithAnsModel:(QuestionAnsModel *)ansModel;
@property(nonatomic,assign)BOOL isSelf;

@end

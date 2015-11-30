//
//  AskSpecialistView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskSpecialistCellSubview.h"


@interface AskSpecialistCellSubview ()
@property (weak, nonatomic) IBOutlet UIButton *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *askBT;

@end

@implementation AskSpecialistCellSubview
- (IBAction)tapAskBT:(id)sender
{
}

- (void)refreshUIWithModel:(id)model
{
    
}

- (CGFloat)heigthWithModel:(id)model
{
    return 0.0;
}

@end

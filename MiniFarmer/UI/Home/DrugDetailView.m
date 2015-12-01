//
//  DrugDetailView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DrugDetailView.h"

@implementation DrugDetailView
- (void)awakeFromNib{
    _imageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    _recommend.textColor = [UIColor colorWithHexString:@"#333333"];
    _recommend.font = kTextFont16;

}

@end

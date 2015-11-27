//
//  DiseaseView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaseView.h"
#import "UIImageView+WebCache.h"
#import "DiseaDetailViewController.h"
#import "UIView+UIViewController.h"

@implementation DiseaseView
- (void)awakeFromNib{
    
    _name.font = kTextFont14;
    _name.textColor = [UIColor colorWithHexString:@"#666666"];
    
    _count.font = kTextFont(11);
    _count.textColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [_browseV setImage:[UIImage imageNamed:@"home_study_detail_browse"]];
    _imageView.backgroundColor = [UIColor redColor];
    
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _name.text =_dic[@"title"];
    
    NSString *url =_dic[@"lbzp"];

    NSString *str = [kPictureURL stringByAppendingString:url];
    
    NSURL *URL = [NSURL URLWithString:str];
    
    
    [_imageView sd_setImageWithURL:URL placeholderImage:nil];
    
   // [_imageView setImageWithURL:url];
}
- (void)setModel:(TwoclassMode *)model{
    _model = model;
    _name.text = _model.title;
    
    NSString *url =_model.lbzp;
    
    NSString *str = [kPictureURL stringByAppendingString:url];
    
    NSURL *URL = [NSURL URLWithString:str];
    
    
    [_imageView sd_setImageWithURL:URL placeholderImage:nil];
    
}
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    DiseaDetailViewController *detailVC = [[DiseaDetailViewController alloc] init];
    
    [self.ViewController.navigationController pushViewController:detailVC animated:YES];
 
}
 */
@end

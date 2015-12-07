//
//  MineViewController.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    TypeSegment,
    TypeNothing,
    TypeOther
    
} Type;

@interface UserMenuItem : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;
@end

@interface MineViewController : UIViewController

@end

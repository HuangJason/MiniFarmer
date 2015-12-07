//
//  UserMenuItem.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    TypeSegment,
    TypeNothing,
    TypeOther
    
} Type;

@interface UserMenuItem : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, assign)Type type;
@property (nonatomic, strong) NSString *imageString;
@end
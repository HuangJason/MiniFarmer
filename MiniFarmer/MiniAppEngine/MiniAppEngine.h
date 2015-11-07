//
//  MiniAppEngine.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiniAppEngine : NSObject

+ (MiniAppEngine *)shareMiniAppEngine;

//保存密码
- (void)saveUserLoginNumber:(NSString *)number;

- (void)clearUserLoginNumber;

- (NSString *)userLoginNumber;

- (BOOL)isHasSaveUserLoginNumber;
@end

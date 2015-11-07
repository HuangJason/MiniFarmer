//
//  MiniAppEngine.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MiniAppEngine.h"

#define kUserLoginNumber @"userLoginNumber"
#define kIsSaveUserLoginNumber @"isSaveUserLoginNumber"

static MiniAppEngine *miniAppEngine;

@implementation MiniAppEngine

+ (MiniAppEngine *)shareMiniAppEngine
{
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        miniAppEngine = [[MiniAppEngine alloc] init];
    });
    return miniAppEngine;
}

- (void)saveUserLoginNumber:(NSString *)number
{
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:kUserLoginNumber];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSaveUserLoginNumber];
}

- (void)clearUserLoginNumber
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLoginNumber];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsSaveUserLoginNumber];
}

- (NSString *)userLoginNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginNumber];
}

- (BOOL)isHasSaveUserLoginNumber
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsSaveUserLoginNumber];
}

@end

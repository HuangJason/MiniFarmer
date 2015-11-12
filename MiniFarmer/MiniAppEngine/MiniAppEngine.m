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

#define kUserId @"userId"

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

- (void)saveUserId:(NSString *)userId
{
 [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kUserId];

}

- (void)saveUserLoginNumber:(NSString *)number
{
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:kUserLoginNumber];
}

- (void)clearUserNumber
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLoginNumber];
}

- (void)clearUserLoginInfos
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsSaveUserLoginNumber];
}



- (void)setSaveNumber:(BOOL)saveNumber
{
    [[NSUserDefaults standardUserDefaults] setBool:saveNumber forKey:kIsSaveUserLoginNumber];
    if (!saveNumber)
    {
        [self clearUserNumber];
    }
}


- (NSString *)userLoginNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginNumber];
}

- (NSString *)userId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
}

- (BOOL)isHasSaveUserLoginNumber
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsSaveUserLoginNumber];
}

- (BOOL)isLogin
{
    if (![self userId])
    {
        return NO;
    }
    return YES;
}

@end

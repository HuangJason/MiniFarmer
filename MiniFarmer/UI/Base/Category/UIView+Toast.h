//
//  UIView+Toast.h
//  WhatsLive
//
//  Created by 尹新春 on 15/8/14.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView ()

@property (nonatomic, strong) CommonToastView *orderToastView;

@end

@interface UIView (Toast)

- (void)showToastView:(NSInteger)status;

- (void)showOrderResultWithType:(NSInteger)status suceess:(BOOL)suceess;

- (void)showFoucsResultWithType:(NSInteger)status success:(BOOL)success;
//直播的toast
- (void)showLivingToastWithType:(NSInteger)status suceess:(BOOL)suceess;

//手动控制toas 显示 消失
- (void)showToastViewManual:(NSInteger)status;

- (void)dismissOrderResult;

- (void)showAlter;

- (void)showReplayWithSuccess:(BOOL)success;

- (void)showWeakPromptViewWithMessage:(NSString *)message;

- (void)showDeleteLoading;

- (void)dismissDeleteLoading;

- (void)showListLoadFailureToast;


@end

//
//  UIView+Toast.m
//  WhatsLive
//
//  Created by 尹新春 on 15/8/14.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "UIView+Toast.h"
#import <objc/runtime.h>

static const char *kPropertyKeyNoResult = "propertyKeyOrderResult";
#define DurTime  2
#define kDeleteLoadingTag 898
@implementation UIView (Toast)

- (void)setOrderToastView:(CommonToastView *)orderToastView
{
    objc_setAssociatedObject(self, kPropertyKeyNoResult, orderToastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CommonToastView *)orderToastView
{
    return objc_getAssociatedObject(self, kPropertyKeyNoResult);

}

- (void)showFoucsResultWithType:(NSInteger)status success:(BOOL)success
{
    if (status && success)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeCancelSuccess];
    }
    else if (status && !success)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeCancelFailed];
    }
    else if (!status && success)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeSuccessFollowed];
    }
    else
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeFailFollowed];
    }
    [self.orderToastView showToastViewToView:self];
    [self.orderToastView dismissToastViewAfterDelay:DurTime];
}

- (void)showOrderResultWithType:(NSInteger)status suceess:(BOOL)suceess
{
    if (status && suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeCancelAppoint];
    }
    else if (status && !suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeFailCancelAppoint];


    }
    else if (!status && suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeSuccessAppoint];
    }
    else
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeFailAppoint];
    }
    [self.orderToastView showToastViewToView:self];
    [self.orderToastView dismissToastViewAfterDelay:DurTime];
}

- (void)showLivingToastWithType:(NSInteger)status suceess:(BOOL)suceess
{
    if (status == ToastTypeSuccessAppoint && suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeSuccessAppoint];
    }
    else if (status == ToastTypeCancelAppoint && !suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeCancelAppoint];
    
    }
    else if (status == ToastTypeLivingFailed && !suceess)
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeLivingFailed];
    }
    
    [self.orderToastView showToastViewToView:self];

    [self.orderToastView dismissToastViewAfterDelay:DurTime];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.orderToastView dismissToastView];
//    });
}


- (void)showReplayWithSuccess:(BOOL)success
{
    if (success) {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeReplayDeleteSuccess];
    }
    else
    {
        self.orderToastView = [CommonToastView viewWithToastType:ToastTypeReplayDeleteFaield];

    }
    [self.orderToastView showToastViewToView:self];
    
    [self.orderToastView dismissToastViewAfterDelay:DurTime];
    
}

- (void)showToastView:(NSInteger)status
{
    self.orderToastView = [CommonToastView viewWithToastType:status];

    [self.orderToastView showToastViewToView:self];
    [self hidenToastView];
}

- (void)hidenToastView
{
    [self.orderToastView dismissToastViewAfterDelay:DurTime];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.orderToastView dismissToastView];
//    });

}

- (void)showToastViewManual:(NSInteger)status
{
    self.orderToastView = [CommonToastView viewWithToastType:status];
    
    [self.orderToastView showToastViewToView:self];
    [self.orderToastView dismissToastViewAfterDelay:DurTime];

}

- (void)showListLoadFailureToast
{
    self.orderToastView = [CommonToastView viewWithToastType:ToastTypeLoadFailed];
    
    [self.orderToastView showToastViewToView:self];
    [self.orderToastView dismissToastViewAfterDelay:DurTime];
}

- (void)dismissOrderResult
{
    [self.orderToastView dismissToastView];
}


- (void)showAlter
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"请求个人信息失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
}


- (void)showWeakPromptViewWithMessage:(NSString *)message
{
    MBProgressHUD *hud;
    hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.labelColor = [UIColor whiteColor];
    hud.margin = 10.0f;
    //hud.opacity = 0.6f;
    hud.color = [UIColor blackColor];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.0f);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

- (void)showDeleteLoading
{
    MBProgressHUD *hud;
    hud = [[MBProgressHUD alloc] initWithView:self];
    hud.color = [UIColor blackColor];
    hud.dimBackground = YES;
    hud.tag = kDeleteLoadingTag;
    [self addSubview:hud];
    [hud show:YES];
}

- (void)dismissDeleteLoading
{
    MBProgressHUD * hub = (MBProgressHUD *)[self viewWithTag:kDeleteLoadingTag];
    if (hub)
    {
        [hub removeFromSuperview];
    }
}

@end

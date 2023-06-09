//
//  UIView+IFHUD.m
//  IFHUD
//
//  Created by MrGLZh on 2022/1/3.
//

#import "UIView+IFHUD.h"
#import "IFHUDMacros.h"

@implementation UIView (IFHUD)

#pragma mark - 提示信息
- (void)if_showTip:(NSString *)message imageName:(NSString *)imageName type:(IFProgressHUDShowTipType)type {
    [self if_hideLoadingView];
    IFProgressHUD * hud = [IFProgressHUD showImageTipText:message
                                                  tipIcon:imageName
                                                     type:type
                                                   toView:self animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.tag = IFProgressHUDTipTag;
    [hud setTextColor:[UIColor whiteColor]];
    [hud setBezelViewBgColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self bringSubviewToFront:hud];
}

- (void)if_showSuccessTip:(NSString *)message {
    if ([self isExistHUDTip]) {
        return;
    }
    [self if_showTip:message imageName:nil type:IFProgressHUDShowTypeSuccess];
}

- (void)if_showErrorTip:(NSString *)message {
    if ([self isExistHUDTip]) {
        return;
    }
    [self if_showTip:message imageName:nil type:IFProgressHUDShowTypeError];
}

- (void)if_showFailTip:(NSString *)message {
    if ([self isExistHUDTip]) {
        return;
    }
    [self if_showTip:message imageName:nil type:IFProgressHUDShowTypeFail];
}

- (void)if_showTextTip:(NSString *)message {
    if ([self isExistHUDTip]) {
        return;
    }
    [self if_showTip:message imageName:nil type:IFProgressHUDShowTypeDefault];
}

- (BOOL)isExistHUDTip {
    IFProgressHUD *tipHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDTipTag];
    if (tipHUD) {
        return YES;
    }
    return NO;
}

#pragma mark show & hide Loadingview

- (void)if_showLoadingView:(NSString *)message {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLoadingText:message ToView:self];
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        [loadingHUD setBezelViewBgColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [loadingHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    }
    loadingHUD.detailsLabel.text = message;
    [self bringSubviewToFront:loadingHUD];
}

- (void)if_showLoadingView:(NSString *)message minDuration:(CGFloat)minDuration {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLoadingText:message ToView:self];
        if (minDuration > 0) {
            loadingHUD.minShowTime = minDuration;
        }
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        [loadingHUD setBezelViewBgColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [loadingHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    }
    loadingHUD.detailsLabel.text = message;
    [self bringSubviewToFront:loadingHUD];
}

- (void)if_hideLoadingView {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (loadingHUD) {
        [loadingHUD hideAnimated:YES];
    }
}

- (void)if_showLottieLoadingView:(NSString *)message {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLottieLoadingText:message toView:self];
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        [loadingHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
    }
    loadingHUD.detailsLabel.text = message;
    [self bringSubviewToFront:loadingHUD];
}

- (void)if_showLottieLoadingView:(NSString *)message graceTime:(CGFloat)graceTime {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLottieLoadingText:message toView:self graceTime:graceTime];
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        [loadingHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
    }
    loadingHUD.detailsLabel.text = message;
    [self bringSubviewToFront:loadingHUD];
}

- (void)if_showLottieLoadingView:(NSString *)message maskColor:(UIColor *)maskColor {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLottieLoadingText:message toView:self];
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        UIColor *tempColor = [UIColor colorWithWhite:0 alpha:0.1];
        if (maskColor) {
            tempColor = maskColor;
        }
        [loadingHUD setBackgroundColor:tempColor];
    }
    loadingHUD.detailsLabel.text = message;
    [self bringSubviewToFront:loadingHUD];
}


@end

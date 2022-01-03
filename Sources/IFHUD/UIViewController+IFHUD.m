//
//  UIViewController+IFHUD.m
//  IFHUD
//
//  Created by MrGLZh on 2022/1/3.
//

#import "UIViewController+IFHUD.h"

@implementation UIViewController (IFHUD)

#pragma mark - 提示信息
- (void)if_showTip:(NSString *)message imageName:(NSString *)imageName type:(IFProgressHUDShowTipType)type {
    [self if_hideLoadingView];
    IFProgressHUD * hud = [IFProgressHUD showImageTipText:message
                                                  tipIcon:imageName
                                                     type:type
                                                   toView:self.navigationController.view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.tag = IFProgressHUDTipTag;
    [hud setTextColor:[UIColor whiteColor]];
    [hud setBezelViewBgColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self.navigationController.view bringSubviewToFront:hud];
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
    IFProgressHUD *tipHUD = (IFProgressHUD *)[self.navigationController.view viewWithTag:IFProgressHUDTipTag];
    if (tipHUD) {
        return YES;
    }
    return NO;
}

#pragma mark show & hide Loadingview

- (void)if_showLoadingView:(NSString *)message {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self.view viewWithTag:IFProgressHUDLoadingTag];
    if (!loadingHUD) {
        loadingHUD = [IFProgressHUD showLoadingText:message ToView:self.view];
        loadingHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadingHUD.tag = IFProgressHUDLoadingTag;
        [loadingHUD setTextColor:[UIColor whiteColor]];
        [loadingHUD setBezelViewBgColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [loadingHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    }
    loadingHUD.detailsLabel.text = message;
    [self.view bringSubviewToFront:loadingHUD];
}

- (void)if_hideLoadingView {
    IFProgressHUD * loadingHUD = (IFProgressHUD *)[self.view viewWithTag:IFProgressHUDLoadingTag];
    if (loadingHUD) {
        [loadingHUD hideAnimated:YES];
    }
}


@end

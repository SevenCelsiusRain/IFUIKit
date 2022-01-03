//
//  UIView+IFHUD.h
//  IFHUD
//
//  Created by MrGLZh on 2022/1/3.
//

#import <UIKit/UIKit.h>
#import "IFProgressHUD.h"

@interface UIView (IFHUD)

/**
 显示提示信息
 */
- (void)if_showSuccessTip:(NSString *)message;

- (void)if_showErrorTip:(NSString *)message;

- (void)if_showFailTip:(NSString *)message;

- (void)if_showTextTip:(NSString *)message;

- (void)if_showTip:(NSString *)message imageName:(NSString *)imageName type:(IFProgressHUDShowTipType)type;

/**
 显示loading (多次调用，后者将覆盖前者，仅保留最后一个)
 */
- (void)if_showLoadingView:(NSString *)message;

/**
 隐藏loading
 */
- (void)if_hideLoadingView;

@end


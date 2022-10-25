//
//  IFProgressHUD.h
//  IFHUD
//
//  Created by MrGLZh on 2022/1/3.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, IFProgressHUDMode) {
    /// UIActivityIndicatorView.
    IFProgressHUDModeIndeterminate,
    /// A round, pie-chart like, progress view.
    IFProgressHUDModeDeterminate,
    /// Horizontal progress bar.
    IFProgressHUDModeDeterminateHorizontalBar,
    /// Ring-shaped progress view.
    IFProgressHUDModeAnnularDeterminate,
    /// Shows a custom view.
    IFProgressHUDModeCustomView,
    /// Shows only labels.
    IFProgressHUDModeText
};

typedef NS_ENUM(NSInteger, IFProgressHUDShowTipType) {
    IFProgressHUDShowTypeDefault,// 默认只有文本信息
    IFProgressHUDShowTypeSuccess,
    IFProgressHUDShowTypeError,
    IFProgressHUDShowTypeFail,
};

@interface IFProgressHUD : MBProgressHUD

/**
 文字颜色
 */
- (void)setTextColor:(UIColor *)color;

/**
 提示框背景色
 */
- (void)setBezelViewBgColor:(UIColor *)color;

/**
 背景蒙层颜色
 */
- (void)setBackgroundColor:(UIColor *)color;

/**
 初始化HUD
 */
- (id)initWithModel:(IFProgressHUDMode)mode Text:(NSString *)text tipIcon:(NSString*)icon frame:(CGRect)frame;

/**
 显示【文本+icon】提示
 @param text 文本内容
 @param icon 文本上方icon
 @param type 提示框类型
 @param view 父视图（值为nil时，默认使用当前window）
 @param animated 是否需要动画效果
 */
+ (IFProgressHUD *)showImageTipText:(NSString *)text
                            tipIcon:(NSString*)icon
                               type:(IFProgressHUDShowTipType)type
                             toView:(UIView*)view animated:(BOOL)animated;
+ (IFProgressHUD *)showTipText:(NSString *)text toView:(UIView*)view;
+ (IFProgressHUD *)showTipText:(NSString *)text;


/**
 Loading提示 加载中...
 */
+ (IFProgressHUD *)showLoadingText:(NSString *)text ToView:(UIView*)view;;
+ (IFProgressHUD *)showLoadingText:(NSString *)text;

/**
 lottie 动画
 */
+ (IFProgressHUD *)showLottieLoadingText:(NSString *)text toView:(UIView *)view;


/**
 Loading提示
 @param text 文本内容
 @param mode 提示框样式
 @param view 父视图
 */
+ (IFProgressHUD *)showProgressLoadingText:(NSString *)text mode:(IFProgressHUDMode)mode ToView:(UIView*)view;

/**
 Loading提示 样式：MAProgressHUDModeIndeterminate
 在当前window上弹出
 */
+ (IFProgressHUD *)showProgressLoadingText:(NSString *)text;

/**
 隐藏view上最顶层的HUD
 @param view 值为nil时，默认使用当前window
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideHUD;

/**
 隐藏view上所有的HUD
 @param view 值为nil时，默认使用当前window
 */
+ (void)hideAllHUDForView:(UIView *)view animated:(BOOL)animated;
+ (void)hideAllHUD;

/**
 显示HUD
 */
- (void)showAnimated:(BOOL)animated;

/**
 隐藏HUD
 */
- (void)hideAnimated:(BOOL)animated;

/**
 延迟隐藏HUD
 */
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end


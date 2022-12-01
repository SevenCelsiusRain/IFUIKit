//
//  IFProgressHUD.m
//  IFHUD
//
//  Created by MrGLZh on 2022/1/3.
//

#import "IFProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "IFCustomHUD.h"

@interface IFProgressHUD ()
@property (nonatomic, strong) IFCustomHUD *customHud;

@end

@implementation IFProgressHUD

- (void)setTextColor:(UIColor *)color {
    self.contentColor = color;
    self.label.textColor = color;
}

- (void)setBezelViewBgColor:(UIColor *)color {
    self.bezelView.color = color;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.backgroundView.color = color;
}

#pragma mark - ShowTip

- (id)initWithModel:(IFProgressHUDMode)mode Text:(NSString *)text tipIcon:(NSString *)icon frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self configHUDContentViews:self TipText:text tipIcon:icon mode:mode];
    return self;
}

+ (IFProgressHUD *)showTipText:(NSString *)text {
    return [self showTipText:text toView:nil];
}

+ (IFProgressHUD *)showTipText:(NSString *)text toView:(UIView *)view {
    return [self showImageTipText:text tipIcon:nil type:IFProgressHUDShowTypeDefault toView:view animated:YES];
}

+ (IFProgressHUD *)showImageTipText:(NSString *)text
                            tipIcon:(NSString *)icon
                               type:(IFProgressHUDShowTipType)type
                             toView:(UIView *)view
                           animated:(BOOL)animated {
    NSString *defaultText;
    NSString *defaultIcon;
    switch (type) {
        case IFProgressHUDShowTypeDefault:
            break;
        case IFProgressHUDShowTypeSuccess:
            defaultText = @"success!";
            defaultIcon = @"IFHUD.bundle/hud_success";
            break;
        case IFProgressHUDShowTypeError:
            defaultText = @"error!";
            defaultIcon = @"IFHUD.bundle/hud_error";
            break;
        case IFProgressHUDShowTypeFail:
            defaultText = @"fail!";
            defaultIcon = @"IFHUD.bundle/hud_warn";
            break;
    }
    
    NSString *displayText = text ? text : defaultText;
    NSString *displayIcon = icon ? icon : defaultIcon;
    
    IFProgressHUDMode mode = IFProgressHUDModeText;
    if (displayIcon) {
        mode = IFProgressHUDModeCustomView;
    }
    
    UIView *supView = view ? view : [self getLastWindow];
    
    IFProgressHUD *hud = [IFProgressHUD showHUDAddedTo:supView animated:animated];
    [hud configHUDContentViews:hud TipText:displayText tipIcon:displayIcon mode:mode];
    //消失后从父视图中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0];
    return hud;
}

- (void)configHUDContentViews:(IFProgressHUD *)hud
                      TipText:(NSString *)text
                      tipIcon:(NSString *)icon
                         mode:(IFProgressHUDMode)mode {
    hud.mode = [hud convertHUDMode:mode];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    if (icon) {
        UIImageView *iconView = [[UIImageView alloc] init];
        if ([icon hasPrefix:@"http://"] || [icon hasPrefix:@"https://"]) {
            [iconView sd_setImageWithURL:[NSURL URLWithString:icon]];
        }else{
            UIImage *image = [UIImage imageNamed:icon];
            [iconView setImage:image];
        }
        hud.customView = iconView;
    }
}

- (UIImage *)getIconImageWithImageName:(NSString *)imgName {
    //1. 获取当前的bundleName
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    //2. 根据图片名称, 在bundle中检索图片路径
    NSString *path = [currentBundle pathForResource:imgName ofType:@"png"];
    //获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

#pragma mark - Show & Hide

+ (BOOL)hideHUD {
    return [super hideHUDForView:[self getLastWindow] animated:YES];
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    return [super hideHUDForView:view animated:animated];
}

+ (void)hideAllHUD {
    [self hideAllHUDForView:nil animated:YES];
}

+ (void)hideAllHUDForView:(UIView *)view animated:(BOOL)animated {
    UIView *parentView = view ? view : [self getLastWindow];
    for (UIView *subview in parentView.subviews) {
        if ([subview isKindOfClass:self]) {
            MBProgressHUD *hud = (MBProgressHUD *)subview;
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:animated];
        }
    }
}

- (void)showAnimated:(BOOL)animated {
    [super showAnimated:animated];
}

- (void)hideAnimated:(BOOL)animated {
    [super hideAnimated:animated];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [super hideAnimated:animated afterDelay:delay];
}

#pragma mark - Loading

+ (IFProgressHUD *)showLoadingText:(NSString *)text {
    return [self showLoadingText:text ToView:nil];
}

+ (IFProgressHUD *)showLoadingText:(NSString *)text ToView:(UIView *)view {
    return [self showProgressLoadingText:text mode:IFProgressHUDModeIndeterminate ToView:view];
}

+ (IFProgressHUD *)showProgressLoadingText:(NSString *)text {
    return [self showProgressLoadingText:text mode:IFProgressHUDModeIndeterminate ToView:nil];
}

+ (IFProgressHUD *)showProgressLoadingText:(NSString *)text mode:(IFProgressHUDMode)mode ToView:(UIView *)view {
    UIView *supView = view ? view : [self getLastWindow];
    IFProgressHUD *hud = [IFProgressHUD showHUDAddedTo:supView animated:YES];
    if (text.length > 0) {
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        hud.detailsLabel.text = text;
    }
    hud.mode = [hud convertHUDMode:mode];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (IFProgressHUD *)showLottieLoadingText:(NSString *)text toView:(UIView *)view; {
    UIView *supView = view ? view : [self getLastWindow];
    IFProgressHUD *hud = [[IFProgressHUD alloc] initWithView:supView];
    hud.removeFromSuperViewOnHide = YES;
    [supView addSubview:hud];
    hud.graceTime = 1.5;
    if (text.length > 0) {
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        hud.detailsLabel.text = text;
    }
    hud.mode = [hud convertHUDMode:IFProgressHUDModeCustomView];
    hud.customView = hud.customHud;
    [hud.customHud play];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    return hud;
}

+ (IFProgressHUD *)showLottieLoadingText:(NSString *)text toView:(UIView *)view graceTime:(CGFloat)graceTime {
    UIView *supView = view ? view : [self getLastWindow];
    IFProgressHUD *hud = [[IFProgressHUD alloc] initWithView:supView];
    hud.removeFromSuperViewOnHide = YES;
    [supView addSubview:hud];
    hud.graceTime = graceTime;
    if (text.length > 0) {
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        hud.detailsLabel.text = text;
    }
    hud.mode = [hud convertHUDMode:IFProgressHUDModeCustomView];
    hud.customView = hud.customHud;
    [hud.customHud play];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    return hud;
}


- (MBProgressHUDMode)convertHUDMode:(IFProgressHUDMode)mode {
    MBProgressHUDMode hudMode = MBProgressHUDModeText;
    switch (mode) {
        case IFProgressHUDModeIndeterminate:
            hudMode = MBProgressHUDModeIndeterminate;
            break;
        case IFProgressHUDModeDeterminate:
            hudMode = MBProgressHUDModeDeterminate;
            break;
        case IFProgressHUDModeDeterminateHorizontalBar:
            hudMode = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        case IFProgressHUDModeAnnularDeterminate:
            hudMode = MBProgressHUDModeAnnularDeterminate;
            break;
        case IFProgressHUDModeCustomView:
            hudMode = MBProgressHUDModeCustomView;
            break;
        case IFProgressHUDModeText:
            hudMode = MBProgressHUDModeText;
            break;
    }
    return hudMode;
}

#pragma mark - Private

//获取最上层的window，排除掉UIRemoteKeyboardWindow
+ (UIWindow *)getLastWindow {
    UIApplication *application = [UIApplication sharedApplication];
    if(application.delegate.window) {
        return application.delegate.window;
    }
    
    BOOL isFind = NO;
    UIWindow *window = nil;
    for (NSInteger i=application.windows.count-1; i>=0; i--) {
        UIWindow *tmpWindow = application.windows[i];
        NSString *windowClass = NSStringFromClass([tmpWindow class]);
        if (!isFind && ![windowClass isEqualToString:@"UIRemoteKeyboardWindow"] &&
            ![windowClass isEqualToString:@"_UIInteractiveHighlightEffectWindow"]) {
            window = tmpWindow;
            isFind = YES;
        }
    }
    return window;
}

- (IFCustomHUD *)customHud {
    if (!_customHud) {
        _customHud = [IFCustomHUD customHud];
    }
    return _customHud;
}


@end

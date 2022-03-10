//
//  IFAlertController.h
//  IFAlert
//
//  Created by MrGLZh on 2021/12/31.
//

#import <UIKit/UIKit.h>

//! -- Version: 0.0.1.2 -- !//

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, IFAlertDirectionType) {
    IFAlertDirectionTypeTop, // 上方
    IFAlertDirectionTypeBottom, // 下方
    IFAlertDirectionTypeCenter, // 中间
    IFAlertDirectionTypeAny // 任意点，需搭配 point 使用
};

@interface IFAlertController : UIViewController
/*!上移偏移量 default：0*/
@property (nonatomic, assign) CGFloat moveUpOffset;
/*!是否需要监听键盘 default：NO*/
@property (nonatomic, assign) BOOL isKeyboardChange;
/*!状态栏显示样式*/
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
/*!显示View 大小*/
@property (nonatomic, assign) CGSize contentViewSize;
/*!是否补全上下部分的显示内容 default：YES*/
@property (nonatomic, assign) BOOL isFixBankSpace;
/*!补全处颜色*/
@property (nonatomic, strong) UIColor *fixBankColor;
/*!遮罩颜色*/
@property (nonatomic, strong) UIColor *blurColor;
/*!动画 default：YES*/
@property (nonatomic, assign) BOOL animated;
/*!点击空白处是否消失 default:YES*/
@property (nonatomic, assign) BOOL tapDismiss;
/*!自动消失时长 0 不自动消失*/
@property (nonatomic, assign) NSTimeInterval autoDismissDuration;
/*!页面消失*/
@property (nonatomic, copy) void(^dismissDone)(void);
/*!任意位置使用*/
@property (nonatomic, assign) CGPoint directionPoint;

- (instancetype)initWithView:(UIView *)contentView radius:(CGFloat)radius direction:(IFAlertDirectionType)direction;

- (instancetype)initWithController:(UIViewController *)controller radius:(CGFloat)radius direction:(IFAlertDirectionType)direction;

- (void)dismiss;

/// SDK 版本
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END

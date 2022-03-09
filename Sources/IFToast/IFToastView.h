//
//  IFToastView.h
//  IFToast
//
//  Created by MrGLZh on 2022/1/3.
//

#import <UIKit/UIKit.h>
#import <YYImage/YYImage.h>

typedef NS_ENUM(NSInteger, IFToastPositionType) {
    IFToastPositionTypeTop,
    IFToastPositionTypeCenter,
    IFToastPositionTypeBottom
};

@interface IFToastView : NSObject
/*!默认 2s*/
@property (nonatomic, assign) CGFloat duration;
/*!默认 NO*/
@property (nonatomic, assign) BOOL userEnable;
/*!默认 black alpha 0.8*/
@property (nonatomic, strong) UIColor *contentColor;
/*!默认 clear*/
@property (nonatomic, strong) UIColor *maskColor;
/*!默认 white*/
@property (nonatomic, strong) UIColor *textColor;

/// 显示toast在中间
/// @param image 图片
/// @param text 文本
+ (void)showWithImage:(UIImage *)image text:(NSString *)text;

/// 显示toast
/// @param text 文本
/// @param positionType 位置
+ (void)showWithText:(NSString *)text positionType:(IFToastPositionType)positionType;

/// 显示toast
/// @param text 文本
/// @param duration 时长
/// @param positionType 位置
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration positionType:(IFToastPositionType)positionType;

/// 显示toast
/// @param text 文本
/// @param duration 时长
/// @param offset 偏移量
/// @param positionType 位置
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration offset:(CGFloat)offset positionType:(IFToastPositionType)positionType;

/// 显示toast
/// @param text 文本
/// @param duration 时长
/// @param offset 偏移量
/// @param userEnable 是否可以交互（拦截）
/// @param positionType 位置
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration offset:(CGFloat)offset userEnable:(BOOL)userEnable positionType:(IFToastPositionType)positionType;

/// 显示toast 在中间
- (void)showInCenter;


/// 显示toast
/// @param view 承载视图
- (void)showInView:(UIView *)view;


/// 隐藏（无动画）
- (void)dismissToast;

/// 隐藏（有动画）
- (void)hideAnimation;


/// 构建 toast
/// @param text 文本
- (instancetype)initWithText:(NSString *)text;

/// 构建 toast
/// @param image 图片
/// @param text 文本
- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text;

/// 构建 toast
/// @param image 图片（YYImage 类型）
- (instancetype)initWithImage:(YYImage *)image;

@end

//
//  IFToastView.h
//  IFToast
//
//  Created by MrGLZh on 2022/1/3.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IFToastPosition) {
    IFToastPositionTop,
    IFToastPositionCenter,
    IFToastPositionBottom,
};

typedef NS_ENUM(NSUInteger, IFToastEffectStyle){
    IFToastEffectStyleLight,
    IFToastEffectStyleDark
};

@interface IFToastView : UIVisualEffectView
/*!背景色 default：black*/
@property (nonatomic, strong) UIColor *contentColor;
/*!字体颜色 default：white*/
@property (nonatomic, strong) UIColor *textColor;
/*!字体大小 default：16*/
@property (nonatomic, strong) UIFont *textFont;
/*!展示时长 default：1s*/
@property (nonatomic, assign) NSTimeInterval duration;
/*!是否可交互 default：NO*/
@property (nonatomic, assign) BOOL isUserEnable;
/*!位置 default：center*/
@property (nonatomic, assign) IFToastPosition position;
/*!圆角大小*/
@property (nonatomic, assign) CGFloat radius;
/*!样式 default: light*/
@property (nonatomic, assign) IFToastEffectStyle effectStyle;

+ (void)removeAllToast;

- (void)showToastWithText:(NSString *)text;

- (void)showToastWithText:(NSString *)text position:(IFToastPosition)position;

- (void)showToastWithText:(NSString *)text tipView:(UIView *)tipView;

- (void)showToastWithText:(NSString *)text tipImage:(UIImage *)tipImage;

@end


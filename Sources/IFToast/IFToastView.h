//
//  IFToastView.h
//  IFToast
//
//  Created by MrGLZh on 2022/1/3.
//

#import <UIKit/UIKit.h>
#import <YYImage/YYImage.h>

@interface IFToastView : NSObject

+ (void)showCenterWithText:(NSString *)text;

+ (void)showWithImage:(UIImage *)image text:(NSString *)text;

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration userEnable:(BOOL)userEnable;

+ (void)showTopWithText:(NSString *)text;

+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

+ (void)showBottomWithText:(NSString *)text;

+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;


- (void)showGifCenter;

- (void)showInView:(UIView *)view;

- (void)showGifInView:(UIView *)view;

- (void)hideGifCenter;


- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text;

- (instancetype)initWithImage:(YYImage *)image;



@end

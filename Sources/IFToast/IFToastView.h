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

//@property (nonatomic, strong) UIColor *

+ (void)showWithImage:(UIImage *)image text:(NSString *)text;

+ (void)showWithText:(NSString *)text positionType:(IFToastPositionType)positionType;

+ (void)showWithText:(NSString *)text duration:(CGFloat)duration positionType:(IFToastPositionType)positionType;

+ (void)showWithText:(NSString *)text duration:(CGFloat)duration offset:(CGFloat)offset positionType:(IFToastPositionType)positionType;

+ (void)showWithText:(NSString *)text duration:(CGFloat)duration offset:(CGFloat)offset userEnable:(BOOL)userEnable positionType:(IFToastPositionType)positionType;

- (void)showGifCenter;

- (void)showInView:(UIView *)view;

- (void)showGifInView:(UIView *)view;

- (void)hideGifCenter;


- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text;

- (instancetype)initWithImage:(YYImage *)image;

@end

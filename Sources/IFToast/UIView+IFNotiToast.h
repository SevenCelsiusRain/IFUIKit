//
//  UIView+IFNotiToast.h
//  IFToast
//
//  Created by MrGLZh on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (IFNotiToast)

- (void)showNotiToastWithText:(NSString *)text;

- (void)showNotiToastWithText:(NSString *)text image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

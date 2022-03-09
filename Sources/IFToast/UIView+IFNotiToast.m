//
//  UIView+IFNotiToast.m
//  IFToast
//
//  Created by MrGLZh on 2022/3/8.
//

#import <CRToast.h>
#import "UIView+IFNotiToast.h"

@implementation UIView (IFNotiToast)

- (void)showNotiToastWithText:(NSString *)text {
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastTextColorKey:UIColor.blackColor,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastUnderStatusBarKey:@(YES),
                              kCRToastBackgroundColorKey : [UIColor yellowColor],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar)
                              };
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];
}

- (void)showNotiToastWithText:(NSString *)text image:(UIImage *)image {
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastTextColorKey:UIColor.blackColor,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastImageKey:image,
                              kCRToastUnderStatusBarKey:@(YES),
                              kCRToastBackgroundColorKey : [UIColor yellowColor],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              kCRToastForceUserInteractionKey:@(YES),
                              kCRToastImageContentModeKey:@(UIViewContentModeTop)
                              };
    
    [CRToastManager showNotificationWithOptions:options apperanceBlock:^{
        NSLog(@"");
    } completionBlock:^{
        
    }];
    
//    [CRToastManager showNotificationWithOptions:options
//                                completionBlock:^{
//                                    NSLog(@"Completed");
//                                }];
}

@end

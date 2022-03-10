//
//  DetailController.h
//  Example
//
//  Created by MrGLZh on 2022/3/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DetailType) {
    DetailTypeToast = 0,
    DetailTypeAlert,
    DetailTypeHUD,
    DetailTypeEmpty
};

NS_ASSUME_NONNULL_BEGIN

@interface DetailController : UIViewController
@property (nonatomic, assign) DetailType type;

@end

NS_ASSUME_NONNULL_END

//
//  UIImage+IFEmptyBundle.h
//  IFEmptyView
//
//  Created by MrGLZh on 2022/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IFEmptyBundle)

/**
 根据图片名字，从IFEmptyView.bundle中找到对应的图片对象
 */
+ (UIImage *)if_imageWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END

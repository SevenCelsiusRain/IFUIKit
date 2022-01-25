//
//  UIImage+IFEmptyBundle.m
//  IFEmptyView
//
//  Created by MrGLZh on 2022/1/25.
//

#import "UIImage+IFEmptyBundle.h"

@implementation UIImage (IFEmptyBundle)
+ (UIImage *)if_imageWithName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"IFEmptyView"
                                                           ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if ([imageName hasSuffix:@"@2x"] || [imageName hasSuffix:@"@3x"]) {
        NSString *imgPath = [bundle pathForResource:imageName ofType:@"png"];
        return [UIImage imageWithContentsOfFile:imgPath];
    }
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSString *imageTemp;
    if (scale >= 3) {
        imageTemp = [NSString stringWithFormat:@"%@@3x",imageName];
        NSString *imgPath = [bundle pathForResource:imageTemp ofType:@"png"];
        UIImage *image3x = [UIImage imageWithContentsOfFile:imgPath];
        if (image3x) {
            return image3x;
        }
    }
    
    imageTemp = [NSString stringWithFormat:@"%@@2x",imageName];
    NSString *imgPath = [bundle pathForResource:imageTemp ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imgPath];
}
@end

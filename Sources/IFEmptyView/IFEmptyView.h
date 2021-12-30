//
//  IFEmptyView.h
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IFEmptyViewType){
    IFEmptyViewTypeNoNet,
    IFRefreshTypeContentEmpty,
    IFEmptyViewTypeEmpty
};
@interface IFEmptyView : UIView
/*!距离顶部间距*/
@property (nonatomic, assign) CGFloat topPadding;
/*!按钮宽度*/
@property (nonatomic, assign) CGFloat buttonWidth;
/*!内容字体*/
@property (nonatomic, strong) UIFont *infoFont;
/*!内容行间距*/
@property (nonatomic, assign) CGFloat infoLineSpace;
/*!图片*/
@property (nonatomic, strong) UIImage *image;

+ (instancetype)emptyView;

@end

NS_ASSUME_NONNULL_END

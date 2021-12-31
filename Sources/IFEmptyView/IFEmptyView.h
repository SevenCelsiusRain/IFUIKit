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
/*!内容文本*/
@property (nonatomic, copy) NSString *infoString;
/*!用户选中回调*/
@property (nonatomic, copy) void (^userOperationBlock)(NSInteger index);

+ (instancetype)emptyView;

/**
 隐藏所有操作按钮
 */
- (void)hideAllOperationButton;

/**
 设置按钮标题
 一个元素时为居中按钮标题
 两个元素时为双按钮标题
 */
- (void)setButtonTitles:(NSArray<NSString*>*)titles;

@end

NS_ASSUME_NONNULL_END

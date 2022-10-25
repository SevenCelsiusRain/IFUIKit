//
//  IFEmptyView.h
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, IFEmptyViewType){
    IFEmptyViewTypeNetless, // 弱网/无网
    IFEmptyViewTypeContent, // 无内容
    IFEmptyViewTypeData,  // 无数据
    IFEmptyViewTypeDelete, // 内容被删除
    IFEmptyViewTypeSearch, // 搜索无结果
    IFEmptyViewTypeEmpty // 空白页
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
/*!按钮字体*/
@property (nonatomic, strong) UIFont *buttonFont;

+ (instancetype)emptyView;

/**
 隐藏所有操作按钮
 */
- (void)hideAllOperationButton;

/**
 设置样式，描述文本
 */
- (void)setContentWithType:(IFEmptyViewType)type infoText:(NSString *)infoText;

/**
 设置按钮标题
 一个元素时为居中按钮标题
 两个元素时为双按钮标题
 */
- (void)setButtonTitles:(NSArray<NSString*>*)titles;

@end


//
//  UIView+IFEmptyView.h
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "IFEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IFEmptyViewBlock) (IFEmptyView *emptyView);
typedef void (^IFUserOperationHandler)(NSInteger index);

@interface UIView (IFEmptyView)

/**
 显示无按钮空视图
 @param emptyViewBlock 空视图样式定制
 */
- (void)if_showEmptyView:(IFEmptyViewBlock)emptyViewBlock;

/**
 显示无按钮空视图
 @param emptyViewBlock 空视图样式定制
 @param operationHandler  点击下标，单按钮时 0：左，1：右
 */
- (void)if_showEmptyView:(IFEmptyViewBlock)emptyViewBlock selectIndex:(IFUserOperationHandler)operationHandler;


- (void)if_hideEmptyView;

@end

NS_ASSUME_NONNULL_END

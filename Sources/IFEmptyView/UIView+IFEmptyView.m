//
//  UIView+IFEmptyView.m
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import "UIView+IFEmptyView.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char IFEmptyViewKey;
@interface UIView (IFEmptyView)

@property (nonatomic, strong) IFEmptyView *emptyView;

@end

@implementation UIView (IFEmptyView)

#pragma mark - public method

// MARK: 显示空视图
- (void)if_showEmptyView:(IFEmptyViewBlock)emptyViewBlock {
    [self.emptyView hideAllOperationButton];
    [self addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    [self bringSubviewToFront:self.emptyView];
    if (emptyViewBlock) {
        emptyViewBlock(self.emptyView);
    }
}

- (void)if_showEmptyView:(IFEmptyViewBlock)emptyViewBlock selectIndex:(IFUserOperationHandler)operationHandler {
    [self.emptyView hideAllOperationButton];
    [self addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    [self bringSubviewToFront:self.emptyView];
    if (emptyViewBlock) {
        dispatch_async(dispatch_main(), ^{
            emptyViewBlock(self.emptyView);
        });
    }
    if (operationHandler) {
        self.emptyView.userOperationBlock = ^(NSInteger index) {
            dispatch_async(dispatch_main(), ^{
                operationHandler(index);
            });
        };
    }
}


- (void)if_hideEmptyView {
    self.emptyView.hidden = YES;
    [self.emptyView removeFromSuperview];
}

#pragma mark - getter & setter

- (void)setEmptyView:(IFEmptyView *)emptyView {
    objc_setAssociatedObject(self, &IFEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IFEmptyView *)emptyView {
    IFEmptyView *tempView = objc_getAssociatedObject(self, &IFEmptyViewKey);
    if (!tempView) {
        tempView = [IFEmptyView emptyView];
        objc_setAssociatedObject(self, &IFEmptyViewKey, tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tempView;
}

@end

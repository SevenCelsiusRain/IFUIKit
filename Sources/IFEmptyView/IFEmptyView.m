//
//  IFEmptyView.m
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import "IFEmptyView.h"

@interface IFEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation IFEmptyView

+ (instancetype)emptyView {
    IFEmptyView *emptyV = [IFEmptyView new];
    
    return emptyV;
}

#pragma mark - event handler

- (void)centerBtnAction {
    // FIXME: 待完善
}

- (void)leftBtnAction {
    
}

- (void)rightBtnAction {
    
}

#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerButton addTarget:self action:@selector(centerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}



@end

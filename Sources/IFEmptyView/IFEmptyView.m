//
//  IFEmptyView.m
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import "IFEmptyView.h"
#import <Masonry/Masonry.h>

@interface IFEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation IFEmptyView

#pragma mark - public method
+ (instancetype)emptyView {
    IFEmptyView *emptyV = [IFEmptyView new];
    [emptyV configUI];
    return emptyV;
}

- (void)hideAllOperationButton {
    self.centerButton.hidden = YES;
    self.leftButton.hidden = YES;
    self.rightButton.hidden = YES;
}

- (void)setButtonTitles:(NSArray<NSString *> *)titles {
    if (titles.count <= 0) {
        return;
    }
    
    if (titles.count == 1) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.centerButton.hidden = NO;
        [self.centerButton setTitle:titles[0] forState:UIControlStateNormal];
    }else {
        self.centerButton.hidden = YES;
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
        [self.leftButton setTitle:titles[0] forState:UIControlStateNormal];
        [self.rightButton setTitle:titles[1] forState:UIControlStateNormal];
    }
}


#pragma mark - private method

- (void)configUI {
    [self addSubview:self.imageView];
    [self addSubview:self.centerButton];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.infoLabel];
    
    [self.imageView mas]
}

#pragma mark - event handler

- (void)centerBtnAction {
    if (self.userOperationBlock) {
        self.userOperationBlock(0);
    }
}

- (void)leftBtnAction {
    if (self.userOperationBlock) {
        self.userOperationBlock(0);
    }
}

- (void)rightBtnAction {
    if (self.userOperationBlock) {
        self.userOperationBlock(1);
    }
}

#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textColor = UIColor.lightTextColor;
        _infoLabel.font = [UIFont systemFontOfSize:12` weight:UIFontWeightMedium];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.layer.borderColor = UIColor.redColor;
        _centerButton.layer.borderWidth = 1.0;
        _centerButton.layer.cornerRadius = 20;
        _centerButton.clipsToBounds = YES;
        _centerButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_centerButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_centerButton addTarget:self action:@selector(centerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.layer.borderColor = UIColor.redColor;
        _leftButton.layer.borderWidth = 1.0;
        _leftButton.layer.cornerRadius = 20;
        _leftButton.clipsToBounds = YES;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_leftButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.layer.borderColor = UIColor.redColor;
        _rightButton.layer.borderWidth = 1.0;
        _rightButton.layer.cornerRadius = 20;
        _rightButton.clipsToBounds = YES;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_rightButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}



@end

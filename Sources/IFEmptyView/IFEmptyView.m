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
    self.leftButton.hidden = YES;
    self.centerButton.hidden = YES;
    self.rightButton.hidden = YES;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(250, 187));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(27);
        make.centerX.equalTo(self);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.right.equalTo(self.mas_centerX).offset(-6);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftButton.mas_top);
        make.size.equalTo(self.leftButton);
        make.left.equalTo(self.mas_centerX).offset(6);
    }];
    
    [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.centerX.equalTo(self);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.mas_height > 0) {
        CGFloat topOffset = self.topPadding;
        if (topOffset == 0) {
            topOffset = self.mas_height * 0.3;
        }
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(top);
            make.centerX.equalTo(self);
            make.size.equalTo(CGSizeMake(250, 187));
        }];
        CGFloat btnWidth = self.buttonWidth == 0? 110:self.buttonWidth;
        [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 40));
        }];

    }
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
        _infoLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.layer.borderColor = [UIColor redColor].CGColor;
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
        _leftButton.layer.borderColor = [UIColor redColor].CGColor;
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
        _rightButton.layer.borderColor = [UIColor redColor].CGColor;
        _rightButton.layer.borderWidth = 1.0;
        _rightButton.layer.cornerRadius = 20;
        _rightButton.clipsToBounds = YES;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_rightButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}


#pragma mark - setter

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setTopPadding:(CGFloat)topPadding {
    _topPadding = topPadding;
    [self setNeedsDisplay];
}

- (void)setButtonWidth:(CGFloat)buttonWidth {
    _buttonWidth = buttonWidth;
    [self setNeedsDisplay];
}

- (void)setInfoFont:(UIFont *)infoFont {
    _infoFont = infoFont;
    self.infoLabel.font = infoFont;
}

- (void)setInfoString:(NSString *)infoString {
    _infoString = infoString;
    self.infoLabel.text = infoString;
}
@end

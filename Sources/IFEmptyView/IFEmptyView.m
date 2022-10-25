//
//  IFEmptyView.m
//  IFEmptyView
//
//  Created by MrGLZh on 2021/12/30.
//

#import "IFEmptyView.h"
#import <Masonry/Masonry.h>
#import "UIImage+IFEmptyBundle.h"

@interface IFEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, assign) IFEmptyViewType type;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *infoTextStr;
@property (nonatomic, copy) NSString *tipTextStr;

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

- (void)setContentWithType:(IFEmptyViewType)type infoText:(NSString *)infoText {
    self.type = type;
    NSString *tipText = self.tipTextStr;
    if (infoText.length > 0) {
        tipText = infoText;
    }
    if (self.type == IFEmptyViewTypeNetless) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
        [self addGestureRecognizer:tap];
    }
    
    self.imageView.image = [UIImage if_imageWithName:self.imageName];
    if (tipText) {
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:tipText];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = self.infoLineSpace;
        [attri addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, tipText.length)];
        self.infoLabel.attributedText = attri;
    }
}


#pragma mark - private method

- (void)configUI {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.imageView];
    [self addSubview:self.centerButton];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.infoLabel];
    self.leftButton.hidden = YES;
    self.centerButton.hidden = YES;
    self.rightButton.hidden = YES;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.infoLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(285, 210));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
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
        make.size.mas_equalTo(CGSizeMake(162, 46));
        make.centerX.equalTo(self);
    }];
    
}

- (void)configCenterBtnTheme {
    self.centerButton.hidden = NO;
    self.infoLabel.hidden = NO;
    if (self.type == IFEmptyViewTypeNetless) {
        self.centerButton.layer.borderWidth = 1;
        self.centerButton.layer.borderColor = [UIColor colorWithRed:222/255.f green:222/255.f blue:225/255.f alpha:1].CGColor;
        [self.centerButton setTitleColor:[UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1] forState:UIControlStateNormal];
    }else {
        self.centerButton.layer.borderWidth = 1;
        self.centerButton.layer.borderColor = [UIColor colorWithRed:255/255.f green:68/255.f blue:0 alpha:1].CGColor;
        [self.centerButton setTitleColor:[UIColor colorWithRed:255/255.F green:68/255.F blue:0 alpha:1] forState:UIControlStateNormal];
    }
}

#pragma mark - event handler

- (void)tapGestureAction {
    if (self.userOperationBlock) {
        self.userOperationBlock(0);
    }
}

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
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.textColor = [UIColor colorWithRed:110/255.f green:112/255.f blue:115/255.f alpha:1];
    }
    return _infoLabel;
}

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.layer.borderColor = [UIColor redColor].CGColor;
        _centerButton.layer.borderWidth = 1.0;
        _centerButton.layer.cornerRadius = 2;
        _centerButton.clipsToBounds = YES;
        _centerButton.titleLabel.font = [UIFont systemFontOfSize:16];
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
        _leftButton.layer.cornerRadius = 2;
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
        _rightButton.layer.cornerRadius = 2;
        _rightButton.clipsToBounds = YES;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_rightButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (NSString *)imageName {
    NSString *tempStr = @"";
    switch (self.type) {
        case IFEmptyViewTypeNetless:
            tempStr = @"if_empty_netless";
            break;
            
        case IFEmptyViewTypeData:
            tempStr = @"if_empty_data";
            break;
            
        case IFEmptyViewTypeDelete:
            tempStr = @"if_empty_delete";
            break;
            
        case IFEmptyViewTypeSearch:
            tempStr = @"if_empty_search";
            break;
            
        case IFEmptyViewTypeContent:
            tempStr = @"if_empty_content";
            break;
            
        default:
            break;
    }
    return tempStr;
}

- (NSString *)tipTextStr {
    NSString *tipStr = @"";
    switch (self.type) {
        case IFEmptyViewTypeNetless:
            tipStr = @"当前网络加载缓慢，点击页面刷新重试";
            break;
            
        case IFEmptyViewTypeData:
            tipStr = @"此处暂无内容，去看看别的";
            break;
            
        case IFEmptyViewTypeSearch:
            tipStr = @"没有符合条件的结果";
            break;
            
        case IFEmptyViewTypeContent:
            tipStr = @"暂无内容";
            break;
            
        case IFEmptyViewTypeDelete:
            tipStr = @"此处暂无内容，去看看别的";
            break;
            
        default:
            break;
    }
    return tipStr;
}


#pragma mark - setter

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setTopPadding:(CGFloat)topPadding {
    _topPadding = topPadding;
    if (topPadding == 0) {
        return;
    }
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topPadding);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(285, 210));
    }];
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self);
    }];
}

- (void)setButtonWidth:(CGFloat)buttonWidth {
    _buttonWidth = buttonWidth;
    if (buttonWidth == 0) {
        return;
    }
    [self setNeedsDisplay];
    [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 40));
    }];
}

- (void)setInfoFont:(UIFont *)infoFont {
    _infoFont = infoFont;
    self.infoLabel.font = infoFont;
}

- (void)setInfoString:(NSString *)infoString {
    _infoString = infoString;
    self.infoLabel.text = infoString;
}

- (void)setButtonFont:(UIFont *)buttonFont {
    _buttonFont = buttonFont;
    self.centerButton.titleLabel.font = buttonFont;
    self.leftButton.titleLabel.font = buttonFont;
    self.rightButton.titleLabel.font = buttonFont;
}

@end

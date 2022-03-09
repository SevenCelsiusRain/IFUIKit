//
//  IFToastView.m
//  IFToast
//
//  Created by MrGLZh on 2022/1/3.
//

#import "IFToastView.h"

#define TOAST_MIN_WIDTH  108.0
#define TOAST_HEIGHT 56.0
#define FADE_DURATION 0.3
#define TEXT_TOAST_TAG 47097
#define IMG_TOAST_TAG 47098
#define TOAST_COLOR_WHITE [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0]
#define TOAST_COLOR_BLACK [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8]
#define TOP_WINDOW [UIApplication sharedApplication].keyWindow
#define CORNER_RADIUS 5.0

@interface IFToastView ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) NSString *textStr;
@property (nonatomic, strong) UIView *tipView;

@end

@implementation IFToastView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - public method

- (void)showToastWithText:(NSString *)text {
    self.textStr = text;
    [self show];
}

- (void)showToastWithText:(NSString *)text position:(IFToastPosition)position {
    self.textStr = text;
    self.config.position = position;
    [self show];
}

- (void)showToastWithText:(NSString *)text tipView:(UIView *)tipView {
    _tipView = tipView;
    if (text.length <= 0) return;
    IFToastView *toastV = [IFToastView contentToastWithTag:IMG_TOAST_TAG title:text];
    tipView.frame = CGRectMake(58, 28, 40, 40);
    [toastV.contentV addSubview:tipView];
    [toastV showImgToastWithStayDuration:self.config.duration
                  usingSpringWithDamping:0
                   initialSpringVelocity:0
                                 options:UIViewAnimationOptionCurveEaseInOut];
}

- (void)showToastWithText:(NSString *)text tipImage:(UIImage *)tipImage {
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = tipImage;
    [self showToastWithText:text tipView:imageV];
}

+ (void)removeAllToast {
    if (TOP_WINDOW.subviews.count <= 0) return;
    for (UIView *v in TOP_WINDOW.subviews) {
        if ([v isKindOfClass:[self class]] && (v.tag == TEXT_TOAST_TAG || v.tag == IMG_TOAST_TAG)) {
            v.hidden = true;
            [NSObject cancelPreviousPerformRequestsWithTarget:v];
            [v removeFromSuperview];
        }
    }
}


#pragma mark - private method
- (void)configUI {
    self.alpha = 0.0;
    self.backgroundColor = self.config.contentColor;
    self.layer.cornerRadius = self.config.radius;
    self.clipsToBounds = true;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.effect = effect;
    [self.contentView addSubview:self.textLabel];
}

+ (IFToastView *)contentToastWithTag:(NSInteger)tag title:(NSString *)title {
    IFToastView *toastV = [IFToastView toastWithTag:IMG_TOAST_TAG title:title];
    toastV.frame = TOP_WINDOW.bounds;
    toastV.layer.masksToBounds = false;
    toastV.layer.cornerRadius = 0.0;
    toastV.backgroundColor = toastV.backgroundColor;

    toastV.contentV.layer.masksToBounds = true;
    [toastV.contentView insertSubview:toastV.contentV belowSubview:toastV.textLabel];
    toastV.textLabel.frame = CGRectMake(toastV.contentV.frame.origin.x, CGRectGetMaxY(toastV.contentV.frame) - 48, toastV.contentV.frame.size.width, 26);
    toastV.textLabel.text = title;
    toastV.effect = nil;
    return toastV;
}

+ (IFToastView *)toastWithTag:(NSInteger)tag title:(NSString *)title {
    [self removeAllToast];
    IFToastView *toastV = [[IFToastView alloc] init];
    toastV.tag = tag;
    return toastV;
}


+ (IFToastView *)getToastWithTag:(NSInteger)tag {
    if (TOP_WINDOW.subviews.count <= 0) return nil;
    for (UIView *v in TOP_WINDOW.subviews) {
        if ([v isKindOfClass:[IFToastView class]] && v.tag == tag) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincompatible-pointer-types"
            return v;
#pragma clang diagnostic pop
        }
    }
    return nil;
}

- (void)show {
    if (self.textStr.length <= 0) {
        return;
    }
    self.textLabel.text = self.textStr;
    [IFToastView removeAllToast];
    self.effect = [UIBlurEffect effectWithStyle:self.config.effectStyle == IFToastEffectStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
    [self showTextToastWithWithStayDuration:self.config.duration position:self.config.position];
}

- (CGFloat)calculateMessagTHeightWithText:(NSString *)string
                                    width:(CGFloat)width
                                attribute:(NSDictionary *)attribute {
    static UILabel *stringLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stringLabel = [[UILabel alloc] init];
        stringLabel.numberOfLines = 0;
    });
    stringLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:string attributes:attribute];
    stringLabel.preferredMaxLayoutWidth = width;
    return [stringLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height;
}

- (void)showTextToastWithWithStayDuration:(NSTimeInterval)Duration
                                 position:(IFToastPosition)position {
    CGFloat preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 144;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.textLabel.font.pointSize * 0.5];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSDictionary *dic = @{
                          NSFontAttributeName: self.textLabel.font,
                          NSParagraphStyleAttributeName: paragraphStyle,
                          NSForegroundColorAttributeName: TOAST_COLOR_WHITE
                          };
    CGFloat height = [self calculateMessagTHeightWithText:self.textStr width:preferredMaxLayoutWidth attribute:dic] + 40;
    if (height > TOAST_HEIGHT + 20) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textLabel.text attributes:dic];
        self.frame = CGRectMake(0, 0, preferredMaxLayoutWidth + 40, height);
        self.textLabel.frame = CGRectMake(20, 0, preferredMaxLayoutWidth, height);
        self.textLabel.attributedText = attributedString;
        self.textLabel.numberOfLines = 0;
    }else {
        NSDictionary *attrs = @{NSFontAttributeName : self.textLabel.font};
        CGSize size = [self.textLabel.text sizeWithAttributes:attrs];
        self.frame = CGRectMake(0, 0, (size.width + 42) > TOAST_MIN_WIDTH ? (size.width + 42) : TOAST_MIN_WIDTH, TOAST_HEIGHT);
        self.textLabel.frame = self.bounds;
        self.textLabel.numberOfLines = 1;
    }
    
    CGPoint center = TOP_WINDOW.center;
    switch (position) {
        case IFToastPositionTop: center.y = TOP_WINDOW.bounds.size.height * 0.25; break;
        case IFToastPositionBottom: center.y = TOP_WINDOW.bounds.size.height * 0.75; break;
        case IFToastPositionCenter: break;
        default: break;
    }
    self.center = center;
    
    [self showImgToastWithStayDuration:Duration
                usingSpringWithDamping:0.8
                 initialSpringVelocity:10
                               options:UIViewAnimationOptionCurveEaseInOut];
}

- (void)showImgToastWithStayDuration:(NSTimeInterval)Duration usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options {
    UIWindow * window = TOP_WINDOW;
    
    [TOP_WINDOW addSubview:self];
    [TOP_WINDOW bringSubviewToFront:self];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(removeToastView) withObject:nil afterDelay:Duration];
    }];
}

- (void)removeToastView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}


#pragma mark - getter

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textColor = TOAST_COLOR_WHITE;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [UIView new];
        _contentV = [[UIView alloc] initWithFrame:CGRectMake((TOP_WINDOW.bounds.size.width - 156) * 0.5, (TOP_WINDOW.bounds.size.height - 122) * 0.5, 156, 122)];
        _contentV.backgroundColor = TOAST_COLOR_BLACK;
        _contentV.layer.cornerRadius = CORNER_RADIUS;
        _contentV.layer.masksToBounds = true;
    }
    return _contentV;
}

#pragma mark - setter

- (NSInteger)tag {
    if (self.tipView) {
        return IMG_TOAST_TAG;
    }
    return TEXT_TOAST_TAG;
}

@end


@implementation IFToastConfig

+ (instancetype)config {
    IFToastConfig *config = [[IFToastConfig alloc] init];
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _contentColor = UIColor.blackColor;
        _textColor = UIColor.whiteColor;
        _textFont = [UIFont systemFontOfSize:16];
        _duration = 1.0;
        _isUserEnable = NO;
        _position = IFToastPositionCenter;
        _effectStyle = IFToastEffectStyleLight;
        _radius = 5;
    }
    return self;
}

@end

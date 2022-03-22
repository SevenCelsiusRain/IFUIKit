//
//  IFAlertController.m
//  IFAlert
//
//  Created by MrGLZh on 2021/12/31.
//

#import "IFAlertController.h"
#import <Masonry/Masonry.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface IFAlertController ()
@property (nonatomic, assign) IFAlertDirectionType direction;
/*!中间视图*/
@property (nonatomic, strong) UIView *contentView;
/*!中间视图圆角大小*/
@property (nonatomic, assign) CGFloat contentRadius;
/*!垂直方向移动距离*/
@property (nonatomic, assign) CGFloat moveVerticalSpace;
@property (nonatomic, strong) UIView *fixBankView;
@property (nonatomic, strong) UIView *blurView;

@end

@implementation IFAlertController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isKeyboardChange) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNoti:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNoti:) name:UIKeyboardWillHideNotification object:nil];
    }
    [self show];
    if (self.autoDismissDuration > 0) {
        dispatch_after(DISPATCH_TIME_NOW + self.autoDismissDuration, dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isKeyboardChange) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - init

- (instancetype)init {
    self = [super init];
    if(self) {
        _moveUpOffset = 0;
        _isKeyboardChange = NO;
        _contentViewSize = CGSizeZero;
        _moveVerticalSpace = 0;
        _isFixBankSpace = YES;
        _animated = YES;
        _tapDismiss = YES;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)contentView radius:(CGFloat)radius direction:(IFAlertDirectionType)direction {
    self = [self init];
    if (self) {
        _direction = direction;
        _contentView = contentView;
        _contentRadius = radius;
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller radius:(CGFloat)radius direction:(IFAlertDirectionType)direction {
    self = [self initWithView:controller.view radius:radius direction:direction];
    [self addChildViewController:controller];
    
    return self;
}


#pragma mark - private method

- (void)configUI {
    [self.view addSubview:self.blurView];
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [self.blurView addGestureRecognizer:tap];
    [self configContentView];
}

- (void)configContentView {
    [self.view addSubview:self.contentView];
    CGSize midViewSize = CGSizeEqualToSize((self.contentViewSize), CGSizeZero) ? self.contentView.frame.size : self.contentViewSize;
    UIRectCorner corner;
    switch (self.direction) {
        case IFAlertDirectionTypeCenter:{
            if (CGSizeEqualToSize((midViewSize), CGSizeZero)) {
                midViewSize = CGSizeMake(SCREEN_WIDTH - 40, SCREEN_WIDTH);
            }
            corner = UIRectCornerAllCorners;
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.moveUpOffset > 0) {
                    make.centerX.equalTo(self.view);
                    make.top.mas_equalTo((SCREEN_WIDTH - self.contentView.frame.size.height)/2 - self.moveUpOffset);
                }else{
                    make.center.equalTo(self.view);
                }
                make.size.mas_equalTo(midViewSize);
            }];
        }
            break;
            
        case IFAlertDirectionTypeBottom:{
            if (CGSizeEqualToSize(midViewSize, CGSizeZero)) {
                midViewSize = CGSizeMake(SCREEN_WIDTH, 120);
            }
            corner = UIRectCornerTopLeft|UIRectCornerTopRight;
            self.moveVerticalSpace = midViewSize.height + 80;
            if (self.isFixBankSpace) {
                UIView *fixView = [UIView new];
                fixView.backgroundColor = self.fixBankColor ? self.fixBankColor : self.contentView.backgroundColor;
                [self.view addSubview:fixView];
                [fixView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.contentView);
                    make.top.equalTo(self.contentView.mas_bottom);
                    make.bottom.equalTo(self.view).offset(self.moveVerticalSpace);
                }];
                self.fixBankView = fixView;
            }
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.size.mas_equalTo(midViewSize);
                if (@available(iOS 11.0, *)) {
                    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(self.moveVerticalSpace);
                }else {
                    make.top.equalTo(self.view.mas_bottom).offset(self.moveVerticalSpace);
                };
            }];
        }
            
            break;
            
        case IFAlertDirectionTypeTop:{
            if (CGSizeEqualToSize(midViewSize, CGSizeZero)) {
                midViewSize = CGSizeMake(SCREEN_WIDTH, 26);
            }
            corner = UIRectCornerBottomLeft|UIRectCornerBottomRight;
            self.moveVerticalSpace = midViewSize.height + 80;
            if (self.isFixBankSpace) {
                UIView *fixView = [UIView new];
                fixView.backgroundColor = self.fixBankColor ? self.fixBankColor : self.contentView.backgroundColor;
                [self.view addSubview:fixView];
                [fixView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.contentView);
                    make.top.equalTo(self.view.mas_top).offset(-self.moveVerticalSpace);
                    make.bottom.equalTo(self.contentView.mas_top);
                }];
                self.fixBankView = fixView;
            }
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.size.mas_equalTo(midViewSize);
                if (@available(iOS 11.0, *)) {
                    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(-self.moveVerticalSpace);
                }else {
                    make.top.equalTo(self.view.mas_top).offset(-self.moveVerticalSpace);
                };
            }];
        }
            break;
            
        case IFAlertDirectionTypeAny:{
            corner = UIRectCornerAllCorners;
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(midViewSize);
                if (@available(iOS 11.0, *)) {
                    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(self.directionPoint.y);
                }else {
                    make.top.equalTo(self.view.mas_top).offset(self.directionPoint.y);
                };
                make.leading.equalTo(self.view).offset(self.directionPoint.x);
            }];
        }
            break;
            
        default:
            break;
    }
    self.contentViewSize = midViewSize;
    if (self.contentRadius) {
        [self cornerWithView:self.contentView corners:corner radius:self.contentRadius bounds:CGRectMake(0, 0, midViewSize.width, midViewSize.height)];
    }
}

- (void)cornerWithView:(UIView *)view corners:(UIRectCorner)corners radius:(CGFloat)radius bounds:(CGRect)bounds {
    CGRect viewBounds = view.bounds;
    if (!CGRectEqualToRect(bounds, CGRectZero)) {
        viewBounds = bounds;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewBounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

// MARK: 显示
- (void)show {
    NSTimeInterval animatedTime = 0;
    if (self.animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view layoutIfNeeded];
        });
        animatedTime = 0.3;
    }
    switch (self.direction) {
        case IFAlertDirectionTypeTop:{
            if (self.fixBankView) {
                [self.fixBankView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(-8);
                }];
            }
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                }else {
                    make.top.equalTo(self.view);
                }
            }];
        }
            break;
            
        case IFAlertDirectionTypeBottom:{
            if (self.fixBankView) {
                [self.fixBankView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view);
                }];
            }
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                }else {
                    make.bottom.equalTo(self.view);
                }
            }];
        }
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:animatedTime animations:^{
        self.blurView.backgroundColor = self.blurColor;
    }];
    
    [UIView animateWithDuration:animatedTime delay:0 usingSpringWithDamping:2.0 initialSpringVelocity:1.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view layoutIfNeeded];
        });
    } completion:nil];
}

// MARK: 隐藏
- (void)dismiss {
    switch (self.direction) {
        case IFAlertDirectionTypeTop:{
            if (self.fixBankView) {
                [self.fixBankView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(-self.moveVerticalSpace);
                }];
            }
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(-self.moveVerticalSpace);
                }else {
                    make.top.equalTo(self.view).offset(-self.moveVerticalSpace);
                }
            }];
        }
            break;
        case IFAlertDirectionTypeBottom:{
            if (self.fixBankView) {
                [self.fixBankView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view).offset(self.moveVerticalSpace);
                }];
            }
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(self.moveVerticalSpace);
                }else {
                    make.bottom.equalTo(self.view).offset(self.moveVerticalSpace);
                }
            }];
        }
            break;
            
        default:
            break;
    }
            
    NSTimeInterval animatedTime = 0;
    if (self.animated) {
        animatedTime = 0.3;
    }
    [UIView animateWithDuration:animatedTime animations:^{
        self.blurView.backgroundColor = UIColor.clearColor;
    }];
    [UIView animateWithDuration:animatedTime delay:0 usingSpringWithDamping:2 initialSpringVelocity:1.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view layoutIfNeeded];
        });
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self dismissViewControllerAnimated:false completion:^{
            if (self.dismissDone) {
                self.dismissDone();
            }
        }];
    }];
}


#pragma mark - noti
// MARK: 键盘显示
- (void)keyboardShowNoti:(NSNotification *)noti {
    CGRect endFrame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat keyboardY = endFrame.origin.y;
    CGFloat yAxis = self.contentView.frame.origin.y > 0 ? self.contentView.frame.origin.y : (SCREEN_HEIGHT - self.contentViewSize.height)/2;
    if (yAxis > self.contentViewSize.height + 40 + keyboardY) {
        return;
    }
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT-keyboardY-40-self.contentViewSize.height);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(self.contentViewSize);
    }];
}
// MARK: 键盘隐藏
- (void)keyboardHideNoti:(NSNotification *)noti {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(self.contentViewSize);
    }];
}


#pragma mark - event handler
// MARK: 消失
- (void)dismissAction {
    if (self.tapDismiss) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }
}

#pragma mark - getter
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;;
}

- (UIView *)blurView {
    if(!_blurView){
        _blurView = [UIView new];
    }
    return _blurView;
}

- (UIColor *)blurColor {
    if(!_blurColor){
        _blurColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _blurColor;
}

@end

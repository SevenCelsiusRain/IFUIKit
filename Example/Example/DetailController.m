//
//  DetailController.m
//  Example
//
//  Created by MrGLZh on 2022/3/10.
//

#import <IFUIKit.h>
#import "DetailController.h"

@interface DetailController ()

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UIButton *test2Button;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}


#pragma mark - private methods
- (void)setupViews {
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat xAxis = (UIScreen.mainScreen.bounds.size.width - 200)/2.0;
    self.testButton.frame = CGRectMake(xAxis, 130, 200, 50);
    self.test2Button.frame = CGRectMake(xAxis, CGRectGetMaxY(self.testButton.frame) + 30, 200, 50);
    
    [self.view addSubview:self.testButton];
    [self.view addSubview:self.test2Button];
    
    self.contentView.frame = CGRectMake(0, 330, UIScreen.mainScreen.bounds.size.width, 400);
    [self.view addSubview:self.contentView];
}


- (void)buttonAction {
    
    // IFNotiToast 使用
    [self.view showNotiToastWithConfig:^(IFNotiToastConfig *config) {
        config.text = @"开始认为";
        config.image = [UIImage imageNamed:@"if_server_door"];
        config.subtitleText = @"测试使用";
        config.imageContentMode = UIViewContentModeScaleAspectFit;
        config.duration = 50;
//        config.toastType = CRToastTypeCustom;
        config.preferredHeight = 200;
//        config.customBackgroundView = self.contentView;
        CRToastInteractionResponder *tap = [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap automaticallyDismiss:YES block:^(CRToastInteractionType interactionType) {
            NSLog(@"");
        }];
        config.responder = @[tap];
    }];
    
    // MARK: IFToastView 使用
//    [IFToastView showWithText:@"开始认为" positionType:IFToastPositionTypeBottom];
    
//    IFToastView *toast = [[IFToastView alloc] initWithImage:[YYImage imageNamed:@"loggingIn"]];
//    IFToastView *toast = [[IFToastView alloc] initWithYYImage:[YYImage imageNamed:@"loggingIn"] text:@"开始加载，耐心等待"];
//    toast.maskColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
//    toast.contentColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
//    [toast showInCenter];
//    [toast showInView:self.contentView];
    
//    IFToastView *toast = [[IFToastView alloc] initWithText:@"开始认为"];
//    toast.textColor = UIColor.yellowColor;
//    [toast showInView:self.contentView];
    
    // MARK: hud 使用
    //    [self.view if_showTip:@"成功了" imageName:@"if_server_door" type:IFProgressHUDShowTypeSuccess];
}

#pragma mark - event handler
- (void)testButtonAction {
    switch (self.type) {
        case DetailTypeToast:
            [self toastInController];
            break;
            
        case DetailTypeHUD:
            [self hudInController];
            break;
            
        case DetailTypeAlert:
            [self showAlert];
            break;
            
        case DetailTypeEmpty:
            [self emptyInController];
            break;
            
        default:
            break;
    }
}

- (void)test2ButtonAction {
    switch (self.type) {
        case DetailTypeToast:
            [self toastInView];
            break;
            
        case DetailTypeHUD:
            [self hudInView];
            break;
            
        case DetailTypeAlert:
            [self showAlert];
            break;
            
        case DetailTypeEmpty:
            [self emptyInView];
            break;
            
        default:
            break;
    }
}


#pragma mark - usage method

// MARK: toast
- (void)toastInController {
    
    // IFToastView
//    [IFToastView showWithImage:[UIImage imageNamed:@"if_server_door"] text:@"测试使用"];
//    [IFToastView showWithText:@"测试使用" positionType:IFToastPositionTypeTop];
    
//    IFToastView *toast = [[IFToastView alloc] initWithImage:[YYImage imageNamed:@"loggingIn"]];
//    [toast showInCenter];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [toast dismissToast];
//    });
    
    
    // IFNotiToast
    [self.view showNotiToastWithConfig:^(IFNotiToastConfig *config) {
        config.text = @"测试使用";
        config.backgroundColor = UIColor.yellowColor;
    }];
    
}

- (void)toastInView {
    
    // IFToastView
//    IFToastView *toast = [[IFToastView alloc] initWithText:@"测试使用"];
//    [toast showInView:self.contentView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [toast dismissToast];
//    });
    
    IFToastView *toast = [[IFToastView alloc] initWithImage:[YYImage imageNamed:@"loggingIn"]];
    [toast showInView:self.contentView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissToast];
    });
    
}


// MARK: hud
- (void)hudInController {
//    [self if_showLoadingView:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [self if_hideLoadingView];
//    });
    
//    [self if_showSuccessTip:@"成功"];
//    [self if_showFailTip:@"失败"];
    [self if_showTextTip:@"提示"];
}

- (void)hudInView {
        [self.contentView if_showLoadingView:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.contentView if_hideLoadingView];
        });
        
//        [self.contentView if_showSuccessTip:@"成功"];
//        [self.contentView if_showFailTip:@"失败"];
//        [self.contentView if_showTextTip:@"提示"];
}


// MARK: alert

- (void)showAlert {
    IFAlertController *alertVC = [[IFAlertController alloc] initWithView:self.contentView radius:8 direction:IFAlertDirectionTypeBottom];
    alertVC.contentViewSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 400);
    // 点击空白处消失
//    alertVC.tapDismiss = NO;
    [self presentViewController:alertVC animated:NO completion:nil];
}


// MARK: empty
- (void)emptyInController {
    
    [self.view if_showEmptyView:^(IFEmptyView *emptyView) {
        [emptyView setContentWithType:IFEmptyViewTypeNetless infoText:nil];
        emptyView.backgroundColor = UIColor.grayColor;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.view if_hideEmptyView];
    });
    
}

- (void)emptyInView {
    
    [self.contentView if_showEmptyView:^(IFEmptyView *emptyView) {
        emptyView.backgroundColor = UIColor.grayColor;
        emptyView.topPadding = 20;
        [emptyView setContentWithType:IFEmptyViewTypeNetless infoText:nil];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.contentView if_hideEmptyView];
    });
}




#pragma mark - getter & setter

- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setTitle:@"显示在 Contoller" forState:UIControlStateNormal];
        _testButton.backgroundColor = UIColor.lightGrayColor;
        [_testButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}

- (UIButton *)test2Button {
    if (!_test2Button) {
        _test2Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_test2Button setTitle:@"显示在 View" forState:UIControlStateNormal];
        _test2Button.backgroundColor = UIColor.lightGrayColor;
        [_test2Button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_test2Button addTarget:self action:@selector(test2ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _test2Button;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.redColor;
    }
    return _contentView;
}

- (void)setType:(DetailType)type {
    _type = type;
    switch (type) {
        case DetailTypeToast:
            self.title = @"toast 提示";
            break;
            
        case DetailTypeHUD:
            self.title = @"HUD";
            break;

        case DetailTypeAlert:
            self.title = @"alert";
            break;
            
        case DetailTypeEmpty:
            self.title = @"empty 空视图";
            break;
            
        default:
            break;
    }
}

@end

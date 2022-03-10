//
//  ViewController.m
//  Example
//
//  Created by MrGLZh on 2022/3/7.
//

#import <IFUIKit.h>
#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = UIColor.lightGrayColor;
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.contentView.frame = CGRectMake(0, 260, UIScreen.mainScreen.bounds.size.width, 400);
//    [self.view addSubview:self.contentView];
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

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.redColor;
    }
    return _contentView;
}


@end

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
    [self.view addSubview:self.contentView];
}

- (void)buttonAction {
//    [[[IFToastView alloc] init] showToastWithText:@"开始测试"];
    
//    [self.view showNotiToastWithText:@"开始测试"];
//    [self.view showNotiToastWithText:@"开始测试" image:[UIImage imageNamed:@"if_server_bgImg"]];
//    [IFToastView showTopWithText:@"开始认为是对的"];
//    [IFToastView showWithImage:[UIImage imageNamed:@"if_server_bgImg"] text:@"开始认为是对的"];
    IFToastView *toast = [[IFToastView alloc] initWithText:@"开始认为"];
    [toast showInView:self.contentView];
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.redColor;
    }
    return _contentView;
}


@end

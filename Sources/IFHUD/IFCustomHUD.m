//
//  IFCustomHUD.m
//  IFHUD
//
//  Created by MrGLZh on 2022/10/24.
//

#import "IFCustomHUD.h"
#import <Lottie/Lottie.h>

@interface IFCustomHUD ()
@property (nonatomic,strong) LOTAnimationView*calculateView;
@end

@implementation IFCustomHUD

+ (instancetype)customHud {
    IFCustomHUD *hud = [[IFCustomHUD alloc] init];
    [hud setupViews];
    
    return hud;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.calculateView.frame = self.bounds;
}

- (void)play {
    [self.calculateView play];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(120.f, 40.f);
}

#pragma mark - private func

- (void)setupViews {
    [self addSubview:self.calculateView];
}

#pragma mark - getter

- (LOTAnimationView *)calculateView {
    if (!_calculateView) {
        _calculateView = [[LOTAnimationView alloc] init];
        _calculateView.frame = CGRectMake(0, 0, 120, 40);
        [_calculateView setContentMode:UIViewContentModeScaleAspectFit];
        [_calculateView setLoopAnimation:YES];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"IFHUD"
                                                               ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        [_calculateView setAnimationNamed:@"data" inBundle:bundle];
    }
    return _calculateView;
}

@end

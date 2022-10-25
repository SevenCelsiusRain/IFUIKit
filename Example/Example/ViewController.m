//
//  ViewController.m
//  Example
//
//  Created by MrGLZh on 2022/3/7.
//


#import "ViewController.h"
#import "DetailController.h"
#import "SVProgressHUD.h"
#import <IFUIKit.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIImageView *activityImageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

#pragma mark - private methods
- (void)setupViews {
    self.title = @"IFUIKit Demo";
    [self.view addSubview:self.tableView];
    self.tableView.frame = UIScreen.mainScreen.bounds;
}


#pragma mark -delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSource.count - 1) {
//        [self.spinner start];
//        [self.view if_showLoadingView:nil];
//        [self.activityIndicator startAnimating];
//        [SVProgressHUD setForegroundColor:UIColor.blueColor];
//        [SVProgressHUD setBorderColor:UIColor.blackColor];
//        [SVProgressHUD setBackgroundColor:UIColor.whiteColor];
//        [SVProgressHUD setBackgroundLayerColor:UIColor.yellowColor];
//        [SVProgressHUD setBackgroundLayerColor:UIColor.greenColor];
//        [SVProgressHUD setRingThickness:10];
//        [SVProgressHUD setRingRadius:30];
//        [SVProgressHUD showWithStatus:@"Doing Stuff"];
        
        [self.activityImageV startAnimating];
        
        return;
    }
    
    DetailController *detailVC = [[DetailController alloc] init];
    detailVC.type = indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    return @[@"toast 提示", @"alert", @"hud", @"emptyview", @"loading"];
}

- (UIImageView *)activityImageV {
    if (!_activityImageV) {
        _activityImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 5+0)];
        _activityImageV.image = [UIImage imageNamed:@"if_common_loading"];
        
        CGPoint oldOrigin = self.activityImageV.frame.origin;
        // 围绕旋转的点
        self.activityImageV.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CGPoint newOrigin = self.activityImageV.frame.origin;
        CGPoint transition;
        transition.x = newOrigin.x - oldOrigin.x;
        transition.y = newOrigin.y - oldOrigin.y;
        self.activityImageV.center = CGPointMake (self.activityImageV.center.x - transition.x, self.activityImageV.center.y - transition.y);

        [_activityImageV.layer removeAllAnimations];
        CABasicAnimation *rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        // 旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        rotationAnimation.duration = 1;
        rotationAnimation.repeatCount = HUGE_VALF;
        // 动画结束时是否执行逆动画
    //    rotationAnimation.autoreverses = YES;
        [_activityImageV.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    return _activityImageV;
}

@end

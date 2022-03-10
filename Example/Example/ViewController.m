//
//  ViewController.m
//  Example
//
//  Created by MrGLZh on 2022/3/7.
//


#import "ViewController.h"
#import "DetailController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

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
    return @[@"toast 提示", @"alert", @"hud", @"emptyview"];
}

@end

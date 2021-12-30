//
//  IFBaseTableView.m
//  IFTableView
//
//  Created by MrGLZh on 2021/12/30.
//

#import "IFBaseTableView.h"
#import <MJRefresh/MJRefresh.h>

#ifndef if_weakify
    #define if_weakify(object) __weak typeof(object) weak##_##object = object;
#endif

#ifndef if_strongify
    #define if_strongify(object) typeof(object) object = weak##_##object;
#endif

//适配iphoneX系列 X XR XS XS_MAX
#define IF_IS_IPHONEX getIphoneType()
//判断是否为iphoneX系列,安全区域大于0
#define getIphoneType \
^(){ \
if(@available(iOS 11.0, *)) { \
UIWindow *window = [[[UIApplication sharedApplication] delegate] window]; \
if (window.safeAreaInsets.bottom > 0.0) { \
return YES; \
}else{ \
return NO; \
} \
}else{ \
return NO; \
} \
}


@interface IFBaseTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *pageArray;

@end

@implementation IFBaseTableView

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageNumber = 1;
        _pageSize = 20;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(self){
        _pageNumber = 1;
        _pageSize = 20;
        _isEmpty = NO;

        self.pageArray = [NSArray array];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark - public method
- (void)reloadDataWithSource:(NSArray *)source {
    self.pageArray = source;
    if (self.pageNumber == 1) {
        [self.dataArray removeAllObjects];
        if (source.count == 0) {
            self.isEmpty = YES;
        }
    }
    [self.dataArray addObjectsFromArray:source];
    if (source.count == 0) {
        [self.mj_footer setHidden:YES];
    }else{
        [self.mj_footer setHidden:NO];
    }
    [self reloadData];
    [self endRefreshing];
}

- (void)endRefreshing {
    //  结束头部刷新
    [self.mj_header endRefreshing];
    //  结束尾部刷新
    [self.mj_footer endRefreshing];
}


- (void)noMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterView{
    [self.mj_footer resetNoMoreData];
}

- (void)hideFooterView{
    [self.mj_footer setHidden:YES];
}


- (void)headerRequestWithData {
    //  空操作
}

- (void)footerRequestWithData {
    //  空操作
}

#pragma mark - delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


#pragma mark - getter & setter

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh {
    if (_isOpenHeaderRefresh != isOpenHeaderRefresh) {
        _isOpenHeaderRefresh = isOpenHeaderRefresh;
        if_weakify(self);
        if (isOpenHeaderRefresh) {
            if_strongify(self);
            //  设置头部刷新--MJ自带的
            self.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
                self.pageNumber = 1;
                [self headerRequestWithData];
            }];
        }
    }
}

- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh {
    if (_isOpenFooterRefresh != isOpenFooterRefresh) {
        _isOpenFooterRefresh = isOpenFooterRefresh;
        if_weakify(self);
        if (isOpenFooterRefresh) {
            if_strongify(self);
            //  设置脚部刷新
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if(self.pageArray.count > 0){
                    self.pageNumber += 1;
//                    self.pageSize += 20;
                    self.pageArray = nil;
                }
                [self footerRequestWithData];
            }];
            self.mj_footer.ignoredScrollViewContentInsetBottom = IF_IS_IPHONEX ?  0 : 34;
        }else{
            [self.mj_footer setHidden:YES];
        }
    }
}


@end

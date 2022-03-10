//
//  IFBaseTableView.h
//  IFTableView
//
//  Created by MrGLZh on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//! -- Version: 0.0.1.2 -- !//

@interface IFBaseTableView : UITableView

/*!页数索引*/
@property (nonatomic, assign) NSInteger pageNumber;
/*!每页显示多少条*/
@property (nonatomic, assign) NSInteger pageSize;
/*!是否还有显示的数据*/
@property (nonatomic, assign, readonly) BOOL isEndForLoadmore;
/*!数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/*!列表*/
@property (nonatomic, strong, readonly) UITableView *tableView;

/*!是否开启头部刷新*/
@property (nonatomic, assign)   BOOL isOpenHeaderRefresh;
/*!是否开启尾部刷新*/
@property (nonatomic, assign)   BOOL isOpenFooterRefresh;

/*!未定*/
//@property (nonatomic, copy)    void (^requestBlock)(void);

@property (nonatomic,assign) BOOL isEmpty;

/**
 根据tableview样式创建tableview
 @param style 样式
 @return UITableView实例
 */

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

/**
 刷新
 @param source 数据
 */
- (void)reloadDataWithSource:(NSArray *)source;

/**
 结束刷新
 */
- (void)endRefreshing;

/**
 头部刷新请求（子类需要重写）
 */
- (void)headerRequestWithData;

/**
 底部刷新请求（子类需要重写）
 */
- (void)footerRequestWithData;

/**
 * 没有更多数据
 */
- (void)noMoreData;

/**
 重置底部刷新
 */
- (void)resetFooterView;

/**
隐藏底部footer
*/
- (void)hideFooterView;



@end

NS_ASSUME_NONNULL_END

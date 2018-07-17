//
//  NewsController.m
//  STNews
//
//  Created by readygo on 2018/1/5.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "NewsController.h"
#import "NewsTableController.h"
#import "STTitleLablel.h"

@interface NewsController ()<UIScrollViewDelegate>
/** 新闻接口的数组 */
@property (nonatomic, strong) NSArray *arrayLists;
/** 标题栏 */
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
/** 下面的内容栏 */
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

/** 每个子控制器 */
@property (nonatomic, strong) NewsTableController *needScrollToTopPage;

@end

@implementation NewsController

- (NSArray *)arrayLists {
    if (!_arrayLists) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"]];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //设置导航栏
    [self setNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部标签栏
    [self setupTitleView];
    
    //设置底部ScrollView
    [self setupContentView];
}

#pragma mark - 初始化视图
/** 设置底部ScrollView */
- (void)setupContentView {
   
    self.bigScrollView.delegate = self;
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    
    STTitleLablel *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
}

/** 设置顶部标签栏 */
- (void)setupTitleView {
    
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;

    for (int i = 0; i < self.arrayLists.count; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        STTitleLablel *lbl1 = [[STTitleLablel alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont systemFontOfSize:19];
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
    
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    STTitleLablel *titlelable = (STTitleLablel *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    [self setScrollToTopWithTableViewIndex:titlelable.tag];
}

/** 初始化子控制器 */
- (void)setupChildVces {
    
    for (int i = 0; i < self.arrayLists.count; i ++) {
        NewsTableController *newVC = [[UIStoryboard storyboardWithName:@"NewsTableController" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        newVC.title = self.arrayLists[i][@"title"];
        newVC.urlString = self.arrayLists[i][@"urlString"];
        [self addChildViewController:newVC];
    }
}

#pragma mark - ScrollToTop

- (void)setScrollToTopWithTableViewIndex:(NSInteger)index
{
    self.needScrollToTopPage.tableView.scrollsToTop = NO;
    self.needScrollToTopPage = self.childViewControllers[index];
    self.needScrollToTopPage.tableView.scrollsToTop = YES;
}

#pragma mark - scrollView代理方法
/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    // 滚动标题栏
    STTitleLablel *titleLable = (STTitleLablel *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    NewsTableController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            STTitleLablel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    [self setScrollToTopWithTableViewIndex:index];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    STTitleLablel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        STTitleLablel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }

}

#pragma mark - 导航栏
/** 设置导航栏 */
- (void)setNav {
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11111"]];

    //设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" highImage:@"search_icon" target:self action:@selector(leftItemClick)];
    //设置导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"top_navigation_square" highImage:@"top_navigation_square" target:self action:@selector(rightItemClick)];
}

- (void)leftItemClick {
    STLogFunc;
}

- (void)rightItemClick {
    STLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

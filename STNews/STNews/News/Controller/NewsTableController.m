//
//  NewsTableController.m
//  STNews
//
//  Created by readygo on 2018/1/6.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "NewsTableController.h"
#import "HttpTool.h"
#import "STNewsEntity.h"
#import "STNewsCell.h"

@interface NewsTableController ()

/** 新闻数据 */
@property (nonatomic, strong) NSMutableArray *news;
@property (strong, nonatomic) IBOutlet UITableView *mytableView;

@end

@implementation NewsTableController

- (NSMutableArray *)news {
    
    if (!_news) {
        _news = [NSMutableArray array];
    }
    return _news;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];
    //添加新控件
    [self setupRefresh];
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动更新透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (void)loadNewTopics {
    
    [self.tableView.mj_footer endRefreshing];

    NSString *path = [NSString stringWithFormat:@"/nc/article/%@/0-20.html", self.urlString];
    // http://c.m.163.com//nc/article/list/list/T1348649145984/0-20.html
    [HttpTool getWithPath:path params:nil success:^(NSDictionary *json) {
        NSString *key = [json.keyEnumerator nextObject];
        NSArray *temArray = json[key];
        self.news = [STNewsEntity mj_objectArrayWithKeyValuesArray:temArray];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics {
    
    NSString *path = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(long)(self.news.count - self.news.count%10)];
    
    [HttpTool getWithPath:path params:nil success:^(NSDictionary *json) {
        NSString *key = [json.keyEnumerator nextObject];
        NSArray *temArray = json[key];
        
        NSArray *news = [STNewsEntity mj_objectArrayWithKeyValuesArray:temArray];
        [self.news addObjectsFromArray:news];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.news.count == 0);
    return self.news.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    STNewsEntity *newsModel = self.news[indexPath.row];
    NSString *ID = [STNewsCell idForRow:newsModel];
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        ID = @"NewsCell";
    }
    STNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.NewsModel = newsModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STNewsEntity *newsModel = self.news[indexPath.row];
    CGFloat rowHeight = [STNewsCell heightForRow:newsModel];
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        rowHeight = 80;
    }
    return rowHeight;
}

@end

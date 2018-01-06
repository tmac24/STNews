//
//  NewsTableController.h
//  STNews
//
//  Created by readygo on 2018/1/6.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableController : UITableViewController

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSInteger index;


@end

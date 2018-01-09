//
//  STNewsCell.h
//  STNews
//
//  Created by readygo on 2018/1/8.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STNewsEntity.h"

@interface STNewsCell : UITableViewCell

/** 新闻模型 */
@property (nonatomic, strong) STNewsEntity *NewsModel;

/** 类方法返回可重用的id */
+ (NSString *)idForRow:(STNewsEntity *)NewsModel;

/** 类方法返回行高 */
+ (CGFloat)heightForRow:(STNewsEntity *)NewsModel;

@end

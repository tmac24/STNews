//
//  STNewsViewModel.h
//  STNews
//
//  Created by readygo on 2018/1/6.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNewsViewModel : NSObject
/**
 *  获取新闻概要模型
 */
@property(nonatomic,strong)RACCommand *fetchNewsEntityCommand;
@end

//
//  STNewsEntity.m
//  STNews
//
//  Created by readygo on 2018/1/6.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "STNewsEntity.h"

@implementation STNewsEntity
+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    STNewsEntity *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
@end

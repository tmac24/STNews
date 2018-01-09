//
//  STHTTPManager.m
//  STNews
//
//  Created by readygo on 2018/1/6.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "STHTTPManager.h"

@implementation STHTTPManager

+ (instancetype)manager
{
    STHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;

    [mgrSet addObject:@"text/html"];

    mgr.responseSerializer.acceptableContentTypes = mgrSet;

    return mgr;
}
@end

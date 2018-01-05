//
//  NewsController.m
//  STNews
//
//  Created by readygo on 2018/1/5.
//  Copyright © 2018年 suntao. All rights reserved.
//

#import "NewsController.h"

@interface NewsController ()

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   //设置导航栏
    [self setNav];
}

- (void)setNav {
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoview_image_default_white"]];

    //设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" highImage:@"search_icon" target:self action:@selector(leftItemClick)];
}

- (void)leftItemClick {
    STLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

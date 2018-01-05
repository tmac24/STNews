//
//  STTabBarController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/14.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STTabBarController.h"
#import "STNavigationController.h"
//#import "STTabBar.h"
#import "NewsController.h"
#import "ReadController.h"
#import "ListenController.h"
#import "FindController.h"
#import "MineController.h"

@interface STTabBarController ()

@end

@implementation STTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:183/255.0 green:20/255.0 blue:28/255.0 alpha:1];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[NewsController alloc] init] title:@"新闻" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];

    [self setupChildVc:[[ReadController alloc] init] title:@"阅读" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];

    [self setupChildVc:[[ListenController alloc] init] title:@"视听" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];

    [self setupChildVc:[[FindController alloc] init] title:@"发现" image:@"tabbar_icon_found_normal" selectedImage:@"tabbar_icon_found_highlight"];
    
    [self setupChildVc:[[MineController alloc] init] title:@"我的" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_highlight"];

    // 更换tabBar
//    [self setValue:[[STTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    STNavigationController *nav = [[STNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end

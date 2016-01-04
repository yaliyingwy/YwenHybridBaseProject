//
//  HelloViewController.m
//  HybridIos
//
//  Created by ywen on 15/12/30.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import "HelloViewController.h"

#import "HelloDemoViewController.h"
#import "HelloItemListViewController.h"
#import "HelloLoginViewController.h"

@interface HelloViewController ()

@end

@implementation HelloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //登录
    HelloLoginViewController *loginVC = [HelloLoginViewController new];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:100];
    [loginNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor WY_ColorWithHex:0x28b3ec]} forState:UIControlStateHighlighted];
    
    //列表
    HelloItemListViewController *listVC = [HelloItemListViewController new];
    UINavigationController *listNav = [[UINavigationController alloc] initWithRootViewController:listVC];
    listNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:100];
    [listNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor WY_ColorWithHex:0x28b3ec]} forState:UIControlStateHighlighted];
    
    self.viewControllers = @[loginNav, listNav];
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

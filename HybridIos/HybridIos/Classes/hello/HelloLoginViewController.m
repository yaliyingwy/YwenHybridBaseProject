//
//  HelloLoginViewController.m
//  HybridIos
//
//  Created by ywen on 15/12/30.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import "HelloLoginViewController.h"
#import "HelloDemoViewController.h"

@interface HelloLoginViewController ()

@end

@implementation HelloLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startPage = @"hello-login.html";
}

-(void)pushVC:(NSString *)vc params:(NSDictionary *)params {
    if ([vc isEqualToString:@"/hello-demo.html"]) {
        [self.navigationController pushViewController:[HelloDemoViewController new] animated:YES];
    }
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

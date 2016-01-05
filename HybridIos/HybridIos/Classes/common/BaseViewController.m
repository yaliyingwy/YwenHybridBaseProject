//
//  BaseViewController.m
//  HybridIos
//
//  Created by ywen on 15/12/29.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [self callJS:@{@"msg": @"VIEW_APPEAR"}];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hybridNav = self;
    self.hybridUI = self;
}

-(void)setStartPage:(NSString *)startPage {
    self.htmlPath = [[HotUpdateManager wwwPath] stringByAppendingPathComponent:startPage];
    NSString *js = [NSString stringWithFormat:@"(function(){window.uuid='%@';window.version='%@';window.client_type='%@'})()", [Global sharedInstance].uuid, [Global sharedInstance].version, CLIENT_TYPE];
    [self.webView stringByEvaluatingJavaScriptFromString: js];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 实现代理
-(void)navPop:(NSInteger)index {
    NSInteger vcCount = self.navigationController.viewControllers.count;
    if (index == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (index < vcCount) {
        UIViewController *toVC = self.navigationController.viewControllers[vcCount - 1 - index];
        [self.navigationController popToViewController:toVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void) navPush:(NSDictionary *)params callback:(NSString *)callback {
    NSString *page = [params objectForKey:@"page"];
    [self pushVC:page params:params];
    [self success:callback params:nil];
}

-(void)loading:(NSDictionary *)params {
    NSString *type = [params objectForKey:@"type"];
    NSString *msg = [params objectForKey:@"msg"];
    BOOL force = [[params objectForKey:@"force"] boolValue];
    
    if ([type isEqualToString:@"hide"]) {
        [Loading hide];
    }
    else
    {
        [Loading setTimeout:10];
        [Loading show:msg isForce:force];
        
    }
}

-(void) alert:(NSDictionary *)params callback:(NSString *)callback {
    NSString *title = [params objectForKey:@"title"];
    NSString *msg = [params objectForKey:@"msg"];
    NSArray *btns = [params objectForKey:@"btns"];
    
    [YwenAlert setTitle:title];
    
    __block __weak BaseViewController *weakSelf = self;
    
    [YwenAlert alert:msg vc:self confirmStr:btns[0] confirmCb:^{
        [weakSelf success:callback params:@{}];
    } cancelStr:btns.count > 1 ? btns[1] : @"取消" cancelCb:^{
        [weakSelf error:callback error:@"用户取消操作"];
    }];
}

-(void) toast:(NSDictionary *)params {
    NSString *type = [params objectForKey:@"type"];
    NSString *msg = [params objectForKey:@"msg"];
    NSTimeInterval time = 1.5;
    if ([params objectForKey:@"showTime"] != nil) {
        time = [[params objectForKey:@"showTime"] doubleValue];
    }
    
    if ([type isEqualToString:@"show"]) {
        NSInteger position;
        if ([[params objectForKey:@"position"] isEqualToString:@"center"]) {
            position = 0;
        }
        else
        {
            position = 1;
        }
        
        
        
        [Toast showToastWithContent:msg showTime:time postion:position];
    }
    else if ([type isEqualToString:@"success"])
    {
        [Toast showSuccess:msg];
    }
    else if ([type isEqualToString:@"error"])
    {
        [Toast showErr:msg];
    }
}

#pragma mark－ 推界面
-(void)pushVC:(NSString *)vc params:(NSDictionary *)params {
    
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

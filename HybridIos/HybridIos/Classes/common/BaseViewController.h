//
//  BaseViewController.h
//  HybridIos
//
//  Created by ywen on 15/12/29.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import "YwenViewController.h"
#import "Global.h"
#import <HotUpdateManager.h>

@interface BaseViewController : YwenViewController<HybridNavDelegate, HybridUIDelegate>

@property (strong, nonatomic) NSString *startPage;

-(void) pushVC:(NSString *) vc params:(NSDictionary *) params;

@end

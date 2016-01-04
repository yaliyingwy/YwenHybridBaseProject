//
//  Global.h
//  HybridIos
//
//  Created by ywen on 15/12/29.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YwenKit.h>
#import <MobClick.h>
#import <CocoaLumberjack.h>
#import <TAKUUID.h>
#import <YwenNetworkit.h>

#define CLIENT_TYPE @"2"  //客户端类型
//效果图与实际屏幕比例
#define REALSCREEN_MULTIPBY  (SCREEN_WIDTH / 320)

#define UMENG_KEY @"1"

@interface Global : NSObject

@property (strong, nonatomic) NSString *uuid;   //uuid
@property (strong, nonatomic) NSString *version;   //版本号

@property (strong, nonatomic) YwenNetworkit *net; //网络请求

+(Global *) sharedInstance;

+(void)setUpUmeng;

+(void) setUpLogger;

+(void) checkUpdate;

@end

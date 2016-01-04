//
//  Global.m
//  HybridIos
//
//  Created by ywen on 15/12/29.
//  Copyright © 2015年 ywen. All rights reserved.
//

#import "Global.h"

@implementation Global

+(Global *)sharedInstance {
    static Global *global = nil;
    @synchronized(self) {
        if (global == nil) {
            global = [[self alloc] init];
            global.uuid = [[TAKUUIDStorage sharedInstance] findOrCreate];
            
            NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
            global.version =[infoDict objectForKey:@"CFBundleShortVersionString"];
            
            global.net = [YwenNetworkit new];
            
        }
    }
    return global;
}

+(void)checkUpdate {
    //TODO: 让后台给个接口吧
    //数据如{manVersion: '0.0.1', hotVersion: '1', file: 'http://xxx.zip'}
}

+(void)setUpUmeng {
    //MARK: 友盟统计
    NSAssert([UMENG_KEY length] > 0, @"请替换你自己的友盟key!");
    [MobClick startWithAppkey:UMENG_KEY reportPolicy:BATCH channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

+(void)setUpLogger {
#ifdef DEBUG
    static const DDLogLevel level = DDLogLevelVerbose;
    
    [DDLog addLogger:[DDASLLogger sharedInstance] withLevel:level];

#else
    static const DDLogLevel level = DDLogLevelOff;
#endif
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:level];
}

@end

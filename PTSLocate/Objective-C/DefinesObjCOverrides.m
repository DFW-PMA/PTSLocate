//
//  DefinesObjCOverrides.m
//  PTSLocate
//
//  Created by JustMacApps.net on 07/29/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DefinesObjCOverrides.h"

@implementation DefinesObjCOverrides
{

    JmObjCSwiftEnvBridge *_jmObjCSwiftEnvBridge;

}

- (void)initInstance
{

    NSLog(@"--- DefinesObjCOverrides.initInstance() - Invoked...");

    _jmObjCSwiftEnvBridge = JmObjCSwiftEnvBridge.sharedEnvBridge;

    NSLog(@"--- DefinesObjCOverrides.initInstance() - Exiting...");

}

- (void)customLoggerTest1:(NSString * _Nullable)message
{

    NSLog(@"--- DefinesObjCOverrides.customLoggerTest1() - Invoked ---");
    
    if (_jmObjCSwiftEnvBridge) {
        [_jmObjCSwiftEnvBridge jmLogMsg:message];
        NSLog(@"--- DefinesObjCOverrides.customLoggerTest1() - Intermediate - parameter 'message' is [%@] ---", message);
    } else {
        NSLog(@"--- DefinesObjCOverrides.customLoggerTest1() - Test - '_jmObjCSwiftEnvBridge' is NULL - Error! ---");
    }

    NSLog(@"--- DefinesObjCOverrides.customLoggerTest1() - Exiting ---");

}

@end


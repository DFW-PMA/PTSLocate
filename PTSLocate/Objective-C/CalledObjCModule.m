//
//  CalledObjCModule.m
//  PTSLocate
//
//  Created by JustMacApps.net on 07/29/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DefinesObjCOverrides.h"

#import "CalledObjCModule.h"

@implementation CalledObjCModule
{

    JmObjCSwiftEnvBridge *_jmObjCSwiftEnvBridge;

    NSString *_internalVariable;

}

- (void)initInstance
{

    NSLog(@"--- CalledObjCModule.initInstance() - Invoked...");

    _jmObjCSwiftEnvBridge = JmObjCSwiftEnvBridge.sharedEnvBridge;

    NSLog(@"--- CalledObjCModule.initInstance() - Exiting - '_jmObjCSwiftEnvBridge' is [%@] ---", _jmObjCSwiftEnvBridge);

}

- (NSString * _Nullable)getInternalVariable
{

    _internalVariable = @"This is the 'internal' variable...";

    NSLog(@"--- CalledObjCModule.getInternalVariable() - Invoked - '_internalVariable' is [%@] ---", _internalVariable);
    NSLog(@"--- CalledObjCModule.getInternalVariable() - Exiting ---");

    return _internalVariable;

}

- (void)sayHello:(NSString * _Nullable)message
{

    NSLog(@"--- CalledObjCModule.sayHello() - Invoked - Parameter 'message': %@", message);
    
    if (_jmObjCSwiftEnvBridge) {
        NSLog(@"--- CalledObjCModule.sayHello() - Test - '_jmObjCSwiftEnvBridge' is NOT Null - is [%@] ---", _jmObjCSwiftEnvBridge);
        [_jmObjCSwiftEnvBridge jmLogMsg:message];
    } else {
        NSLog(@"--- CalledObjCModule.sayHello() - Test - '_jmObjCSwiftEnvBridge' is Null - Error! ---");
    }

    NSLog(@"--- CalledObjCModule.sayHello() - Exiting ---");

}

@end

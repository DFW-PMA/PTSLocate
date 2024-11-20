//
//  DefinesObjCOverrides.h
//  PTSLocate
//
//  Created by JustMacApps.net on 07/29/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JmObjCSwiftEnvBridge-Bridging-Header.h"

@interface DefinesObjCOverrides : NSObject
- (void)initInstance;
- (void)customLoggerTest1:(NSString * _Nullable)message;
@end

#define NSLog(...) CustomLoggerTest3(__VA_ARGS__);

static void CustomLoggerTest3(NSString * _Nonnull format, ...)
{
    
    va_list argumentList;
    
    va_start(argumentList, format);
    
    NSMutableString *message = [[NSMutableString alloc] initWithFormat:format arguments:argumentList];
    
    [JmObjCSwiftEnvBridge.sharedEnvBridge jmLogMsg:message];

    //  NSLogv(message, argumentList);

    va_end(argumentList);
    
}


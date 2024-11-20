//
//  CalledObjCModule.h
//  PTSLocate
//
//  Created by JustMacApps.net on 07/29/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalledObjCModule : NSObject
- (void)initInstance;
- (NSString * _Nullable)getInternalVariable;
- (void)sayHello:(NSString * _Nullable)message;
@end

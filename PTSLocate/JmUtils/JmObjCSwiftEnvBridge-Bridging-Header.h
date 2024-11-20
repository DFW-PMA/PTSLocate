//
//  JmObjCSwiftEnvBridge-Bridging-Header.h
//

#import <Foundation/Foundation.h>
#import <SwiftUI/SwiftUI.h>

// ObjC uses 'id' as Swift's 'Any'...

@interface JmObjCSwiftEnvBridge: NSObject
+ (instancetype _Nonnull)sharedEnvBridge;
- (void)jmLogMsg:(NSString * _Nullable)message;
@end


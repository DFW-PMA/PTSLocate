//
//  JmUserDefaults-Bridging-Header.h
//

#import <Foundation/Foundation.h>
#import <SwiftUI/SwiftUI.h>

// ObjC uses 'id' as Swift's 'Any'...

@interface JmUserDefaults: NSObject
- (id _Nullable)getObjCObjectForKey:(NSString * _Nonnull)forKey;
- (void)setObjCObjectForKey:(id _Nullable)keyValue forKey:(NSString * _Nonnull)forKey;
@end

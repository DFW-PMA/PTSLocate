//
//  JmAppDelegateVisitor-Bridging-Header.h
//

#import <Foundation/Foundation.h>
#import <SwiftUI/SwiftUI.h>

// ObjC uses 'id' as Swift's 'Any'...

@interface JmAppDelegateVisitor: NSObject

- (void)setAppDelegateVisitorSignalSwiftViewsShouldChange;
- (void)resetAppDelegateVisitorSignalSwiftViewsShouldChange;
- (void)setAppDelegateVisitorSignalGlobalAlert:(NSString * _Nullable)alertMsg alertButtonText:(NSString * _Nullable)alertButtonText;
- (void)resetAppDelegateVisitorSignalGlobalAlert;

- (void)appDelegateVisitorSendEmailUpload:(NSString * _Nonnull)emailAddressTo emailAddressCc:(NSString * _Nonnull)emailAddressCc emailSourceFilespec:(NSString * _Nonnull)emailSourceFilespec emailSourceFilename:(NSString * _Nonnull)emailSourceFilename emailZipFilename:(NSString * _Nonnull)emailZipFilename emailSaveAsFilename:(NSString * _Nonnull)emailSaveAsFilename emailFileMimeType:(NSString * _Nonnull)emailFileMimeType emailFileData:(NSData * _Nonnull)emailFileData;
- (void)appDelegateVisitorSendSilentUpload:(NSString * _Nonnull)emailAddressTo emailAddressCc:(NSString * _Nonnull)emailAddressCc emailSourceFilespec:(NSString * _Nonnull)emailSourceFilespec emailSourceFilename:(NSString * _Nonnull)emailSourceFilename emailZipFilename:(NSString * _Nonnull)emailZipFilename emailSaveAsFilename:(NSString * _Nonnull)emailSaveAsFilename emailFileMimeType:(NSString * _Nonnull)emailFileMimeType emailFileData:(NSData * _Nonnull)emailFileData;

- (BOOL)appDelegateVisitorWillFinishLaunchingWithOptions:(UIApplication * _Nonnull)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions;
- (BOOL)appDelegateVisitorDidFinishLaunchingWithOptions:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions;
- (BOOL)appDelegateVisitorWillFinishLaunchingWithOptions:(UIApplication * _Nonnull)application;
- (BOOL)appDelegateVisitorDidFinishLaunchingWithOptions:(UIApplication * _Nonnull)application;
- (void)appDelegateVisitorWillTerminate:(UIApplication * _Nonnull)application;

@end


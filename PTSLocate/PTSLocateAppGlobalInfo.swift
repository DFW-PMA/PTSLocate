//
//  PTSLocateAppGlobalInfo.swift
//  PTSLocate
//
//  Created by Daryl Cox on 07/25/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

#if os(macOS)
import IOKit
#endif

public class AppGlobalInfo: NSObject
{
    
    struct ClassSingleton
    {

        static 
        var appGlobalInfo:AppGlobalInfo                                  = AppGlobalInfo()

    }

    static let sGlobalInfoAppId:String                                   = "PTSLocate"
    static let sGlobalInfoAppVers:String                                 = "v1.1902"
    static let sGlobalInfoAppDisp:String                                 = sGlobalInfoAppId+".("+sGlobalInfoAppVers+"): "
    static let sGlobalInfoAppCopyRight:String                            = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
    static let sGlobalInfoAppLogFilespec:String                          = "PTSLocate.log"
    static let sGlobalInfoAppLastGoodLogFilespec:String                  = "PTSLocate.last_good.log"
    static let sGlobalInfoAppLastCrashLogFilespec:String                 = "PTSLocate.crashed_last.log"
    static let sGlobalInfoAppCrashMarkerFilespec:String                  = "PTSLocate.crash_marker.txt"

    static let bUseApplicationShortTitle:Bool                            = true
    static let sApplicationTitle:String                                  = sGlobalInfoAppId
    static let sApplicationShortTitle:String                             = "PTSLocate"

#if os(macOS)

    static let sHelpBasicFileExt:String                                  = "html"     // 'help' File extension: "md", "html", or "txt"

#elseif os(iOS)

    static let sHelpBasicFileExt:String                                  = "md"       // 'help' File extension: "md", "html", or "txt"

#endif
    
    static let bPerformAppObjCSwiftBridgeTest:Bool                       = true
    static let bInstantiateAppMetricKitManager:Bool                      = true
    static let bInstantiateAppUserNotificationsManager:Bool              = true
    static let bIssueTestAppUserNotifications:Bool                       = false
    static let bInstantiateAppParseCoreManager:Bool                      = true
    static let bInstantiateAppCoreLocationSupport:Bool                   = true
    static let bPerformAppCoreLocationTesting:Bool                       = true
    static let bPerformAppDevTesting:Bool                                = true
    static let sAppUploadNotifyFrom:String                               = "dcox@justmacapps.net"

    // Various 'device' information:

           var sGlobalDeviceType:String                                  = "-unknown-"   // Values: "Mac", "iPad", "iPhone, "AppleWatch"
           var bGlobalDeviceIsMac:Bool                                   = false
           var bGlobalDeviceIsIPad:Bool                                  = false
           var bGlobalDeviceIsIPhone:Bool                                = false
           var bGlobalDeviceIsAppleWatch:Bool                            = false
           var bGlobalDeviceIsXcodeSimulator:Bool                        = false

           var sGlobalDeviceName:String                                  = "-unknown-"
           var sGlobalDeviceSystemName:String                            = "-unknown-"
           var sGlobalDeviceSystemVersion:String                         = "-unknown-"
           var sGlobalDeviceModel:String                                 = "-unknown-"
           var sGlobalDeviceLocalizedModel:String                        = "-unknown-"

       #if os(iOS)

           var idiomGlobalDeviceUserInterfaceIdiom:UIUserInterfaceIdiom? = nil
           var iGlobalDeviceUserInterfaceIdiom:Int                       = 0
           var uuidGlobalDeviceIdForVendor:UUID?                         = nil
           var fGlobalDeviceCurrentBatteryLevel:Float                    = 1.0

       #endif

           var fGlobalDeviceScreenSizeWidth:Float                        = 0.0
           var fGlobalDeviceScreenSizeHeight:Float                       = 0.0
           var iGlobalDeviceScreenSizeScale:Int                          = 0

    // Various 'app' information:

           var sAppCategory:String                                       = "-unknown-"
           var sAppDisplayName:String                                    = "-unknown-"
           var sAppBundleIdentifier:String                               = "-unknown-"
           var sAppVersionAndBuildNumber:String                          = "-unknown-"
           var sAppCopyright:String                                      = "-unknown-"

    // Private 'init()' to make this class a 'singleton':

    private override init()
    {

    #if os(macOS)

        sGlobalDeviceType             = "Mac"   // Values: "Mac", "iPad", "iPhone, "AppleWatch"
        bGlobalDeviceIsMac            = true
        bGlobalDeviceIsIPad           = false
        bGlobalDeviceIsIPhone         = false
        bGlobalDeviceIsAppleWatch     = false
        bGlobalDeviceIsXcodeSimulator = false

        let osVersion:OperatingSystemVersion 
                                      = ProcessInfo.processInfo.operatingSystemVersion 

        sGlobalDeviceName             = ProcessInfo.processInfo.hostName
        sGlobalDeviceSystemName       = "MacOS v\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
        sGlobalDeviceSystemVersion    = ProcessInfo.processInfo.operatingSystemVersionString
        sGlobalDeviceModel            = "-unknown-"
        sGlobalDeviceLocalizedModel   = "-unknown-"

        let ioServiceExpertDevice     = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        var sModelIdentifier:String?  = nil

        if let ioModelData:Data = IORegistryEntryCreateCFProperty(ioServiceExpertDevice, ("model" as CFString), kCFAllocatorDefault, 0).takeRetainedValue() as? Data
        {

            if let ioModelIdentifierCString = String(data:ioModelData, encoding:.utf8)?.cString(using:.utf8) 
            {

                sModelIdentifier = String(cString:ioModelIdentifierCString)

            }

        }

        IOObjectRelease(ioServiceExpertDevice)

        sGlobalDeviceModel            = sModelIdentifier ?? "-unknown-"
        sGlobalDeviceLocalizedModel   = sModelIdentifier ?? "-unknown-"

        if let screenSize = NSScreen.main?.frame as CGRect?
        {

            fGlobalDeviceScreenSizeWidth   = Float(screenSize.width)
            fGlobalDeviceScreenSizeHeight  = Float(screenSize.height)
            iGlobalDeviceScreenSizeScale   = 1

        }

    #elseif os(iOS)

        // Get various 'device' setting(s):
        // (Alternate test: if UIDevice.current.userInterfaceIdiom == .pad { ... } ).

        if UIDevice.current.localizedModel == "Mac" 
        {

            sGlobalDeviceType         = "Mac"
            bGlobalDeviceIsMac        = true

        } 
        else if UIDevice.current.localizedModel == "iPad" 
        {

            sGlobalDeviceType         = "iPad"
            bGlobalDeviceIsIPad       = true

        }
        else if UIDevice.current.localizedModel == "iPhone" 
        {

            sGlobalDeviceType         = "iPhone"
            bGlobalDeviceIsIPhone     = true

        }
        else if UIDevice.current.localizedModel == "AppleWatch" 
        {

            sGlobalDeviceType         = "AppleWatch"
            bGlobalDeviceIsAppleWatch = true

        }

        sGlobalDeviceName                   = UIDevice.current.name
        sGlobalDeviceSystemName             = UIDevice.current.systemName
        sGlobalDeviceSystemVersion          = UIDevice.current.systemVersion
        sGlobalDeviceModel                  = UIDevice.current.model
        sGlobalDeviceLocalizedModel         = UIDevice.current.localizedModel

        idiomGlobalDeviceUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        iGlobalDeviceUserInterfaceIdiom     = ((idiomGlobalDeviceUserInterfaceIdiom?.rawValue ?? 0) as Int)
        uuidGlobalDeviceIdForVendor         = UIDevice.current.identifierForVendor
        fGlobalDeviceCurrentBatteryLevel    = UIDevice.current.batteryLevel

        if let screenSize = UIScreen.main.bounds as CGRect?
        {

            fGlobalDeviceScreenSizeWidth    = Float(screenSize.width)
            fGlobalDeviceScreenSizeHeight   = Float(screenSize.height)
            iGlobalDeviceScreenSizeScale    = Int(UIScreen.main.scale)

        }

    #endif

    #if targetEnvironment(simulator)

        bGlobalDeviceIsXcodeSimulator = true

    #endif

        sAppCategory                  = JmXcodeBuildSettings.jmAppCategory   
        sAppDisplayName               = JmXcodeBuildSettings.jmAppDisplayName
        sAppBundleIdentifier          = JmXcodeBuildSettings.jmAppBundleIdentifier
        sAppVersionAndBuildNumber     = JmXcodeBuildSettings.jmAppVersionAndBuildNumber
        sAppCopyright                 = JmXcodeBuildSettings.jmAppCopyright      

    }   // END of private override init().

}


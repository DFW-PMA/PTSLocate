//
//  JmAppDelegateVisitor.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 08/24/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
//import SwiftData
import XCGLogger

#if os(iOS)
import UIKit
#endif

//@available(macOS 15, *)
@available(iOS 14.0, *)
@objc(JmAppDelegateVisitor)
public class JmAppDelegateVisitor: NSObject, ObservableObject
{

    struct ClassInfo
    {
        
        static let sClsId        = "JmAppDelegateVisitor"
        static let sClsVers      = "v1.2602"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    struct ClassSingleton
    {

        static 
        var appDelegateVisitor:JmAppDelegateVisitor                = JmAppDelegateVisitor()

    }

    // App 'name' field:

    let sApplicationName:String                                    = AppGlobalInfo.sGlobalInfoAppId

    // Various App field(s):

    var cAppDelegateVisitorInitCalls:Int                           = 0

    var bAppTitleSetupRequired:Bool                                = true
    let bUseApplicationShortTitle:Bool                             = AppGlobalInfo.bUseApplicationShortTitle
    var sApplicationTitle:String                                   = AppGlobalInfo.sApplicationTitle
    let sApplicationShortTitle:String                              = AppGlobalInfo.sApplicationShortTitle

                                                                     // 'help' File extension: "md", "html", or "txt":
    let sHelpBasicFileExt:String                                   = AppGlobalInfo.sHelpBasicFileExt
    var sHelpBasicContents:String                                  = "-N/A-"

    @AppStorage("helpBasicMode") 
    var helpBasicMode                                              = HelpBasicMode.simpletext

    var helpBasicLoader:HelpBasicLoader?                           = nil

    // Misc:

    let bClsTraceInternal:Bool                                     = true
    var bAppDelegateVisitorTraceLogInitRequired:Bool               = true
    var sInitAppDelegateVisitorTraceLogTag:String                  = "-unknown-"
    var bAppDelegateVisitorLogFilespecIsUsable:Bool                = false
    var urlAppDelegateVisitorLogFilespec:URL?                      = nil
    var urlAppDelegateVisitorLogFilepath:URL?                      = nil
    var sAppDelegateVisitorLogFilespec:String!                     = nil
    var sAppDelegateVisitorLogFilepath:String!                     = nil
    var xcgLogger:XCGLogger?                                       = XCGLogger.default
    
    // App <global> 'Authentication' control(s):

    public
    var isUserAuthenticationAvailable:Bool                         = false

    // App <global> 'Alert' control(s):

    @Published 
    var appDelegateVisitorSwiftViewsShouldChange:Bool              = false
    {

        didSet
        {

            objectWillChange.send()

        }

    }

    // App <global> 'Alert' control(s):

    @Published 
    var isAppDelegateVisitorShowingAlert:Bool                      = false
    {

        didSet
        {

            objectWillChange.send()

        }

    }

    var sAppDelegateVisitorGlobalAlertMessage:String?              = nil
    var sAppDelegateVisitorGlobalAlertButtonText:String?           = nil

    // App <global> 'Alert' control(s) with (optional) 'completion' closure:

    @Published 
    var isAppDelegateVisitorShowingCompletionAlert:Bool            = false
    {

        didSet
        {

            objectWillChange.send()

        }

    }

    var sAppDelegateVisitorCompletionAlertMessage:String?          = nil
    var sAppDelegateVisitorCompletionAlertButtonText:String?       = nil
    var appDelegateVisitorCompletionClosure:(()->())?              = nil

    // App <global> 'state' control(s):

    var bWasAppLogFilePresentAtStartup:Bool                        = false
    var bWasAppCrashFilePresentAtStartup:Bool                      = false
    var bAppDelegateVisitorCrashMarkerFilespecIsUsable:Bool        = false
    var bAppDelegateVisitorCrashMarkerFilespecIsCreated:Bool       = false
    var urlAppDelegateVisitorCrashMarkerFilespec:URL?              = nil
    var urlAppDelegateVisitorCrashMarkerFilepath:URL?              = nil
    var sAppDelegateVisitorCrashMarkerFilespec:String!             = nil
    var sAppDelegateVisitorCrashMarkerFilepath:String!             = nil
    var urlAppDelegateVisitorLogToSaveFilespec:URL?                = nil
    var sAppDelegateVisitorLogToSaveFilespec:String!               = nil

//  // Various App SwiftData field(s):
//  
//  var modelConfiguration:ModelConfiguration                      = ModelConfiguration(isStoredInMemoryOnly:false, allowsSave:true)
//  var modelContainer:ModelContainer?                             = nil
//  var modelContext:ModelContext?                                 = nil
//  var pfAdminsSwiftDataItems:[PFAdminsSwiftDataItem]             = []
//  @Published 
//  var cPFAdminsSwiftDataItems:Int                                = 0
//  @Published 
//  var bArePFAdminsSwiftDataItemsAvailable:Bool                   = false
    
    // App <possible> JmAppSwiftData Manager instance:

    var jmAppSwiftDataManager:JmAppSwiftDataManager?               = nil

    // Swift/ObjC Bridge:

    @objc 
    var jmObjCSwiftEnvBridge:JmObjCSwiftEnvBridge?                 = nil

    // App <possible> (Apple) MetricKitManager instance:

    var jmAppMetricKitManager:JmAppMetricKitManager?               = nil

    // App <possible> (Apple) UNUserNotificationCenter Manager instance:

    var jmAppUserNotificationManager:JmAppUserNotificationManager? = nil

    // App <possible> ParseCore (Client) framework Manager instance:

    var jmAppParseCoreManager:JmAppParseCoreManager?               = nil

    // App <possible> CoreLocation service instance:

    var jmAppCLModelObservable2:CoreLocationModelObservable2?      = nil

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

    var listPreXCGLoggerMessages:[String]                          = Array()

    @objc public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("sApplicationName': [\(self.sApplicationName)],")
        asToString.append("cAppDelegateVisitorInitCalls': (\(self.cAppDelegateVisitorInitCalls)),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("bAppTitleSetupRequired': [\(self.bAppTitleSetupRequired)],")
        asToString.append("bUseApplicationShortTitle': [\(self.bUseApplicationShortTitle)],")
        asToString.append("sApplicationTitle': [\(self.sApplicationTitle)],")
        asToString.append("sApplicationShortTitle': [\(self.sApplicationShortTitle)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("sHelpBasicFileExt': [\(self.sHelpBasicFileExt)],")
        asToString.append("sHelpBasicContents': [\(self.sHelpBasicContents)],")
        asToString.append("helpBasicMode': [\(self.helpBasicMode)],")
        asToString.append("helpBasicLoader': [\(String(describing: self.helpBasicLoader?.toString()))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("bClsTraceInternal': [\(self.bClsTraceInternal)],")
        asToString.append("bAppDelegateVisitorTraceLogInitRequired': [\(self.bAppDelegateVisitorTraceLogInitRequired)],")
        asToString.append("sInitAppDelegateVisitorTraceLogTag': [\(self.sInitAppDelegateVisitorTraceLogTag)],")
        asToString.append("bAppDelegateVisitorLogFilespecIsUsable': [\(String(describing: self.bAppDelegateVisitorLogFilespecIsUsable))],")
        asToString.append("urlAppDelegateVisitorLogFilespec': [\(String(describing: self.urlAppDelegateVisitorLogFilespec))],")
        asToString.append("urlAppDelegateVisitorLogFilepath': [\(String(describing: self.urlAppDelegateVisitorLogFilepath))],")
        asToString.append("sAppDelegateVisitorLogFilespec': [\(String(describing: self.sAppDelegateVisitorLogFilespec))],")
        asToString.append("sAppDelegateVisitorLogFilepath': [\(String(describing: self.sAppDelegateVisitorLogFilepath))],")
        asToString.append("xcgLogger': [\(String(describing: self.xcgLogger))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("appDelegateVisitorSwiftViewsShouldChange': [\(String(describing: self.appDelegateVisitorSwiftViewsShouldChange))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("isAppDelegateVisitorShowingAlert': [\(self.isAppDelegateVisitorShowingAlert)],")
        asToString.append("sAppDelegateVisitorGlobalAlertMessage': [\(String(describing: self.sAppDelegateVisitorGlobalAlertMessage))],")
        asToString.append("sAppDelegateVisitorGlobalAlertButtonText': [\(String(describing: self.sAppDelegateVisitorGlobalAlertButtonText))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("isAppDelegateVisitorShowingCompletionAlert': [\(self.isAppDelegateVisitorShowingCompletionAlert)],")
        asToString.append("sAppDelegateVisitorCompletionAlertMessage': [\(String(describing: self.sAppDelegateVisitorCompletionAlertMessage))],")
        asToString.append("sAppDelegateVisitorCompletionAlertButtonText': [\(String(describing: self.sAppDelegateVisitorCompletionAlertButtonText))],")
        asToString.append("appDelegateVisitorCompletionClosure': [\(String(describing: self.appDelegateVisitorCompletionClosure))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("bWasAppLogFilePresentAtStartup': [\(self.bWasAppLogFilePresentAtStartup)],")
        asToString.append("bWasAppCrashFilePresentAtStartup': [\(self.bWasAppCrashFilePresentAtStartup)],")
        asToString.append("bAppDelegateVisitorCrashMarkerFilespecIsUsable': [\(self.bAppDelegateVisitorCrashMarkerFilespecIsUsable)],")
        asToString.append("bAppDelegateVisitorCrashMarkerFilespecIsCreated': [\(self.bAppDelegateVisitorCrashMarkerFilespecIsCreated)],")
        asToString.append("urlAppDelegateVisitorCrashMarkerFilespec': [\(String(describing: self.urlAppDelegateVisitorCrashMarkerFilespec))],")
        asToString.append("urlAppDelegateVisitorCrashMarkerFilepath': [\(String(describing: self.urlAppDelegateVisitorCrashMarkerFilepath))],")
        asToString.append("sAppDelegateVisitorCrashMarkerFilespec': [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))],")
        asToString.append("sAppDelegateVisitorCrashMarkerFilepath': [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilepath))],")
        asToString.append("urlAppDelegateVisitorLogToSaveFilespec': [\(String(describing: self.urlAppDelegateVisitorLogToSaveFilespec))],")
        asToString.append("sAppDelegateVisitorLogToSaveFilespec': [\(String(describing: self.sAppDelegateVisitorLogToSaveFilespec))],")
        asToString.append("],")
        asToString.append("[")
    //  asToString.append("SwiftData 'modelConfiguration': (\(self.modelConfiguration)),")
    //  asToString.append("SwiftData 'modelContainer': (\(String(describing: self.modelContainer))),")
    //  asToString.append("SwiftData 'modelContext': (\(String(describing: self.modelContext))),")
    //  asToString.append("SwiftData 'pfAdminsSwiftDataItems': (\(String(describing: self.pfAdminsSwiftDataItems))),")
    //  asToString.append("SwiftData 'cPFAdminsSwiftDataItems': (\(String(describing: self.cPFAdminsSwiftDataItems))),")
    //  asToString.append("SwiftData 'bArePFAdminsSwiftDataItemsAvailable': (\(String(describing: self.bArePFAdminsSwiftDataItemsAvailable))),")
    //  asToString.append("],")
    //  asToString.append("[")
        asToString.append("jmAppSwiftDataManager': [\(String(describing: self.jmAppSwiftDataManager))],")
        asToString.append("jmObjCSwiftEnvBridge': [\(String(describing: self.jmObjCSwiftEnvBridge))],")
        asToString.append("jmAppMetricKitManager': [\(String(describing: self.jmAppMetricKitManager))],")
        asToString.append("jmAppUserNotificationManager': [\(String(describing: self.jmAppUserNotificationManager))],")
        asToString.append("jmAppParseCoreManager': [\(String(describing: self.jmAppParseCoreManager))],")
        asToString.append("jmAppCLModelObservable2': [\(String(describing: self.jmAppCLModelObservable2))],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of @objc public func toString().

    private override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        self.cAppDelegateVisitorInitCalls           += 1
        self.bAppDelegateVisitorLogFilespecIsUsable  = false

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'self' is [\(self)]...")

        // NOTE: The method 'performAppDelegateVisitorStartupCrashLogic()' MUST be the first method called
        //       by this 'init()' method to properly handle startup if there was an App 'crash': 

        self.performAppDelegateVisitorStartupCrashLogic()

        // Setup the 'logging' output (console and file):

        self.initAppDelegateVisitorTraceLog(initappdelegatetracelogtag:"\(sCurrMethodDisp)<>\(self.cAppDelegateVisitorInitCalls)")

        self.xcgLogMsg("\(sCurrMethodDisp) Method Invoked - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is starting - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' instance 'self.xcgLogger' is being used (default instance)...")
        
        // Handle displaying the field(s) of the AppGlobalInfo class:

        self.displayAppGlobalInfoFields()

        // Dump the App 'Info.plist':

        let _ = self.dumpAppInfoPlistToLog()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - #(\(self.cAppDelegateVisitorInitCalls)) time(s) - 'sApplicationName' is [\(self.sApplicationName)]...")

        return

    }   // End of private override init().
        
    public func runPostInitializationTasks()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Initialize SwiftData Manager <maybe>:

        if (AppGlobalInfo.bInstantiateAppSwiftDataManager == true)
        {

            // Instantiate the JmAppSwiftDataManager...

            self.xcgLogMsg("\(sCurrMethodDisp) Instantiating the 'self.jmAppSwiftDataManager' instance...")

            self.jmAppSwiftDataManager = JmAppSwiftDataManager.ClassSingleton.appSwiftDataManager

            self.jmAppSwiftDataManager?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
          
            self.xcgLogMsg("\(sCurrMethodDisp) Instantiated  the 'self.jmAppSwiftDataManager' instance...")
            
        }

        // Setup the Objective-C/Swift Bridge:
  
        self.jmObjCSwiftEnvBridge = JmObjCSwiftEnvBridge.sharedObjCSwiftEnvBridge

        self.jmObjCSwiftEnvBridge?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
  
        self.xcgLogMsg("\(sCurrMethodDisp) 'self' is [\(self)] and 'self.jmObjCSwiftEnvBridge' is (\(String(describing: self.jmObjCSwiftEnvBridge))) and 'self.xcgLogger' is [\(String(describing: self.xcgLogger))]...")
  
        // Objective-C call(s) <maybe>:

        if (AppGlobalInfo.bPerformAppObjCSwiftBridgeTest == true)
        {

            // Initialize and call the class DefinesObjCOverrides...

            let definesObjCModule = DefinesObjCOverrides()
          
            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - calling 'definesObjCModule.initInstance()' with NO parameter(s)...")
          
            definesObjCModule.initInstance()
          
            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #1 - called  'definesObjCModule.initInstance()' with NO parameter(s)...")

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #2 - calling 'definesObjCModule.customLoggerTest1()' with 1 parameter(s)...")
          
            let sHelloMessage1:String = "Message from 'JmAppDelegateVisitor' to 'definesObjCModule.customLoggerTest1(sHelloMessage1)'..."

            definesObjCModule.customLoggerTest1(sHelloMessage1)

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #2 - called  'definesObjCModule.customLoggerTest1()' with a parameter of [\(String(describing: sHelloMessage1))]...")

            // Initialize and call the class CalledObjCModule...

            let calledObjCModule = CalledObjCModule()

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #3 - calling 'calledObjCModule.initInstance()' with NO parameter(s)...")

            calledObjCModule.initInstance()

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #3 - called  'calledObjCModule.initInstance()' with NO parameter(s)...")

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #4 - calling 'calledObjCModule.getInternalVariable()' with 1 parameter(s)...")
          
            let sInternalVariable:String? = calledObjCModule.getInternalVariable()

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #4 - called  'calledObjCModule.getInternalVariable()' - returned parameter 'sInternalVariable' is [\(String(describing: sInternalVariable))]...")

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #5 - calling 'calledObjCModule.sayHello()' with 1 parameter(s)...")
          
            let sHelloMessage2:String = "Message from 'JmAppDelegateVisitor' to 'calledObjCModule.sayHello(sHelloMessage2)'..."

            calledObjCModule.sayHello(sHelloMessage2)

            self.xcgLogMsg("\(sCurrMethodDisp) Objective-C call #5 - called  'calledObjCModule.sayHello()' with a parameter of [\(String(describing: sHelloMessage2))]...")

        }

        // Apple MetricKitManager instantiation <maybe>:

        if (AppGlobalInfo.bInstantiateAppMetricKitManager == true)
        {

            // Instantiate the jmAppMetricKitManager...

            self.xcgLogMsg("\(sCurrMethodDisp) Instantiating the 'self.jmAppMetricKitManager' instance...")

            self.jmAppMetricKitManager = JmAppMetricKitManager()

            self.jmAppMetricKitManager?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
          
            self.xcgLogMsg("\(sCurrMethodDisp) Instantiated  the 'self.jmAppMetricKitManager' instance...")

        }

        // Apple UNUserNotificationCenter Manager instantiation <maybe>:

        if (AppGlobalInfo.bInstantiateAppUserNotificationsManager == true)
        {

            // Instantiate the jmAppUserNotificationManager...

            self.xcgLogMsg("\(sCurrMethodDisp) Instantiating the 'self.jmAppUserNotificationManager' instance...")

            self.jmAppUserNotificationManager = JmAppUserNotificationManager()

            self.jmAppUserNotificationManager?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
          
            self.xcgLogMsg("\(sCurrMethodDisp) Instantiated  the 'self.jmAppUserNotificationManager' instance...")

        }

        // ParseCore (Client) framework Manager instantiation <maybe>:

        if (AppGlobalInfo.bInstantiateAppParseCoreManager == true)
        {

            // Instantiate the JmAppParseCoreManager...

            self.xcgLogMsg("\(sCurrMethodDisp) Instantiating the 'self.JmAppParseCoreManager' instance...")

            self.jmAppParseCoreManager = JmAppParseCoreManager()

            self.jmAppParseCoreManager?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
          
            self.xcgLogMsg("\(sCurrMethodDisp) Instantiated  the 'self.JmAppParseCoreManager' instance...")

        }

        // Apple CoreLocation (service) instantiation <maybe>:

        if (AppGlobalInfo.bInstantiateAppCoreLocationSupport == true)
        {

            // Instantiate the CoreLocationModelObservable()...

            self.xcgLogMsg("\(sCurrMethodDisp) Instantiating the 'self.jmAppCLModelObservable2' instance...")

            self.jmAppCLModelObservable2 = CoreLocationModelObservable2()

            self.jmAppCLModelObservable2?.setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:self)
          
            self.xcgLogMsg("\(sCurrMethodDisp) Instantiated  the 'self.jmAppCLModelObservable2' instance...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func runPostInitializationTasks().
        
    @objc public func xcgLogMsg(_ sMessage:String)
    {

        if (self.bAppDelegateVisitorLogFilespecIsUsable == true)
        {

            self.xcgLogger?.info(sMessage)

        }
        else
        {

            print("\(sMessage)")

            self.listPreXCGLoggerMessages.append(sMessage)

        }

        // Exit:

        return

    }   // End of @objc public func xcgLogMsg().

    // Method(s) to setup the file and console 'logging' output:

    private func initAppDelegateVisitorTraceLog(initappdelegatetracelogtag:String = "-unknown-")
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (self.bAppDelegateVisitorTraceLogInitRequired == true)
        {
            
            self.setupAppDelegateVisitorTraceLogFile()
            self.setupAppDelegateVisitorXCGLogger()

            if (self.bAppDelegateVisitorLogFilespecIsUsable == true &&
                self.listPreXCGLoggerMessages.count          > 0)
            {

                self.xcgLogMsg("")
                self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the XCGLogger 'pre' Message(s) === >>>")

                let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

                self.xcgLogMsg(sPreXCGLoggerMessages)

                self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the XCGLogger 'pre' Message(s) === >>>")
                self.xcgLogMsg("")

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'initappdelegatetracelogtag' is [\(initappdelegatetracelogtag)]...")

            self.sInitAppDelegateVisitorTraceLogTag = initappdelegatetracelogtag

            if (self.sInitAppDelegateVisitorTraceLogTag.count < 1)
            {

                self.sInitAppDelegateVisitorTraceLogTag = "-unknown-"

                let sSearchMessage:String = "Supplied 'init' AppDelegateVisitor Trace Log loader TAG string is an 'empty' string - defaulting it to [\(self.sInitAppDelegateVisitorTraceLogTag)] - Warning!"

                self.xcgLogMsg("\(sCurrMethodDisp) \(sSearchMessage)")

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - AppDelegateVisitor TraceLog setup was called by [\(self.sInitAppDelegateVisitorTraceLogTag)]...")

            self.bAppDelegateVisitorTraceLogInitRequired = false

        }

        // Exit:

        return

    }   // End of private func initAppDelegateVisitorTraceLog().

    private func setupAppDelegateVisitorTraceLogFile()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("[\(sCurrMethodDisp)] Invoked...")

        // Setup the AppDelegateVisitor (physical) 'log' file:

        do 
        {

            self.urlAppDelegateVisitorLogFilepath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask ,appropriateFor: nil, create: true)
            self.urlAppDelegateVisitorLogFilespec = self.urlAppDelegateVisitorLogFilepath?.appendingPathComponent(AppGlobalInfo.sGlobalInfoAppLogFilespec)
            self.sAppDelegateVisitorLogFilespec   = self.urlAppDelegateVisitorLogFilespec?.path
            self.sAppDelegateVisitorLogFilepath   = self.urlAppDelegateVisitorLogFilepath?.path

            self.xcgLogMsg("[\(sCurrMethodDisp)] 'self.sAppDelegateVisitorLogFilespec' (computed) is [\(String(describing: self.sAppDelegateVisitorLogFilespec))]...")
            self.xcgLogMsg("[\(sCurrMethodDisp)] 'self.sAppDelegateVisitorLogFilepath' (resolved #2) is [\(String(describing: self.sAppDelegateVisitorLogFilepath))]...")

            let bIsAppLogFilePresent:Bool = JmFileIO.fileExists(sFilespec:self.sAppDelegateVisitorLogFilespec)

            if (bIsAppLogFilePresent == true)
            {

                self.bWasAppLogFilePresentAtStartup = true

                // The LOG file 'exists', calculate the 'target' Log file name:

                self.xcgLogMsg("\(sCurrMethodDisp) 'self.bWasAppCrashFilePresentAtStartup' is [\(self.bWasAppCrashFilePresentAtStartup)]...")

                if (self.bWasAppCrashFilePresentAtStartup == true)
                {

                    self.urlAppDelegateVisitorLogToSaveFilespec = self.urlAppDelegateVisitorLogFilepath?.appendingPathComponent("\(AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec)")

                    self.xcgLogMsg("\(sCurrMethodDisp) App appears to have been 'crashed'...")

                }
                else
                {

                    self.urlAppDelegateVisitorLogToSaveFilespec = self.urlAppDelegateVisitorLogFilepath?.appendingPathComponent("\(AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec)")

                    self.xcgLogMsg("\(sCurrMethodDisp) App appears to have been terminated 'successfully'...")

                }

                self.xcgLogMsg("[\(sCurrMethodDisp)] Saving the LOG Filespec of [\(String(describing: self.urlAppDelegateVisitorLogFilespec))] to the 'target' LOG Filespec of [\(String(describing: self.urlAppDelegateVisitorLogToSaveFilespec))]...")

                self.sAppDelegateVisitorLogToSaveFilespec = self.urlAppDelegateVisitorLogToSaveFilespec?.path

                // If the 'target' Log file (to be moved to) exists, then remove (delete) it first (or the 'move' will fail):

                let bIsAppLogToSaveFilePresent:Bool = JmFileIO.fileExists(sFilespec:self.sAppDelegateVisitorLogToSaveFilespec)

                if (bIsAppLogToSaveFilePresent == true)
                {

                    try FileManager.default.removeItem(at: self.urlAppDelegateVisitorLogToSaveFilespec!)

                    self.xcgLogMsg("[\(sCurrMethodDisp)] Successfully removed the 'target' LOG Filespec of [\(String(describing: self.urlAppDelegateVisitorLogToSaveFilespec))]...")

                }

                // Save the Log file to the 'target' Log file:

                try FileManager.default.moveItem(at: self.urlAppDelegateVisitorLogFilespec!,
                                                 to: self.urlAppDelegateVisitorLogToSaveFilespec!)

                self.xcgLogMsg("[\(sCurrMethodDisp)] Successfully 'saved' the Log Filespec of [\(String(describing: self.sAppDelegateVisitorLogFilespec))] to a 'target' Log Filespec of [\(String(describing: self.urlAppDelegateVisitorLogToSaveFilespec))]...")

            }
            else
            {

                self.bWasAppLogFilePresentAtStartup = false

            }

            try FileManager.default.createDirectory(atPath: self.sAppDelegateVisitorLogFilepath, withIntermediateDirectories: true, attributes: nil)

            let sContents = "\(sCurrMethodDisp) Invoked - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]..."

            try sContents.write(toFile: self.sAppDelegateVisitorLogFilespec, atomically:true, encoding:String.Encoding.utf8)

            self.bAppDelegateVisitorLogFilespecIsUsable = true

            self.xcgLogMsg("[\(sCurrMethodDisp)] Successfully created the 'path' of [.documentDirectory] and the Log Filespec of [\(String(describing: self.sAppDelegateVisitorLogFilespec))]...")

        }
        catch
        {

            self.bAppDelegateVisitorLogFilespecIsUsable = false

            self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to create the 'path' of [.documentDirectory] - Error: \(error)...")

        }

        // Exit:

        self.xcgLogMsg("[\(sCurrMethodDisp)] Exiting - 'self.bAppDelegateVisitorLogFilespecIsUsable' is [\(self.bAppDelegateVisitorLogFilespecIsUsable)] - 'self.bWasAppLogFilePresentAtStartup' is [\(self.bWasAppLogFilePresentAtStartup)]...")

        return

    }   // End of private func setupAppDelegateVisitorTraceLogFile().

    private func setupAppDelegateVisitorXCGLogger()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("[\(sCurrMethodDisp)] - Invoked...")

        // Setup the AppDelegateVisitor XCGLogger instance:

        self.xcgLogger?.setup(level:             .verbose,
                              showLogIdentifier: false,
                              showFunctionName:  false,
                              showThreadName:    false,
                              showLevel:         false,
                              showFileNames:     false,
                              showLineNumbers:   false,
                              showDate:          true,
                              writeToFile:       self.urlAppDelegateVisitorLogFilespec,
                              fileLevel:         .verbose)

        let listXCGLoggerDestinations = self.xcgLogger?.destinations
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance has these destinations (\(listXCGLoggerDestinations!.count)): [\(String(describing: listXCGLoggerDestinations))]...")
        
        for index in 0 ..< (listXCGLoggerDestinations!.count) 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) TYPE is [\(String(describing: type(of: listXCGLoggerDestinations?[index])))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) 'is' FileDestination [\(String(describing: (listXCGLoggerDestinations?[index] is FileDestination)))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) Destination 'identifier' is [\(String(describing: listXCGLoggerDestinations?[index].identifier))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) is [\(String(describing: listXCGLoggerDestinations?[index]))]...")

            if ((listXCGLoggerDestinations?[index] is FileDestination) == true)
            {

                let xcgFileDestination = listXCGLoggerDestinations?[index] as! FileDestination

                self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to file [\(String(describing: xcgFileDestination.writeToFileURL))]...")

            }

        }
        
        // Add basic app info, version info etc, to the start of the logs:

        self.xcgLogger?.logAppDetails()

        // Exit:

        self.xcgLogMsg("[\(sCurrMethodDisp)] - Exiting...")

        return

    }   // End of private func setupAppDelegateVisitorXCGLogger().

    @objc public func clearAppDelegateVisitorTraceLogFile()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Locate and remove the FileDestination from the 'default' xcgLogger?:

        let listXCGLoggerDestinations    = self.xcgLogger?.destinations
        var xcgFileDestinationIdentifier = XCGLogger.Constants.fileDestinationIdentifier
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance has these destinations (\(listXCGLoggerDestinations!.count)): [\(String(describing: listXCGLoggerDestinations))]...")
        
        for index in 0 ..< (listXCGLoggerDestinations!.count) 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) TYPE is [\(String(describing: type(of: listXCGLoggerDestinations?[index])))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) 'is' FileDestination [\(String(describing: (listXCGLoggerDestinations?[index] is FileDestination)))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) Destination 'identifier' is [\(String(describing: listXCGLoggerDestinations?[index].identifier))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' (default) instance destination #(\(index)) is [\(String(describing: listXCGLoggerDestinations?[index]))]...")

            if ((listXCGLoggerDestinations?[index] is FileDestination) == true)
            {

                let xcgFileDestination = listXCGLoggerDestinations?[index] as! FileDestination

                xcgFileDestinationIdentifier = xcgFileDestination.identifier

                self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to file [\(String(describing: xcgFileDestination.writeToFileURL))]...")

                if (xcgFileDestinationIdentifier == XCGLogger.Constants.fileDestinationIdentifier)
                {

                    self.xcgLogger?.remove(destination: xcgFileDestination)

                }

            }

        }

        // Clear the AppDelegateVisitor (trace) 'Log' file:

        if (self.bAppDelegateVisitorLogFilespecIsUsable == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bAppDelegateVisitorLogFilespecIsUsable' is [\(self.bAppDelegateVisitorLogFilespecIsUsable)]...")

            return

        }

        do 
        {

            let sContents = "\(sCurrMethodDisp) ...Clearing the AppDelegateVisitor (trace) 'Log' file [\(String(describing: self.sAppDelegateVisitorLogFilespec))]..."

            try sContents.write(toFile: self.sAppDelegateVisitorLogFilespec, atomically:true, encoding:String.Encoding.utf8)

        }
        catch _
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - Exception in clearing the AppDelegateVisitor (trace) 'Log' file [\(String(describing: self.sAppDelegateVisitorLogFilespec))]...")

            return

        }

        // Construct and set-up a <new> 'default' FileDestination:

        let xcgFileDestination = FileDestination(writeToFile: self.urlAppDelegateVisitorLogFilespec!, 
                                                 identifier:  XCGLogger.Constants.fileDestinationIdentifier)
        
        xcgFileDestination.outputLevel       = .verbose
        xcgFileDestination.showLogIdentifier = false
        xcgFileDestination.showFunctionName  = false
        xcgFileDestination.showThreadName    = false
        xcgFileDestination.showLevel         = false
        xcgFileDestination.showFileName      = false
        xcgFileDestination.showLineNumber    = false
        xcgFileDestination.showDate          = true
        
        // Process this destination in the background:
        
        xcgFileDestination.logQueue = XCGLogger.logQueue
        
        // Re-add the 'default' FileDestination to xcgLogger?:

        self.xcgLogger?.add(destination: xcgFileDestination)
        
        self.xcgLogMsg("\(sCurrMethodDisp) XCGLogger 'log' FileDestination with 'identifier' of [\(xcgFileDestination.identifier)] is writing to [\(String(describing: xcgFileDestination.writeToFileURL))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func clearAppDelegateVisitorTraceLogFile().

    // Method to display the field(s) of the AppGlobalInfo struct:

    private func displayAppGlobalInfoFields()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Get the 'shared' instance of the AppGlobalInfo struct:

        let appGlobalInfo:AppGlobalInfo = AppGlobalInfo.ClassSingleton.appGlobalInfo

        // Display the various 'settings' of the AppGlobalInfo struct:

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppId' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppVers' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppVers))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppDisp' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppDisp))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppCopyRight' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppCopyRight))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppCrashMarkerFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppCrashMarkerFilespec))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bUseApplicationShortTitle' is [\(String(describing: AppGlobalInfo.bUseApplicationShortTitle))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sApplicationTitle' is [\(String(describing: AppGlobalInfo.sApplicationTitle))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sApplicationShortTitle' is [\(String(describing: AppGlobalInfo.sApplicationShortTitle))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sHelpBasicFileExt' is [\(String(describing: AppGlobalInfo.sHelpBasicFileExt))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bPerformAppObjCSwiftBridgeTest' is [\(String(describing: AppGlobalInfo.bPerformAppObjCSwiftBridgeTest))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppMetricKitManager' is [\(String(describing: AppGlobalInfo.bInstantiateAppMetricKitManager))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppUploadNotifyFrom' is [\(String(describing: AppGlobalInfo.sAppUploadNotifyFrom))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceType' is [\(String(describing: appGlobalInfo.sGlobalDeviceType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.bGlobalDeviceIsMac' is [\(String(describing: appGlobalInfo.bGlobalDeviceIsMac))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.bGlobalDeviceIsIPad' is [\(String(describing: appGlobalInfo.bGlobalDeviceIsIPad))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.bGlobalDeviceIsIPhone' is [\(String(describing: appGlobalInfo.bGlobalDeviceIsIPhone))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.bGlobalDeviceIsAppleWatch' is [\(String(describing: appGlobalInfo.bGlobalDeviceIsAppleWatch))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.bGlobalDeviceIsXcodeSimulator' is [\(String(describing: appGlobalInfo.bGlobalDeviceIsXcodeSimulator))]...")
        
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceName' is [\(String(describing: appGlobalInfo.sGlobalDeviceName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceSystemName' is [\(String(describing: appGlobalInfo.sGlobalDeviceSystemName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceSystemVersion' is [\(String(describing: appGlobalInfo.sGlobalDeviceSystemVersion))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceModel' is [\(String(describing: appGlobalInfo.sGlobalDeviceModel))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sGlobalDeviceLocalizedModel' is [\(String(describing: appGlobalInfo.sGlobalDeviceLocalizedModel))]...")
        
    #if os(iOS)

        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.idiomGlobalDeviceUserInterfaceIdiom' is [\(String(describing: appGlobalInfo.idiomGlobalDeviceUserInterfaceIdiom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.iGlobalDeviceUserInterfaceIdiom' is [\(String(describing: appGlobalInfo.iGlobalDeviceUserInterfaceIdiom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.uuidGlobalDeviceIdForVendor' is [\(String(describing: appGlobalInfo.uuidGlobalDeviceIdForVendor))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.fGlobalDeviceCurrentBatteryLevel' is [\(String(describing: appGlobalInfo.fGlobalDeviceCurrentBatteryLevel))]...")

    #endif
        
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.fGlobalDeviceScreenSizeWidth' is [\(String(describing: appGlobalInfo.fGlobalDeviceScreenSizeWidth))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.fGlobalDeviceScreenSizeHeight' is [\(String(describing: appGlobalInfo.fGlobalDeviceScreenSizeHeight))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.iGlobalDeviceScreenSizeScale' is [\(String(describing: appGlobalInfo.iGlobalDeviceScreenSizeScale))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sAppCategory' is [\(String(describing: appGlobalInfo.sAppCategory))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sAppDisplayName' is [\(String(describing: appGlobalInfo.sAppDisplayName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sAppBundleIdentifier' is [\(String(describing: appGlobalInfo.sAppBundleIdentifier))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sAppVersionAndBuildNumber' is [\(String(describing: appGlobalInfo.sAppVersionAndBuildNumber))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'appGlobalInfo.sAppCopyright' is [\(String(describing: appGlobalInfo.sAppCopyright))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of private func displayAppGlobalInfoFields().

    // Method(s) that act as AppDelegate 'helpers':

    @objc public func dumpAppInfoPlistToLog() -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let infoFileURL = Bundle.main.url(forResource: "Info", withExtension: "plist")

        if (infoFileURL == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Locating the 'resource' URL for the 'Info.plist' (in Bundle.Resources) failed - Warning!")

            return false

        }

        var formatinfoplist                  = PropertyListSerialization.PropertyListFormat.xml
        var dictInfoPlist:[String:AnyObject] = [:]

        do 
        {

            let pListInfo = try Data(contentsOf: infoFileURL!)
          
            dictInfoPlist = try PropertyListSerialization.propertyList(from:    pListInfo,
                                                                       options: PropertyListSerialization.ReadOptions.mutableContainersAndLeaves,
                                                                       format:  &formatinfoplist) as! [String:AnyObject]

        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Error reading plist: \(error), format: \(formatinfoplist)...")

            return false

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Read the dictionary 'dictInfoPlist' with (\(dictInfoPlist.count)) element(s) of [\(dictInfoPlist)] from file [\(String(describing: infoFileURL))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of @objc public func dumpAppInfoPlistToLog().

    @objc public func dumpAppCommandLineArgs()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        let cArgs              = Int(CommandLine.argc)

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) The Command line input #(\(cArgs)) parameters are:")
        
        for i in 0..<cArgs
        {
            
            let sArg  = String(cString: CommandLine.unsafeArgv[i]!)
            let sArgV = sArg
            
            self.xcgLogMsg("\(sCurrMethodDisp) Input parameter #(\(i)) is [\(sArgV)]...")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorDidFinishLaunching().

    @objc public func getAppDelegateVisitorApplicationTitle() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        if (self.bAppTitleSetupRequired == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Setting up the Application 'title'...")

            if (self.bUseApplicationShortTitle == true)
            {

                self.sApplicationTitle = self.sApplicationShortTitle

            }
            else
            {

                self.sApplicationTitle = self.sApplicationName

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Set up of the Application 'title' of [\(self.sApplicationTitle)] done...")

            self.bAppTitleSetupRequired = false

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.sApplicationTitle' is [\(self.sApplicationTitle)]...")

        return self.sApplicationTitle

    }   // End of @objc public func getAppDelegateVisitorApplicationTitle().

    @objc public func getAppDelegateVisitorHelpBasicContents() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self.helpBasicLoader' is [\(String(describing: self.helpBasicLoader))]...")

        if (self.helpBasicLoader == nil)
        {

            self.helpBasicLoader = HelpBasicLoader()

        }

        var bWasHelpSetupPerformed:Bool = false

        if (self.helpBasicLoader?.bHelpSetupRequired == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Setting up HELP 'basic' content(s) - 'self.helpBasicLoader?.bHelpSetupRequired' is [\(String(describing: self.helpBasicLoader?.bHelpSetupRequired))]...")

            self.sHelpBasicContents                  = self.helpBasicLoader?.loadHelpBasicContents(helpbasicfileext:self.sHelpBasicFileExt, helpbasicloadertag:"'get...()'") ?? "---Error: HELP was NOT loaded properly---"
            self.helpBasicLoader?.bHelpSetupRequired = false
            bWasHelpSetupPerformed                   = true

            self.xcgLogMsg("\(sCurrMethodDisp) Set up the HELP 'basic' content(s) - 'self.helpBasicLoader?.bHelpSetupRequired' is [\(String(describing: self.helpBasicLoader?.bHelpSetupRequired))] - 'self.sHelpBasicContents' is [\(self.sHelpBasicContents)]...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasHelpSetupPerformed' is [\(bWasHelpSetupPerformed)] - 'self.helpBasicLoader?.bHelpSetupRequired' is [\(String(describing: self.helpBasicLoader?.bHelpSetupRequired))] - 'self.sHelpBasicContents' is [\(self.sHelpBasicContents)]...")

        return self.sHelpBasicContents

    }   // End of @objc public func getAppDelegateVisitorHelpBasicContents().

    // Method(s) that act as AppDelegateVistor 'crash' logic:

    @objc public func performAppDelegateVisitorStartupCrashLogic()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Setup the AppDelegateVisitor (physical) CRASH 'marker' file:

        do 
        {

            self.urlAppDelegateVisitorCrashMarkerFilepath = try FileManager.default.url(for: .documentDirectory ,in: .userDomainMask ,appropriateFor: nil, create: true)
            self.urlAppDelegateVisitorCrashMarkerFilespec = self.urlAppDelegateVisitorCrashMarkerFilepath?.appendingPathComponent(AppGlobalInfo.sGlobalInfoAppCrashMarkerFilespec)
            self.sAppDelegateVisitorCrashMarkerFilespec   = self.urlAppDelegateVisitorCrashMarkerFilespec?.path
            self.sAppDelegateVisitorCrashMarkerFilepath   = self.urlAppDelegateVisitorCrashMarkerFilepath?.path

            self.xcgLogMsg("[\(sCurrMethodDisp)] 'self.sAppDelegateVisitorCrashMarkerFilespec' (computed) is [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))]...")
            self.xcgLogMsg("[\(sCurrMethodDisp)] 'self.sAppDelegateVisitorCrashMarkerFilepath' (resolved #2) is [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilepath))]...")

            try FileManager.default.createDirectory(atPath: sAppDelegateVisitorCrashMarkerFilepath, withIntermediateDirectories: true, attributes: nil)

            self.bWasAppCrashFilePresentAtStartup = JmFileIO.fileExists(sFilespec:self.sAppDelegateVisitorCrashMarkerFilespec)

            if (self.bWasAppCrashFilePresentAtStartup == false)
            {

                self.xcgLogMsg("[\(sCurrMethodDisp)] <<< PREVIOUS App execution appears to have been SUCCESSFULL!!! >>>")

                let sContents = "\(sCurrMethodDisp) Invoked (CRASH 'marker' detection file) - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]..."

                try sContents.write(toFile: self.sAppDelegateVisitorCrashMarkerFilespec, atomically:true, encoding:String.Encoding.utf8)

                self.bAppDelegateVisitorCrashMarkerFilespecIsCreated = true

                self.xcgLogMsg("[\(sCurrMethodDisp)] Successfully created the 'path' of [.documentDirectory] and the CRASH Marker Filespec of [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))]...")

            }
            else
            {

                self.xcgLogMsg("[\(sCurrMethodDisp)] <<< PREVIOUS App execution appears to have CRASHED!!! >>>")

                self.bAppDelegateVisitorCrashMarkerFilespecIsCreated = false

                self.xcgLogMsg("[\(sCurrMethodDisp)] Did NOT create the CRASH Marker Filespec of [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))]...")

            }

            self.bAppDelegateVisitorCrashMarkerFilespecIsUsable = true

        }
        catch
        {

            self.bAppDelegateVisitorCrashMarkerFilespecIsCreated = false
            self.bAppDelegateVisitorCrashMarkerFilespecIsUsable  = false

            self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to create the 'path' of [.documentDirectory] - Error: \(error)...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppDelegateVisitorCrashMarkerFilespecIsCreated' is [\(self.bAppDelegateVisitorCrashMarkerFilespecIsCreated)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppDelegateVisitorCrashMarkerFilespecIsUsable' is [\(self.bAppDelegateVisitorCrashMarkerFilespecIsUsable)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bWasAppCrashFilePresentAtStartup' is [\(self.bWasAppCrashFilePresentAtStartup)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func performAppDelegateVisitorStartupCrashLogic().

    @objc public func performAppDelegateVisitorTerminatingCrashLogic()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // (Possibly) remove the AppDelegateVisitor (physical) CRASH 'marker' file:

        do 
        {

            let bIsAppCrashMarkerFilePresent:Bool = JmFileIO.fileExists(sFilespec:self.sAppDelegateVisitorCrashMarkerFilespec)

            if (bIsAppCrashMarkerFilePresent == true)
            {

                try FileManager.default.removeItem(at: self.urlAppDelegateVisitorCrashMarkerFilespec!)

                self.xcgLogMsg("[\(sCurrMethodDisp)] Successfully removed the CRASH 'marker' Filespec of [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))]...")

                self.bAppDelegateVisitorCrashMarkerFilespecIsCreated = false

            }

        }
        catch
        {

            self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to remove the CRASH 'marker' Filespec of [\(String(describing: self.sAppDelegateVisitorCrashMarkerFilespec))] - Error: \(error)...") 

        }

        self.bAppDelegateVisitorCrashMarkerFilespecIsCreated = false
        self.bAppDelegateVisitorCrashMarkerFilespecIsUsable  = false
        self.bWasAppCrashFilePresentAtStartup                = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppDelegateVisitorCrashMarkerFilespecIsCreated' is [\(self.bAppDelegateVisitorCrashMarkerFilespecIsCreated)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppDelegateVisitorCrashMarkerFilespecIsUsable' is [\(self.bAppDelegateVisitorCrashMarkerFilespecIsUsable)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bWasAppCrashFilePresentAtStartup' is [\(self.bWasAppCrashFilePresentAtStartup)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func performAppDelegateVisitorTerminatingCrashLogic().

    // Method(s) that signal interaction(s) with Swift View(s):

    @objc public func setAppDelegateVisitorSignalSwiftViewsShouldChange()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Signal Swift 'view(s)' that they should change (if watching this AppDelegateVisitor)...

        self.appDelegateVisitorSwiftViewsShouldChange = true

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func setAppDelegateVisitorSignalSwiftViewsShouldChange().

    @objc public func resetAppDelegateVisitorSignalSwiftViewsShouldChange()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Reset the signal Swift 'view(s)' that they should change (if watching this AppDelegateVisitor)...

        self.appDelegateVisitorSwiftViewsShouldChange = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func resetAppDelegateVisitorSignalSwiftViewsShouldChange().

    @objc public func setAppDelegateVisitorSignalGlobalAlert(_ alertMsg:String? = nil, alertButtonText:String? = nil)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter(s) 'alertMsg' is [\(String(describing: alertMsg))] - 'alertButtonText' is [\(String(describing: alertButtonText))] - 'self' is [\(self)]...")

        // Set the Alert fields (Message and Button Text) and then signal the Global Alert...

        if (alertMsg        == nil ||
            alertMsg!.count  < 1)
        {

            self.sAppDelegateVisitorGlobalAlertMessage = "-N/A-"

        }
        else
        {

            self.sAppDelegateVisitorGlobalAlertMessage = alertMsg

        }

        if (alertButtonText        == nil ||
            alertButtonText!.count  < 1)
        {

            self.sAppDelegateVisitorGlobalAlertButtonText = "-N/A-"

        }
        else
        {

            self.sAppDelegateVisitorGlobalAlertButtonText = alertButtonText

        }

        self.isAppDelegateVisitorShowingAlert = true

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func setAppDelegateVisitorSignalGlobalAlert().

    @objc public func resetAppDelegateVisitorSignalGlobalAlert()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Reset the signal of the Global Alert...

        self.sAppDelegateVisitorGlobalAlertMessage    = "-N/A-"
        self.sAppDelegateVisitorGlobalAlertButtonText = "-N/A-"
        self.isAppDelegateVisitorShowingAlert         = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func resetAppDelegateVisitorSignalGlobalAlert().

    public func setAppDelegateVisitorSignalCompletionAlert(_ alertMsg:String? = nil, alertButtonText:String? = nil, withCompletion completionHandler:(()->())?)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter(s) 'alertMsg' is [\(String(describing: alertMsg))] - 'alertButtonText' is [\(String(describing: alertButtonText))] - 'completionHandler' is [\(String(describing: completionHandler))]...")

        // Set the Alert fields (Message and Button Text) and then signal the Global Alert...

        if (alertMsg        == nil ||
            alertMsg!.count  < 1)
        {

            self.sAppDelegateVisitorCompletionAlertMessage = "-N/A-"

        }
        else
        {

            self.sAppDelegateVisitorCompletionAlertMessage = alertMsg

        }

        if (alertButtonText        == nil ||
            alertButtonText!.count  < 1)
        {

            self.sAppDelegateVisitorCompletionAlertButtonText = "-N/A-"

        }
        else
        {

            self.sAppDelegateVisitorCompletionAlertButtonText = alertButtonText

        }
        
        if completionHandler != nil
        {
            
            self.appDelegateVisitorCompletionClosure = completionHandler
            
        }
        else
        {
            
            self.appDelegateVisitorCompletionClosure = nil
            
        }

        self.isAppDelegateVisitorShowingCompletionAlert = true

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func setAppDelegateVisitorSignalCompletionAlert(_ alertMsg:String? = nil, alertButtonText:String? = nil, withCompletion completionHandler:@escaping(Void)->(Void)?)

    @objc public func resetAppDelegateVisitorSignalCompletionAlert()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // (Optionally) call the 'completion' handler and reset the signal of the 'completion' Alert...

        if self.appDelegateVisitorCompletionClosure != nil
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'completion' closure - 'appDelegateVisitorCompletionClosure' is [\(String(describing: self.appDelegateVisitorCompletionClosure))]...")

            self.appDelegateVisitorCompletionClosure!()

            self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'completion' closure - 'appDelegateVisitorCompletionClosure' is [\(String(describing: self.appDelegateVisitorCompletionClosure))]...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Bypassing calling the 'completion' closure - 'appDelegateVisitorCompletionClosure' is nil...")

        }

        self.sAppDelegateVisitorCompletionAlertMessage    = "-N/A-"
        self.sAppDelegateVisitorCompletionAlertButtonText = "-N/A-"
        self.appDelegateVisitorCompletionClosure          = nil
        self.isAppDelegateVisitorShowingCompletionAlert   = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func resetAppDelegateVisitorSignalCompletionAlert().

    // Method(s) to assist with sending Email with a File upload (and 'optional' Alert message)...

    @objc public func appDelegateVisitorSendEmailUpload(_ emailAddressTo:String,
                                                          emailAddressCc:String,  
                                                          emailSourceFilespec:String,
                                                          emailSourceFilename:String,
                                                          emailZipFilename:String,
                                                          emailSaveAsFilename:String,
                                                          emailFileMimeType:String,
                                                          emailFileData:NSData)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Pass the request on to the 'core' method...

        self.appDelegateVisitorSendUploadCore(alertIsBypassed:false,
                                              emailAddressTo:emailAddressTo,
                                              emailAddressCc:emailAddressCc,  
                                              emailSourceFilespec:emailSourceFilespec,
                                              emailSourceFilename:emailSourceFilename,
                                              emailZipFilename:emailZipFilename,
                                              emailSaveAsFilename:emailSaveAsFilename,
                                              emailFileMimeType:emailFileMimeType,
                                              emailFileData:emailFileData)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorSendEmailUpload().

    @objc public func appDelegateVisitorSendSilentUpload(_ emailAddressTo:String,
                                                           emailAddressCc:String,  
                                                           emailSourceFilespec:String,
                                                           emailSourceFilename:String,
                                                           emailZipFilename:String,
                                                           emailSaveAsFilename:String,
                                                           emailFileMimeType:String,
                                                           emailFileData:NSData)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Pass the request on to the 'core' method...

        self.appDelegateVisitorSendUploadCore(alertIsBypassed:true,
                                              emailAddressTo:emailAddressTo,
                                              emailAddressCc:emailAddressCc,  
                                              emailSourceFilespec:emailSourceFilespec,
                                              emailSourceFilename:emailSourceFilename,
                                              emailZipFilename:emailZipFilename,
                                              emailSaveAsFilename:emailSaveAsFilename,
                                              emailFileMimeType:emailFileMimeType,
                                              emailFileData:emailFileData)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorSendEmailUpload().

    private func appDelegateVisitorSendUploadCore(alertIsBypassed:Bool,
                                                  emailAddressTo:String,
                                                  emailAddressCc:String,  
                                                  emailSourceFilespec:String,
                                                  emailSourceFilename:String,
                                                  emailZipFilename:String,
                                                  emailSaveAsFilename:String,
                                                  emailFileMimeType:String,
                                                  emailFileData:NSData)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)] - 'alertIsBypassed' is [\(alertIsBypassed)]...")

        // Remap the inbound parameter(s) into a MultipartRequestInfo object...

        let multipartRequestInfo:MultipartRequestInfo = MultipartRequestInfo()

        multipartRequestInfo.bAppZipSourceToUpload    = false
        multipartRequestInfo.sAppUploadURL            = ""          // "" takes the Upload URL 'default'...
        multipartRequestInfo.sAppUploadNotifyFrom     = AppGlobalInfo.sAppUploadNotifyFrom
        multipartRequestInfo.sAppUploadNotifyTo       = emailAddressTo
        multipartRequestInfo.sAppUploadNotifyCc       = emailAddressCc
        multipartRequestInfo.sAppSourceFilespec       = emailSourceFilespec
        multipartRequestInfo.sAppSourceFilename       = emailSourceFilename
        multipartRequestInfo.sAppZipFilename          = emailZipFilename
        multipartRequestInfo.sAppSaveAsFilename       = emailSourceFilename
        multipartRequestInfo.sAppFileMimeType         = emailFileMimeType
        multipartRequestInfo.dataAppFile              = Data(referencing:emailFileData)

        self.xcgLogMsg("\(sCurrMethodDisp) The 'upload' is using 'multipartRequestInfo' of [\(String(describing: multipartRequestInfo.toString()))]...")

        // Send the 'upload' to the Server...

        let multipartRequestDriver:MultipartRequestDriver = MultipartRequestDriver(bGenerateResponseLongMsg:false, 
                                                                                   bAlertIsBypassed:alertIsBypassed)

        self.xcgLogMsg("\(sCurrMethodDisp) Calling 'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")

        multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:multipartRequestInfo)
        
        self.xcgLogMsg("\(sCurrMethodDisp) Called  'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func appDelegateVisitorSendUploadCore().

#if os(macOS)

    // NSApplicationDelegate method(s):

    @objc public func appDelegateVisitorWillFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillFinishLaunching(aNotification:).

    @objc public func appDelegateVisitorDidFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.dumpAppCommandLineArgs()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorDidFinishLaunching(aNotification:).

    @objc public func appDelegateVisitorWillTerminate(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is stopping...")

        self.performAppDelegateVisitorTerminatingCrashLogic()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillTerminate(aNotification:).

    @objc public func appDelegateVisitorApplication(_ application: NSApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorApplication(application:, urls:).

#elseif os(iOS)

    // UIApplicationDelegate method(s):

    // NOTE: This method can NOT be marked @objc because 'willFinishLaunchingWithOptions' is a Swift struct...
    
//  @objc public func appDelegateVisitorWillFinishLaunching(_ aNotification: Notification)
//  public func appDelegateVisitorWillFinishLaunchingWithOptions(_ uiApplication:UIApplication, willFinishLaunchingWithOptions:Dictionary<UIApplication.LaunchOptionsKey,AnyObject?>) -> Bool
    public func appDelegateVisitorWillFinishLaunchingWithOptions(_ uiApplication:UIApplication, willFinishLaunchingWithOptions:[UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(String(describing: uiApplication))] - 'willFinishLaunchingWithOptions' is [\(String(describing: willFinishLaunchingWithOptions))] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func appDelegateVisitorWillFinishLaunchingWithOptions(uiApplication:, willFinishLaunchingWithOptions:).
    
    @objc public func appDelegateVisitorWillFinishLaunchingWithOptions(_ uiApplication:UIApplication) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(String(describing: uiApplication))] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func @objc appDelegateVisitorWillFinishLaunchingWithOptions(uiApplication:).
    
    // NOTE: This method can NOT be marked @objc because 'willFinishLaunchingWithOptions' is a Swift struct...
    
//  @objc public func appDelegateVisitorDidFinishLaunching(_ aNotification: Notification)
    public func appDelegateVisitorDidFinishLaunchingWithOptions(_ uiApplication:UIApplication, didFinishLaunchingWithOptions:[UIApplication.LaunchOptionsKey:Any?]) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(String(describing: uiApplication))] - 'didFinishLaunchingWithOptions' is [\(String(describing: didFinishLaunchingWithOptions))] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.dumpAppCommandLineArgs()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func appDelegateVisitorDidFinishLaunchingWithOptions(uiApplication:, didFinishLaunchingWithOptions:).

    @objc public func appDelegateVisitorDidFinishLaunchingWithOptions(_ uiApplication:UIApplication) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(String(describing: uiApplication))] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        self.dumpAppCommandLineArgs()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    }   // End of public func @objc appDelegateVisitorDidFinishLaunchingWithOptions(uiApplication:).

//  @objc public func appDelegateVisitorWillTerminate(_ aNotification: Notification) 
    @objc public func appDelegateVisitorWillTerminate(_ uiApplication: UIApplication)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'uiApplication' is [\(uiApplication)] - 'sApplicationName' is [\(self.sApplicationName)] - 'self' is [\(self)]...")

        // Pass the 'terminate' on to the Apple UNUserNotificationCenter Manager instantiation <maybe>:

        if (AppGlobalInfo.bInstantiateAppUserNotificationsManager == true)
        {

            // Terminate the jmAppUserNotificationManager...

            self.xcgLogMsg("\(sCurrMethodDisp) Terminating the 'self.jmAppUserNotificationManager' instance...")

            self.jmAppUserNotificationManager?.terminateAppUserNotifications()
          
            self.xcgLogMsg("\(sCurrMethodDisp) Terminated  the 'self.jmAppUserNotificationManager' instance...")

        }

        // Finish the 'terminate' of the AppDelegateVisitor instance...

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegateVisitor is stopping...")

        self.performAppDelegateVisitorTerminatingCrashLogic()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorWillTerminate(uiApplication:).

//  @objc public func appDelegateVisitorApplication(_ application: NSApplication, open urls: [URL])
    @objc public func appDelegateVisitorApplication(_ application: UIApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of @objc public func appDelegateVisitorApplication(application:, urls:).

#endif

}   // End of class JmAppDelegateVisitor(NSObject, ObservableObject).


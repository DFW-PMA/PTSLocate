//
//  PTSLocateNSAppDelegate.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 07/19/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

//import Cocoa
import Foundation
import SwiftUI
import XCGLogger

class PTSLocateNSAppDelegate: NSObject, NSApplicationDelegate, ObservableObject
{

    struct ClassInfo
    {
        
        static let sClsId        = "PTSLocateNSAppDelegate"
        static let sClsVers      = "v1.1401"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    struct ClassSingleton
    {

        static var appDelegate:PTSLocateNSAppDelegate? = nil

    }

    // Various App field(s):

    var cAppDelegateInitCalls:Int                 = 0

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    public func toString()->String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'cAppDelegateInitCalls': (\(self.cAppDelegateInitCalls)),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor)],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        ClassSingleton.appDelegate  = self
        self.cAppDelegateInitCalls += 1
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - #(\(self.cAppDelegateInitCalls)) time(s) - 'sApplicationName' is [\(self.jmAppDelegateVisitor.sApplicationName)]...")

        // Run the AppDelegateVisitor 'post' initialization Task(s)...

        self.jmAppDelegateVisitor.runPostInitializationTasks()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - #(\(self.cAppDelegateInitCalls)) time(s) - 'sApplicationName' is [\(self.jmAppDelegateVisitor.sApplicationName)]...")

        return

    }   // End of init().
        
    private func xcgLogMsg(_ sMessage:String)
    {

        if (self.jmAppDelegateVisitor.bAppDelegateVisitorLogFilespecIsUsable == true)
        {
      
            self.jmAppDelegateVisitor.xcgLogMsg(sMessage)
      
        }
        else
        {
      
            print("\(sMessage)")
      
        }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    func applicationWillFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.jmAppDelegateVisitor.sApplicationName)] - 'self' is [\(self)]...")

        self.jmAppDelegateVisitor.appDelegateVisitorWillFinishLaunching(aNotification)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

        return

    }   // End of func applicationWillFinishLaunching().

    func applicationDidFinishLaunching(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.jmAppDelegateVisitor.sApplicationName)] - 'self' is [\(self)]...")

        self.jmAppDelegateVisitor.appDelegateVisitorDidFinishLaunching(aNotification)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

        return

    }   // End of func applicationDidFinishLaunching().

    func applicationWillTerminate(_ aNotification: Notification) 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'aNotification' is [\(aNotification)] - 'sApplicationName' is [\(self.jmAppDelegateVisitor.sApplicationName)] - 'self' is [\(self)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) AppDelegate is stopping...")

        self.jmAppDelegateVisitor.appDelegateVisitorWillTerminate(aNotification)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

        ClassSingleton.appDelegate = nil

        return

    }   // End of func applicationWillTerminate().

    func application(_ application: NSApplication, open urls: [URL])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'application' is [\(application)] - 'urls' are [\(urls)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Current '\(ClassInfo.sClsId)' is [\(self.toString())]...")
        self.xcgLogMsg("\(sCurrMethodDisp) -> Unhandled url(s) -> \(urls)")

        self.jmAppDelegateVisitor.appDelegateVisitorApplication(application, open:urls)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Method Exiting...")

        return

    }   // End of func application().

}   // End of class PTSLocateNSAppDelegate(NSObject, NSApplicationDelegate, ObservableObject).


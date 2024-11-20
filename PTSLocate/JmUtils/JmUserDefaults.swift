//
//  JmUserDefaults.swift
//  JmUtils_Library
//
//  Created by JustMacApps.net on 06/11/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//


import Foundation
import SwiftUI

#if canImport(Cocoa)
import Cocoa
#else
import UIKit
#endif

@available(iOS 14.0, *)
@objc(JmUserDefaults)
class JmUserDefaults: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId        = "JmUserDefaults"
        static let sClsVers      = "v1.0704"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Standard UserDefaults object:

    let userDefaults                              = UserDefaults.standard

    // App Data field(s):

    let bClsTraceInternal:Bool                    = false

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        return

    }   // End of override init().

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

    @objc public func toString()->String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'userDefaults': [\(String(describing: self.userDefaults))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bClsTraceInternal': [\(self.bClsTraceInternal)],")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of @objc public func toString().

    @objc func getObjCObjectForKey(_ forKey:NSString = "") -> Any?
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'forKey' is [\(forKey)]...")

        let sSuppliedForKey:String = forKey as String

        if (sSuppliedForKey.count < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied 'forKey' value is an 'empty' string - this is required - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' was None or empty - Error!...")

            return nil

        }

        let objUserDefaults:Any? = self.getObjectForKey(sSuppliedForKey)

        self.xcgLogMsg("\(sCurrMethodDisp) The 'objUserDefaults' value returned from UserDefaults for the key of [\(sSuppliedForKey)] is [\(String(describing: objUserDefaults))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' is [\(sSuppliedForKey)]...")

        return objUserDefaults

    }   // End of @objc public func getObjCObjectForKey().

    public func getObjectForKey(_ forKey:String = "") -> Any?
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'forKey' is [\(forKey)]...")

        let sSuppliedForKey:String = forKey

        if (sSuppliedForKey.count < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied 'forKey' value is an 'empty' string - this is required - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' was None or empty - Error!...")

            return nil

        }

        let objUserDefaults:Any? = self.userDefaults.object(forKey:sSuppliedForKey)

        self.xcgLogMsg("\(sCurrMethodDisp) The 'objUserDefaults' value returned from UserDefaults for the key of [\(sSuppliedForKey)] is [\(String(describing: objUserDefaults))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' is [\(sSuppliedForKey)]...")

        return objUserDefaults

    }   // End of public func getObjectForKey().

    @objc public func setObjCObjectForKey(_ keyValue:Any?, forKey:NSString = "")
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'forKey' is [\(forKey)]...")

        let sSuppliedForKey:String = forKey as String

        if (sSuppliedForKey.count < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied 'forKey' value is an 'empty' string - this is required - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' was None or empty - Error!...")

            return

        }

        self.setObjectForKey((keyValue as Any), forKey:sSuppliedForKey)

        self.xcgLogMsg("\(sCurrMethodDisp) The Supplied 'kayValue' object has been set into UserDefaults for the key of [\(sSuppliedForKey)] as [\(String(describing: keyValue))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' is [\(sSuppliedForKey)]...")

        return

    }   // End of @objc public func setObjCObjectForKey().

    public func setObjectForKey(_ keyValue:Any?, forKey:String = "")
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'forKey' is [\(forKey)]...")

        let sSuppliedForKey:String = forKey

        if (sSuppliedForKey.count < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied 'forKey' value is an 'empty' string - this is required - Error!")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' was None or empty - Error!...")

            return

        }

        self.userDefaults.set(keyValue, forKey:sSuppliedForKey)

        self.xcgLogMsg("\(sCurrMethodDisp) The Supplied 'kayValue' object has been set into UserDefaults for the key of [\(sSuppliedForKey)] as [\(String(describing: keyValue))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)] - 'sSuppliedForKey' is [\(sSuppliedForKey)]...")

        return

    }   // End of public func setObjectForKey().

}   // End of class JmUserDefaults(NSObject).


//
//  RestURLResponse.swift
//  PTSLocate
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

class RestURLResponse: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId          = "RestURLResponse"
        static let sClsVers        = "v1.0201"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2018-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    var bRestURLQueryOk                           = false
    var sRestURLRequest                           = ""
    var iRestURLResponseStatus                    = 0
    var sRestURLResponseError                     = ""
    var sRestURLResponseData                      = ""
    var adRestURLResponseResult:[NSDictionary]    = Array()
    var nsRestURLResponseData:NSData?             = nil

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
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bRestURLQueryOk': [\(self.bRestURLQueryOk))],")
        asToString.append("'sRestURLRequest': [\(self.sRestURLRequest))],")
        asToString.append("'iRestURLResponseStatus': [\(self.iRestURLResponseStatus))],")
        asToString.append("'sRestURLResponseError': [\(String(describing: self.sRestURLResponseError))],")
        asToString.append("'sRestURLResponseData': [\(String(describing: self.sRestURLResponseData))],")
        asToString.append("'adRestURLResponseResult': [\(String(describing: self.adRestURLResponseResult))],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (public) func toString().

    public func toDisplayString(sRestURLStatusMsg:String?)->String
    {

        var asToString:[String] = Array()

        if (sRestURLStatusMsg != nil)
        {

            asToString.append(sRestURLStatusMsg!)

        }

        asToString.append("'bRestURLQueryOk': [\(self.bRestURLQueryOk))],")
        asToString.append("'sRestURLRequest': [\(self.sRestURLRequest))],")
        asToString.append("'iRestURLResponseStatus': [\(self.iRestURLResponseStatus))],")
        asToString.append("'sRestURLResponseError': [\(String(describing: self.sRestURLResponseError))],")
        asToString.append("'sRestURLResponseData': [\(String(describing: self.sRestURLResponseData))],")
        asToString.append("'adRestURLResponseResult': contains (\(self.adRestURLResponseResult.count)) element(s)")

        let sContents:String = asToString.joined(separator: "\n")

        return sContents

    } // End of (public) func toDisplayString().

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
      
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of init().

    convenience init(bHandleURLRequestOk:Bool, sURLRequest:String, iURLResponseStatus:Int, sURLResponseMsg:String, sURLResponseData:String? = nil, adJsonAPIRespResult:[NSDictionary]? = nil, nsURLResponseData:NSData? = nil)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - Convenience Init #1...")

        self.bRestURLQueryOk        = bHandleURLRequestOk
        self.sRestURLRequest        = sURLRequest
        self.iRestURLResponseStatus = iURLResponseStatus
        self.sRestURLResponseError  = sURLResponseMsg
        self.sRestURLResponseData   = ""
        self.nsRestURLResponseData  = nil

        if (sURLResponseData != nil)
        {

            self.sRestURLResponseData = sURLResponseData!

        }
        
        if (adJsonAPIRespResult != nil)
        {
            
            self.adRestURLResponseResult = adJsonAPIRespResult!
            
        }

        if (nsURLResponseData != nil)
        {

            self.nsRestURLResponseData = nsURLResponseData

        }
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of init().

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

} // End of class RestURLResponse.


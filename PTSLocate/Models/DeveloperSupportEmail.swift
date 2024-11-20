//
//  DeveloperSupportEmail.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 09/06/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

struct DeveloperSupportEmail
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "DeveloperSupportEmail"
        static let sClsVers      = "v1.0110"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

#if os(macOS)
    private var sAppOSName:String                 = "MacOS"
    private var sAppOSVersion:String              = "\(ProcessInfo.processInfo.operatingSystemVersionString)"
    private var sAppOSHostModel:String            = "HostName: \(ProcessInfo.processInfo.hostName)"
#elseif os(iOS)
    private var sAppOSName:String                 = "iOS (iPadOS or iPhone)"
    private var sAppOSVersion:String              = "\(UIDevice.current.systemVersion)"
    private var sAppOSHostModel:String            = "Model: \(UIDevice.current.model)"
#endif

    private var sEmailToAddress:String            = "dcox@justmacapps.net"
    private var sEmailSubject:String              = "---None Supplied"
    private var sEmailBody:String
                    {"""
                      Application Name:    \(JmXcodeBuildSettings.jmAppDisplayName)
                      App Version/Build:   \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)
                      App OS Name:         \(sAppOSName)
                      App OS Version:      \(sAppOSVersion)
                      App OS Device Model: \(sAppOSHostModel)
                      
                          ...App::LOG Attached...
                      
                     """}
    
    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    init(sEmailSubject:String)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sEmailSubject' is [\(sEmailSubject)]...")

        self.sEmailSubject = sEmailSubject

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.sEmailSubject' is [\(self.sEmailSubject)] - parameter 'sEmailSubject' is [\(sEmailSubject)]...")

        return

    }   // End of init().

    func xcgLogMsg(_ sMessage:String)
    {

    //  print("\(sMessage)")
        self.jmAppDelegateVisitor.xcgLogMsg(sMessage)

        // Exit:

        return

    }   // End of func xcgLogMsg().

    func sendEmailToDevelopersViaURL(openURL:OpenURLAction)
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        let sEmailReplacedSubject:String = sEmailSubject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let sEmailReplacedBody:String    = sEmailBody.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
    //  let sEmailURL:String             = "mailto:\(sEmailToAddress)?subject=\(sEmailReplacedSubject)&body=\(sEmailReplacedBody)&attachment=\"\(jmAppDelegateVisitor.sAppDelegateVisitorLogToSaveFilespec ?? "")\""
        let sEmailURL:String             = "mailto:\(sEmailToAddress)?subject=\(sEmailReplacedSubject)&body=\(sEmailReplacedBody)"

        self.xcgLogMsg("\(sCurrMethodDisp) Sending 'sEmailURL' of [\(String(describing: sEmailURL))]...")

        guard let url = URL(string:sEmailURL) else { return }

        var bSendingEmailWasOk:Bool = false

        openURL(url) 
        { emailAccepted in

            if (emailAccepted == true) 
            { 

                self.xcgLogMsg("\(sCurrMethodDisp) Sending of 'sEmailURL' was successfull...")

                bSendingEmailWasOk = true

            }
            else
            { 

                self.xcgLogMsg("\(sCurrMethodDisp) Sending of 'sEmailURL' was NOT accepted - device does NOT appear to support email...")

                bSendingEmailWasOk = false

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bSendingEmailWasOk' is [\(bSendingEmailWasOk)]...")
  
        return
  
    }   // End of sendEmailToDevelopersViaURL(openURL:).

}


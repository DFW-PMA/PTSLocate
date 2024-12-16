//
//  AppLocationMapPatLocView.swift
//  PTSLocate
//
//  Created by Daryl Cox on 12/16/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import MapKit

struct AppLocationMapPatLocView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLocationMapPatLocView"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @State private var isAppMapTapAlertShowing:Bool              = false
    @State private var sMapTapMsg:String                         = ""

    @State         var scheduledPatientLocationItem:ScheduledPatientLocationItem

                   var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'scheduledPatientLocationItem' parameter...

        self._scheduledPatientLocationItem = State(initialValue: scheduledPatientLocationItem)

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'scheduledPatientLocationItem' at [\(scheduledPatientLocationItem)] value is [\(scheduledPatientLocationItem.toString())]...")

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

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

    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - PatLoc - PID #(\(scheduledPatientLocationItem.sPid)) for TID #(\(scheduledPatientLocationItem.sTid))...")

        Button
        {

            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - PatLoc - PID #(\(scheduledPatientLocationItem.sPid)) for TID #(\(scheduledPatientLocationItem.sTid)) Patient 'sPtName' is [\(String(describing: scheduledPatientLocationItem.sPtName))]...")

            self.sMapTapMsg = "\(scheduledPatientLocationItem.sPtName) at \(scheduledPatientLocationItem.sLastVDateAddress) on \(scheduledPatientLocationItem.sVDate)::\(scheduledPatientLocationItem.sVDateStartTime)"

            self.isAppMapTapAlertShowing.toggle()

        }
        label:
        {

            VStack(alignment:.center)
            {

                Label("", systemImage: "pin.circle")
                    .help(Text("Patient location..."))
                    .imageScale(.medium)

                Text(scheduledPatientLocationItem.sVDateStartTime)
                    .font(.caption)

            }

        }
        .alert(self.sMapTapMsg, isPresented:$isAppMapTapAlertShowing)
        {
            Button("Ok", role:.cancel)
            {
                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - PatLoc - User pressed 'Ok' to the Map 'tap' alert...")
            }
        }

    }

}   // End of struct AppLocationMapPatLocView(View).


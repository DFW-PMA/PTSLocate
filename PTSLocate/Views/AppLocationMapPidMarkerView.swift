//
//  AppLocationMapPidMarkerView.swift
//  PTSLocate
//
//  Created by Daryl Cox on 12/18/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import MapKit

struct AppLocationMapPidMarkerView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLocationMapPidMarkerView"
        static let sClsVers      = "v1.0104"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

                   var scheduledPatientLocationItem:ScheduledPatientLocationItem

    @State private var cAppMapTapPresses:Int                     = 0
    @State private var isAppMapTapAlertShowing:Bool              = false
    @State private var sMapTapMsg:String                         = ""

                   var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'scheduledPatientLocationItem' parameter...

        self.scheduledPatientLocationItem = scheduledPatientLocationItem

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
        
        EmptyView()
        
    //  let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - PidMarker - PID #(\(scheduledPatientLocationItem.sPid)) for TID #(\(scheduledPatientLocationItem.sTid))...")

    //  Annotation(scheduledPatientLocationItem.sVDateStartTime, 
    //             coordinate: scheduledPatientLocationItem.clLocationCoordinate2DPatLoc)
    //  {
    //
    //      Label("", systemImage: "cross.case.circle")
    //          .help(Text("Scheduled Patient visit"))
    //          .imageScale(.large)
    //          .onTapGesture
    //          { position in
    //          
    //              self.cAppMapTapPresses   += 1
    //              let sMapTapLogMsg:String  = "Map 'tap' #(\(cAppMapTapPresses)) - Marker for TID #(\(scheduledPatientLocationItem.sTid)) for PID #(\(scheduledPatientLocationItem.sPid)) Patient [\(scheduledPatientLocationItem.sPtName)] on [\(scheduledPatientLocationItem.sVDate)] at [\(scheduledPatientLocationItem.sVDateStartTime)] at address [\(scheduledPatientLocationItem.sLastVDateAddress)]..."
    //          
    //              let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(sMapTapLogMsg)...")
    //          
    //          }
    //
    //  }

    //  Marker(scheduledPatientLocationItem.sVDateStartTime,
    //         systemImage:"cross.case.circle",
    //         coordinate: scheduledPatientLocationItem.clLocationCoordinate2DPatLoc)
    //      .tint(.yellow)
    //      .onTapGesture
    //      { position in
    //
    //          self.cAppMapTapPresses   += 1
    //          let sMapTapLogMsg:String  = "Map 'tap' #(\(cAppMapTapPresses)) - Marker for TID #(\(scheduledPatientLocationItem.sTid)) for PID #(\(scheduledPatientLocationItem.sPid)) Patient [\(scheduledPatientLocationItem.sPtName)] on [\(scheduledPatientLocationItem.sVDate)] at [\(scheduledPatientLocationItem.sVDateStartTime)] at address [\(scheduledPatientLocationItem.sLastVDateAddress)]..."
    //
    //          let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(sMapTapLogMsg)...")
    //
    //      }

    }

}   // End of struct AppLocationMapPidMarkerView(View).


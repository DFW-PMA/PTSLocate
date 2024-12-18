//
//  AppLocationView.swift
//  PTSLocate
//
//  Created by Daryl Cox on 11/18/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct AppLocationView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLocationView"
        static let sClsVers      = "v1.0406"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject   var jmAppParseCoreManager:JmAppParseCoreManager
    
    @State private var cAppLocationViewRefreshButtonPresses:Int  = 0
    @State private var cAppLocationViewRefreshAutoTimer:Int      = 0
    @State private var cAppScheduleViewRefreshAutoTimer:Int      = 0

                   var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(jmAppParseCoreManager:JmAppParseCoreManager)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'jmAppParseCoreManager' parameter...

        self._jmAppParseCoreManager = StateObject(wrappedValue: jmAppParseCoreManager)

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

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
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        NavigationStack
        {

            VStack
            {

                HStack(alignment:.center)
                {

                    Spacer()

                    Button
                    {

                        self.cAppLocationViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLocationView in Button(Xcode).'Refresh'.#(\(self.cAppLocationViewRefreshButtonPresses))...")

                        let _ = self.checkIfAppParseCoreHasPFCscDataItems()
                        let _ = self.checkIfAppParseCoreHasPFPatientCalDayItems()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Location Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppLocationViewRefreshButtonPresses))...")
                                .font(.caption)

                        }

                    }

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.Button(Xcode).'Dismiss' pressed...")

                        self.presentationMode.wrappedValue.dismiss()

                    //  dismiss()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "xmark.circle")
                                .help(Text("Dismiss this Screen"))
                                .imageScale(.large)

                            Text("Dismiss")
                                .font(.caption)

                        }

                    }
                    .padding()

                }

                Text("")

                Text("Auto-Update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh))")
                    .bold()
                    .italic()
                    .underline(true)
                    .font(.footnote)

                Text("")

                ScrollView(.vertical)
                {

                    Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                    {

                        // Column Headings:

                        Divider() 

                        GridRow 
                        {

                            Text("Map")
                                .font(.caption)
                            Text("Visits")
                                .font(.caption)
                            Text("Name")
                                .font(.caption)
                            Text("Date")
                                .font(.caption)
                            Text("Time")
                                .font(.caption)
                            Text("Location")
                                .font(.caption)

                        }
                        .font(.title3) 

                        Divider() 

                        // Item Rows:

                        ForEach(jmAppParseCoreManager.listPFCscDataItems) 
                        { pfCscObject in

                            GridRow(alignment:.bottom)
                            {

                                NavigationLink
                                {

                                    AppLocationMapView(parsePFCscDataItem:pfCscObject).navigationBarBackButtonHidden(false)

                                }
                                label:
                                {

                                    VStack(alignment:.center)
                                    {

                                        Label("", systemImage: "mappin.and.ellipse")
                                            .help(Text("'Map' the App Location..."))
                                            .imageScale(.small)
                                        #if os(macOS)
                                            .onTapGesture(count:1)
                                            {

                                                let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.GridRow.NavigationLink.'.onTapGesture()' received - Map #(\(pfCscObject.idPFCscObject))...")

                                                AppLocationMapView(parsePFCscDataItem:pfCscObject)

                                            }
                                        #endif

                                        Text("Map #(\(pfCscObject.idPFCscObject))")
                                            .font(.caption2)

                                    }

                                }
                                .gridColumnAlignment(.center)

                                Text("(\(self.getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:pfCscObject)))")
                                    .bold()
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseName)
                                    .bold()
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseLastLocDate)
                                    .gridColumnAlignment(.center)
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseLastLocTime)
                                    .gridColumnAlignment(.center)
                                    .font(.caption)
                                Text("\(pfCscObject.sCurrentLocationName), \(pfCscObject.sCurrentCity)")
                                    .font(.caption)
                                    .onChange(of:jmAppParseCoreManager.cPFCscObjectsRefresh)
                                    {
                                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - GridRow(Item(s)) #(\(pfCscObject.idPFCscObject)) for [\(pfCscObject.sPFCscParseName)] received a 'refresh' COUNT update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh))...")
                                    }

                            }

                        }

                    }
                    .onReceive(jmAppParseCoreManager.timerPublisherTherapistLocations,
                        perform:
                        { dtObserved in

                            self.cAppLocationViewRefreshAutoTimer += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Grid.Timer<notification> - <timerPublisherTherapistLocations> - setting auto 'refresh' by timer to #(\(self.cAppLocationViewRefreshAutoTimer))...")

                            let _ = self.checkIfAppParseCoreHasPFCscDataItems()

                        })
                    .onReceive(jmAppParseCoreManager.timerPublisherScheduleLocations,
                        perform:
                        { dtObserved in

                            self.cAppScheduleViewRefreshAutoTimer += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #2 - Grid.Timer<notification> - <timerPublisherScheduleLocations> - setting auto 'refresh' by timer to #(\(self.cAppScheduleViewRefreshAutoTimer))...")

                            let _ = self.checkIfAppParseCoreHasPFPatientCalDayItems()

                        })

                }

            }

        }
        .padding()
        
    }
    
    private func checkIfAppParseCoreHasPFCscDataItems() -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

            let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.getJmAppParsePFQueryForCSC()

            self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list - 'jmAppParseCoreManager' is nil - Error!")

        }

        var bWasAppPFCscDataPresent:Bool = false

        if (jmAppDelegateVisitor.jmAppParseCoreManager == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' has a 'jmAppParseCoreManager' that is nil - 'bWasAppPFCscDataPresent' is [\(String(describing: bWasAppPFCscDataPresent))]...")

            bWasAppPFCscDataPresent = false

        }
        else
        {

            if ((jmAppDelegateVisitor.jmAppParseCoreManager?.listPFCscDataItems.count)! < 1)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is 'empty'...")

                bWasAppPFCscDataPresent = false

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.listPFCscDataItems))]...")

                bWasAppPFCscDataPresent = true

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFCscDataPresent' is [\(String(describing: bWasAppPFCscDataPresent))]...")
  
        return bWasAppPFCscDataPresent
  
    }   // End of private func checkIfAppParseCoreHasPFCscDataItems().

    private func checkIfAppParseCoreHasPFPatientCalDayItems() -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        var bWasAppPFPatientCalDayCalled:Bool = false

        if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Calling the 'jmAppParseCoreManager' method 'gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient Schedule location data...")

            let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()

            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Called  the 'jmAppParseCoreManager' method 'gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient Schedule location data...")

            bWasAppPFPatientCalDayCalled = true

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list - 'jmAppParseCoreManager' is nil - Error!")

            bWasAppPFPatientCalDayCalled = false

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFPatientCalDayCalled' is [\(String(describing: bWasAppPFPatientCalDayCalled))]...")
  
        return bWasAppPFPatientCalDayCalled
  
    }   // End of private func checkIfAppParseCoreHasPFPatientCalDayItems().

    private func convertPFCscDataItemToTid(pfCscDataItem:ParsePFCscDataItem)->String
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the TherapistName in the PFCscDataItem to lookup the 'sPFTherapistParseTID'...

        var sPFTherapistParseTID:String = ""

        if (self.jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {
        
            let jmAppParseCoreManager:JmAppParseCoreManager = self.jmAppDelegateVisitor.jmAppParseCoreManager!

            if (pfCscDataItem.sPFCscParseName.count > 0)
            {

                sPFTherapistParseTID = jmAppParseCoreManager.convertTherapistNameToTid(sPFTherapistParseName:pfCscDataItem.sPFCscParseName)

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")
  
        return sPFTherapistParseTID
  
    }   // End of private func convertPFCscDataItemToTid(pfCscDataItem:PFCscDataItem)->String.

    private func getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:String = "")->[ScheduledPatientLocationItem]
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")

        // Use the TherapistName in the PFCscDataItem to lookup any ScheduledPatientLocationItem(s)...

        var listScheduledPatientLocationItems:[ScheduledPatientLocationItem] = []

        if (self.jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {
        
            let jmAppParseCoreManager:JmAppParseCoreManager = self.jmAppDelegateVisitor.jmAppParseCoreManager!

            if (sPFTherapistParseTID.count > 0)
            {

                if (jmAppParseCoreManager.dictSchedPatientLocItems.count > 0)
                {

                    listScheduledPatientLocationItems = jmAppParseCoreManager.dictSchedPatientLocItems[sPFTherapistParseTID] ?? []

                }

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listScheduledPatientLocationItems' is [\(listScheduledPatientLocationItems)]...")
  
        return listScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:String = "")->[ScheduledPatientLocationItem].

    private func getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->[ScheduledPatientLocationItem]
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the Therapist TID to lookup any ScheduledPatientLocationItem(s)...

        let sPFTherapistParseTID:String
            = self.convertPFCscDataItemToTid(pfCscDataItem:pfCscDataItem)
        let listScheduledPatientLocationItems:[ScheduledPatientLocationItem] 
            = self.getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:sPFTherapistParseTID)

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listScheduledPatientLocationItems' is [\(listScheduledPatientLocationItems)]...")
  
        return listScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:PFCscDataItem)->[ScheduledPatientLocationItem].

    private func getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->Int
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the 'pfCscDataItem' to lookup any ScheduledPatientLocationItem(s) and return their count...

        var cScheduledPatientLocationItems:Int = 0
        let listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
            = self.getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:pfCscDataItem)

        if (listScheduledPatientLocationItems.count > 0)
        {
        
            cScheduledPatientLocationItems = listScheduledPatientLocationItems.count
        
        }
        else
        {
        
            cScheduledPatientLocationItems = 0
        
        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'cScheduledPatientLocationItems' is [\(cScheduledPatientLocationItems)]...")
  
        return cScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->Int.

}   // End of struct AppLocationView(View).

#Preview 
{
    
    AppLocationView(jmAppParseCoreManager:JmAppParseCoreManager())
    
}


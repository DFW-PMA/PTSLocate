//
//  AppLocationMapView.swift
//  PTSLocate
//
//  Created by Daryl Cox on 11/18/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI
import MapKit

struct AppLocationMapView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLocationMapView"
        static let sClsVers      = "v1.0817"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

           private let fMapLatLongTolerance:Double               = 0.0025

    @State private var cAppMapTapPresses:Int                     = 0

#if os(iOS)

    @State private var cAppTidScheduleViewButtonPresses:Int      = 0

    @State private var isAppTidScheduleViewModal:Bool            = false

#endif

    @State private var isAppMapTapAlertShowing:Bool              = false
    @State private var sMapTapMsg:String                         = ""

    @State         var parsePFCscDataItem:ParsePFCscDataItem

                   var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(parsePFCscDataItem:ParsePFCscDataItem)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'parsePFCscDataItem' parameter...

        self._parsePFCscDataItem = State(initialValue: parsePFCscDataItem)

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'parsePFCscDataItem' at [\(parsePFCscDataItem)] value is [\(parsePFCscDataItem.toString())]...")

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
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)]...")

        let sPFTherapistParseTID:String
            = self.convertPFCscDataItemToTid(pfCscDataItem:parsePFCscDataItem)
        let listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
            = self.getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:parsePFCscDataItem)

        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] TID #(\(sPFTherapistParseTID)) Visits #(\(listScheduledPatientLocationItems.count))...")

        GeometryReader
        { proxy in

            ScrollView
            {

                HStack(alignment:.center)
                {

                    Spacer()

                    VStack
                    {

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("Map #(\(parsePFCscDataItem.idPFCscObject))::\(parsePFCscDataItem.sPFCscParseName)")
                                .font(.caption)
                                .bold()
                                .italic()
                                .font(.footnote)

                            Spacer()

                        }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("TID #(\(sPFTherapistParseTID)) Visits #(\(listScheduledPatientLocationItems.count))")
                                .font(.caption)
                                .bold()
                                .italic()
                                .font(.footnote)

                            Spacer()

                        }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("\(parsePFCscDataItem.sCurrentLocationName), \(parsePFCscDataItem.sCurrentCity) \(parsePFCscDataItem.sCurrentPostalCode)")
                                .font(.caption)

                            Spacer()

                        }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text(parsePFCscDataItem.sPFCscParseLastLocDate)
                                .gridColumnAlignment(.center)
                                .font(.caption)
                            Text(" @ ")
                                .gridColumnAlignment(.center)
                                .font(.caption)
                            Text(parsePFCscDataItem.sPFCscParseLastLocTime)
                                .gridColumnAlignment(.center)
                                .font(.caption)

                            Spacer()

                        }

                    }

                #if os(iOS)

                    Spacer()

                    Button
                    {

                        self.cAppTidScheduleViewButtonPresses += 1

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationMapView in Button(Xcode).'App TID Schedule View'.#(\(self.cAppTidScheduleViewButtonPresses))...")

                        self.isAppTidScheduleViewModal.toggle()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "doc.text.magnifyingglass")
                                .help(Text("App TID/Patient Schedule Viewer"))
                                .imageScale(.large)

                            Text("Schedule")
                                .font(.caption)

                        }

                    }
                    .fullScreenCover(isPresented:$isAppTidScheduleViewModal)
                    {

                        AppTidScheduleView(listScheduledPatientLocationItems:listScheduledPatientLocationItems)

                    }
                    .padding()

                #endif

                }

                VStack
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).VStack - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] 'clLocationCoordinate2D' is [\(parsePFCscDataItem.clLocationCoordinate2D)]...")

                    MapReader
                    { proxy in

                        Map(initialPosition:parsePFCscDataItem.mapPosition)
                        {

                            Marker("+", 
                                   systemImage:"mappin.and.ellipse", 
                                   coordinate: parsePFCscDataItem.clLocationCoordinate2D)
                                .tint(.red)

                            if (listScheduledPatientLocationItems.count > 0)
                            {

                                ForEach(listScheduledPatientLocationItems)
                                { scheduledPatientLocationItem in

                                    Marker(scheduledPatientLocationItem.sVDateStartTime,
                                           systemImage:"cross.case.circle",
                                           coordinate: scheduledPatientLocationItem.clLocationCoordinate2DPatLoc)
                                    .tint(.yellow)

                                }
                            
                            }

                        }
                        .onTapGesture 
                        { position in
                      
                            self.cAppMapTapPresses   += 1
                            let coordinate            = proxy.convert(position, from:.local)
                            let sMapTapLogMsg:String  = "Map 'tap' #(\(cAppMapTapPresses)) - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] tapped at 'position' [\(position)] 'coordinate' at [\(String(describing: coordinate))]..."
                            self.sMapTapMsg           = "\(parsePFCscDataItem.sPFCscParseName) at \(parsePFCscDataItem.sCurrentLocationName),\(parsePFCscDataItem.sCurrentCity) on \(parsePFCscDataItem.sPFCscParseLastLocDate)::\(parsePFCscDataItem.sPFCscParseLastLocTime)"
                      
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(self.sMapTapMsg)...")
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(sMapTapLogMsg)...")
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] 'clLocationCoordinate2D' is [\(parsePFCscDataItem.clLocationCoordinate2D)]...")
                      
                            let bIsTapClose:Bool = self.checkIfAppLocationIsCloseToCoordinate(location:  parsePFCscDataItem.clLocationCoordinate2D, 
                                                                                              coordinate:(coordinate ?? CLLocationCoordinate2D(latitude: 0.0000,
                                                                                                                                               longitude:0.0000)))
                      
                            if (bIsTapClose == true)
                            {
                      
                                self.isAppMapTapAlertShowing.toggle()
                      
                            }
                      
                        }
                        .alert(self.sMapTapMsg, isPresented:$isAppMapTapAlertShowing)
                        {
                            Button("Ok", role:.cancel)
                            {
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).MapReader.Map.onTapGesture User pressed 'Ok' to the Map 'tap' alert...")
                            }
                        }

                    }

                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment:.center)
                .ignoresSafeArea()

            }

        }
        
    }
    
    private func checkIfAppLocationIsCloseToCoordinate(location:CLLocationCoordinate2D, coordinate:CLLocationCoordinate2D)->Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameters 'location' is [\(location)] - 'coordinate' is [\(coordinate)]...")

        var bIsCoordinateCloseToLocation:Bool          = false
        var bIsCoordinateCloseToLocationLatitude:Bool  = false
        var bIsCoordinateCloseToLocationLongitude:Bool = false
  
        // Check the Latitude/Longitude of the 'location' vs 'coordinate' and return a 'close' boolean (base on 'tollerance')...

        bIsCoordinateCloseToLocationLatitude  = (abs(location.latitude  - coordinate.latitude)  < self.fMapLatLongTolerance)
        bIsCoordinateCloseToLocationLongitude = (abs(location.longitude - coordinate.longitude) < self.fMapLatLongTolerance)

        if (bIsCoordinateCloseToLocationLatitude  == true &&
            bIsCoordinateCloseToLocationLongitude == true)
        {

            bIsCoordinateCloseToLocation = true

        }
        else
        {

            bIsCoordinateCloseToLocation = false

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bIsCoordinateCloseToLocation' is [\(String(describing: bIsCoordinateCloseToLocation))]...")
  
        return bIsCoordinateCloseToLocation
  
    }   // End of private func checkIfAppParseCoreHasPFCscDataItems().

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

}

#Preview 
{
    
    AppLocationMapView(parsePFCscDataItem:ParsePFCscDataItem())
    
}


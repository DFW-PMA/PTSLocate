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
        static let sClsVers      = "v1.0417"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

           private let fMapLatLongTolerance:Double               = 0.0025
    @State private var fMapLatLongToleranceZoom:Double           = 0.0025
    @State private var fCurrentZoom:Double                       = 0.0
    @State private var fTotalZoom:Double                         = 0.0
    @GestureState
           private var gestureStateZoom                          = 1.0
    
    @State private var cAppMapTapPresses:Int                     = 0

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

        GeometryReader
        { proxy in

            ScrollView
            {

                VStack
                {

                    Text("Map #(\(parsePFCscDataItem.idPFCscObject))::\(parsePFCscDataItem.sPFCscParseName)")
                        .bold()
                        .italic()
                        .font(.footnote)

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

                //  let sMapLocationName:String                       = "#(\(parsePFCscDataItem.idPFCscObject))::\(parsePFCscDataItem.sPFCscParseName)"
                    let clLocationCoordinate2D:CLLocationCoordinate2D = CLLocationCoordinate2D(
                                                                            latitude:  parsePFCscDataItem.dblConvertedLatitude,
                                                                            longitude: parsePFCscDataItem.dblConvertedLongitude)
                    let mapCoordinateRegion                           = MKCoordinateRegion(
                                                                            center:clLocationCoordinate2D,
                                                                              span:MKCoordinateSpan(latitudeDelta: 0.05,                                         
                                                                                                    longitudeDelta:0.05))
                    let mapPosition                                   = MapCameraPosition.region(mapCoordinateRegion)

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).VStack - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] 'clLocationCoordinate2D' is [\(clLocationCoordinate2D)]...")

                    MapReader
                    { proxy in

                        Map(initialPosition:mapPosition)
                        {

                            Marker("+", systemImage: "mappin.and.ellipse", coordinate:clLocationCoordinate2D)
                            //  .contentShape(Circle())    // NOT available on a Marker()...

                        }
                        .onTapGesture 
                        { position in

                            self.cAppMapTapPresses   += 1
                            let coordinate            = proxy.convert(position, from:.local)
                            let sMapTapLogMsg:String  = "Map 'tap' #(\(cAppMapTapPresses)) - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] tapped at 'position' [\(position)] 'coordinate' at [\(String(describing: coordinate))]..."
                            self.sMapTapMsg           = "\(parsePFCscDataItem.sPFCscParseName) at \(parsePFCscDataItem.sCurrentLocationName),\(parsePFCscDataItem.sCurrentCity) on \(parsePFCscDataItem.sPFCscParseLastLocDate)::\(parsePFCscDataItem.sPFCscParseLastLocTime)"

                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - 'fCurrentZoom' is [\(self.fCurrentZoom)] - 'fTotalZoom' is [\(self.fTotalZoom)] - 'gestureStateZoom' is [\(self.gestureStateZoom)]...")
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(self.sMapTapMsg)...")
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - \(sMapTapLogMsg)...")
                            let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View).MapReader.Map.onTapGesture - Map #(\(parsePFCscDataItem.idPFCscObject)) for [\(parsePFCscDataItem.sPFCscParseName)] 'clLocationCoordinate2D' is [\(clLocationCoordinate2D)]...")

                            let bIsTapClose:Bool = self.checkIfAppLocationIsCloseToCoordinate(location:  clLocationCoordinate2D, 
                                                                                              coordinate:coordinate ?? CLLocationCoordinate2D(latitude: 0.0000,
                                                                                                                                              longitude:0.0000))

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
                        .gesture(
                            MagnifyGesture()
                                .onChanged 
                                { value in
                                    fCurrentZoom = value.magnification - 1
                                }
                                .onEnded 
                                { value in
                                    fTotalZoom   += fCurrentZoom
                                    fCurrentZoom  = 0
                                }
                                .updating($gestureStateZoom)
                                { value, gestureState, transaction in
                                    gestureState = value.magnification
                                })
                        .accessibilityZoomAction 
                        { action in
                            if action.direction == .zoomIn 
                            {
                                fTotalZoom += 1
                            } 
                            else 
                            {
                                fTotalZoom -= 1
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

}

#Preview 
{
    
    AppLocationMapView(parsePFCscDataItem:ParsePFCscDataItem())
    
}


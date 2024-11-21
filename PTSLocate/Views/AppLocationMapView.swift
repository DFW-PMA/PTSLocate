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
        static let sClsVers      = "v1.0301"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
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

                        Text("\(parsePFCscDataItem.sCurrentLocationName), \(parsePFCscDataItem.sCurrentCity)  \(parsePFCscDataItem.sCurrentPostalCode)")
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

                    Map(initialPosition:mapPosition)
                    {

                        Marker("+", systemImage: "mappin.and.ellipse", coordinate:clLocationCoordinate2D)

                    }

                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment:.center)
                .ignoresSafeArea()

            }

        }
        
    }
    
}

#Preview 
{
    
    AppLocationMapView(parsePFCscDataItem:ParsePFCscDataItem())
    
}


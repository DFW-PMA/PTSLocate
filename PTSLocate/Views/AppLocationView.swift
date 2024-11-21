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
        static let sClsVers      = "v1.0301"
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
        
    //  NavigationView
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

                    //  let _ = self.checkIfAppParseCoreHasPFInstallationCurrent()
                        let _ = self.checkIfAppParseCoreHasPFCscDataItems()

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

                            //  NavigationLink(destination: AppLocationMapView(parsePFCscDataItem:pfCscObject).navigationBarBackButtonHidden(true))
                            //  NavigationLink(destination: AppLocationMapView(parsePFCscDataItem:pfCscObject).navigationBarBackButtonHidden(false))
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
                                    .onChange(of: jmAppParseCoreManager.cPFCscObjectsRefresh)
                                    {
                                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - GridRow(Item(s)) #(\(pfCscObject.idPFCscObject)) for [\(pfCscObject.sPFCscParseName)] received a 'refresh' COUNT update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh))...")
                                    }

                            }

                        }

                    }
                    .onReceive(jmAppParseCoreManager.timerPublisher,
                        perform:
                        { dtObserved in

                            self.cAppLocationViewRefreshAutoTimer += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive - Grid.Timer<notification> - setting auto 'refresh' by timer to #(\(self.cAppLocationViewRefreshAutoTimer))...")

                        //  let _ = self.checkIfAppParseCoreHasPFInstallationCurrent()
                            let _ = self.checkIfAppParseCoreHasPFCscDataItems()

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

//  private func checkIfAppParseCoreHasPFInstallationCurrent() -> Bool
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' is [\(String(describing: jmAppDelegateVisitor))] - details are [\(jmAppDelegateVisitor.toString())]...")
//
//      if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
//      {
//
//          self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent'...")
//
//          let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.getJmAppParsePFInstallationCurrentInstance()
//
//          self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent'...")
//
//      }
//      else
//      {
//
//          self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent' - 'jmAppParseCoreManager' is nil - Error!")
//
//      }
//
//      var bWasAppPFInstallationCurrentPresent:Bool = false
//
//      if (jmAppDelegateVisitor.jmAppParseCoreManager == nil)
//      {
//
//          self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' has a 'jmAppParseCoreManager' that is nil - 'bWasAppPFInstallationCurrentPresent' is [\(String(describing: bWasAppPFInstallationCurrentPresent))]...")
//
//          bWasAppPFInstallationCurrentPresent = false
//
//      }
//      else
//      {
//
//          if (jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent == nil)
//          {
//
//              self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is nil...")
//
//              if (jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent == nil)
//              {
//
//                  self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is STILL nil...")
//
//                  bWasAppPFInstallationCurrentPresent = false
//
//              }
//              else
//              {
//
//                  self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent))]...")
//
//                  bWasAppPFInstallationCurrentPresent = true
//
//              }
//
//          }
//          else
//          {
//
//              self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent))]...")
//
//              bWasAppPFInstallationCurrentPresent = true
//
//          }
//
//      }
//      
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFInstallationCurrentPresent' is [\(String(describing: bWasAppPFInstallationCurrentPresent))]...")
//
//      return bWasAppPFInstallationCurrentPresent
//
//  }   // End of private func checkIfAppParseCoreHasPFInstallationCurrent().

}

#Preview 
{
    
    AppLocationView(jmAppParseCoreManager:JmAppParseCoreManager())
    
}


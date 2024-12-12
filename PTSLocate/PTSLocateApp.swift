//
//  PTSLocateApp.swift
//  PTSLocate
//
//  Created by Daryl Cox on 07/19/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

@main
struct PTSLocateApp: App 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "PTSLocateApp"
        static let sClsVers      = "v1.1501"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // AppDelegate:
    //     (NOTE: This causes the AppDelegate class to instantiate
    //            - use this ONLY once in an App or it will cause multiple instantiation(s) of AppDelegate...

#if os(macOS)

    @NSApplicationDelegateAdaptor(PTSLocateNSAppDelegate.self)
    var appDelegate

#elseif os(iOS)

    @UIApplicationDelegateAdaptor(PTSLocateUIAppDelegate.self)
    var appDelegate

#endif

    // App Data field(s):

    let sAppBundlePath:String                     = Bundle.main.bundlePath

    var sharedModelContainer:ModelContainer       =
    {
        
        let schema             = Schema([PFAdminsSwiftDataItem.self, ])
        let modelConfiguration = ModelConfiguration(schema:schema, isStoredInMemoryOnly:false)

        do
        {
            
            return try ModelContainer(for:schema, configurations:[modelConfiguration])
            
        }
        catch
        {
            
            fatalError("Could not create ModelContainer: \(error)...")
            
        }
    }()

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
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

    var body: some Scene 
    {
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) - 'sAppBundlePath' is [\(sAppBundlePath)]...")
        
        WindowGroup 
        {
            
            AppAuthenticateView()
                .navigationTitle(AppGlobalInfo.sGlobalInfoAppId)
                .onOpenURL(perform: 
                { url in
                    
                    self.xcgLogMsg("\(ClassInfo.sClsDisp):AuthenticateView.onOpenURL() performed for the URL of [\(url)]...")

                })

        }
        .handlesExternalEvents(matching: [])
        .modelContainer(sharedModelContainer)
    #if os(macOS)
        .commands
        {

            AppInfoCommands()

            HelpCommands()

        }
    #endif
        
    #if os(macOS)
        Settings
        {
      
            SettingsSingleView()
      
        }
    #endif
        
    }
    
}   // End of struct PTSLocateApp(App). 


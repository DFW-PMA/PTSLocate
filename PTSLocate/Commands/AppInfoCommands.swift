//
//  AppInfoCommands.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 05/17/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct AppInfoCommands: Commands 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppInfoCommands"
        static let sClsVers      = "v1.0601"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Do NOT use this <here> - @EnvironmentObject has NO AppDelegate (causes a CRASH).
    //     The 'var body: some Commands' is NOT in the parental Tree structure of the App (and ContentView).
    // AppDelegate (via @EnvironmentObject - automatic via the App's @NSApplicationDelegateAdaptor property wrapper

    // @EnvironmentObject private var appDelegate:PTSLocateNSAppDelegate

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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

    var body: some Commands
    {
        
        CommandGroup(replacing: .appInfo) 
        {

            Button("About \(AppGlobalInfo.sGlobalInfoAppId)")
            {

                NSApplication.shared.orderFrontStandardAboutPanel(
                    options: [NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "\(JmXcodeBuildSettings.jmAppCopyright)",
                              NSApplication.AboutPanelOptionKey.credits: 
                                  NSAttributedString(string: "Log file at \((jmAppDelegateVisitor.sAppDelegateVisitorLogFilespec ?? "-N-A-")) (Usable [\(jmAppDelegateVisitor.bAppDelegateVisitorLogFilespecIsUsable)])",
                                                     attributes: [NSAttributedString.Key.font: NSFont.messageFont(ofSize: NSFont.smallSystemFontSize)]
                                                     ),
                             ]

                    )

            }

        }

    }
    
}   // End of struct AppInfoCommands(Commands). 


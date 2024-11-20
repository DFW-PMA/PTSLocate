//
//  SettingsSingleViewMac.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 03/26/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct SettingsSingleViewMac: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "SettingsSingleViewMac"
        static let sClsVers      = "v1.0501"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

    @State private var cContentViewAppCrashButtonPresses:Int = 0

    @State private var isAppCrashShowing:Bool                = false

    var jmAppDelegateVisitor:JmAppDelegateVisitor            = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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

    var body: some View 
    {
        
        let _ = self.xcgLogMsg("...'SettingsSingleViewMac(.swift):body' \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")

        VStack(alignment:.leading)              // VStack #1
        {

            Spacer()
            
            Divider()
            
            Spacer()
                .frame(height:15)

            HStack(alignment:.center)
            {

                Spacer()

                Text(" - - - - - - - - - - - - - - - ")
                    .bold()

                Spacer()

            }

            HStack(alignment:.center)
            {

                Spacer()

                VStack(alignment:.center)
                {

                    if #available(iOS 15.0, *) 
                    {
                        Text("Application Information:")
                            .bold()
                            .dynamicTypeSize(.small)

                        Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                            .italic()
                            .dynamicTypeSize(.small)

                        Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                            .italic()
                            .dynamicTypeSize(.small)
                    }
                    else
                    {
                        Text("Application Information:")
                            .bold()

                        Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                            .italic()

                        Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                            .italic()
                    }

                }

                Spacer()

            }

            HStack(alignment:.center)
            {

                Spacer()

                Text(" - - - - - - - - - - - - - - - ")
                    .bold()

                Spacer()

            }
            
            Spacer()

            if (AppGlobalInfo.bPerformAppDevTesting == true)
            {

                Spacer()

                VStack(alignment:.leading)
                {

                    Divider()
                        .background(Color.primary)

                    HStack(alignment:.center)
                    {

                        Spacer()

                        Text("Press to FORCE an App 'crash' -> ")
                            .bold()

                        Button
                        {

                            self.cContentViewAppCrashButtonPresses += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)SettingsSingleViewMac in Button(Xcode).'App Crash'.#(\(self.cContentViewAppCrashButtonPresses))...")

                            self.isAppCrashShowing.toggle()

                        }
                        label: 
                        {

                            Label("", systemImage: "xmark.octagon")
                                .help(Text("FORCE this App to CRASH"))

                        }
                        .alert("Are you sure you want to 'crash' this App?", isPresented:$isAppCrashShowing)
                        {
                            Button("Cancel", role:.cancel)
                            {
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'crash' the App - resuming...")
                            }
                            Button("Ok", role:.destructive)
                            {
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'crash' the App - crashing...")
                                fatalError("The User pressed 'Ok' to force an App 'crash'!")
                            }
                        }

                        Spacer()

                    }

                    Divider()
                        .background(Color.primary)

                }

            }

            Spacer()

        }   // End of VStack #1
        
    }
    
}

#Preview 
{
    
    SettingsSingleViewMac()
    
}


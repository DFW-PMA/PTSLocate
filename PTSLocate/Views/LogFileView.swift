//
//  LogFileView.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 03/20/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import QuickLook

struct LogFileView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "LogFileView"
        static let sClsVers        = "v1.1203"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

    @Environment(\.presentationMode) var presentationMode

    @State private var cLogFileViewAppLogClearButtonPresses:Int = 0

    @State private var isAppLogClearShowingAlert:Bool           = false
    
#if os(macOS)

    private let pasteboard = NSPasteboard.general

#elseif os(iOS)

    private let pasteboard = UIPasteboard.general

#endif

    @State  var logFileUrl:URL?
    
    var jmAppDelegateVisitor:JmAppDelegateVisitor               = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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
        
        VStack
        {

        #if os(iOS)

            HStack(alignment:.center)           // HStack #1.3
            {

            //  Spacer()

            //  Button("Preview Log file") 
                Button
                {

                    self.logFileUrl = self.jmAppDelegateVisitor.urlAppDelegateVisitorLogFilespec

                    xcgLogMsg("\(ClassInfo.sClsDisp):LogFileView.Button('Preview Log file') performed for the URL of [\(String(describing: self.logFileUrl))]...")

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "text.viewfinder")
                            .help(Text("Preview the LOG file..."))
                            .imageScale(.large)

                        Text("Preview LOG")
                            .font(.caption)

                    }

                }
                .quickLookPreview($logFileUrl)
                .padding()

                Spacer()

                Button
                {

                    self.cLogFileViewAppLogClearButtonPresses += 1

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):LogFileView in Button(Xcode).'App Log 'Clear'.#(\(self.cLogFileViewAppLogClearButtonPresses))'...")

                    self.jmAppDelegateVisitor.clearAppDelegateVisitorTraceLogFile()

                    self.isAppLogClearShowingAlert = true

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "clear")
                            .help(Text("Clear the LOG file..."))
                            .imageScale(.large)

                        Text("Clear LOG")
                            .font(.caption)

                    }

                }
                .alert("App Log has been 'Cleared'...", isPresented:$isAppLogClearShowingAlert)
                {

                    Button("Ok", role:.cancel) { }

                }

                Spacer()

                Button
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppAboutView.Button(Xcode).'Dismiss' pressed...")

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

            }   // End of HStack #1.1

        #endif

            Spacer()

            Text("Log file:")
                .font(.callout)
                .contextMenu
                {
                
                    Button
                    {
                        
                        let _ = xcgLogMsg("...\(ClassInfo.sClsDisp):ContentView in Text.contextMenu.'copy' button #1...")
                        
                        copyLogFilespecToClipboard()
                        
                    }
                    label:
                    {
                        
                        Text("Copy to Clipboard")
                        
                    }
                
                }

            Text("")

            Text(self.jmAppDelegateVisitor.sAppDelegateVisitorLogFilespec ?? "...empty...")
                .contextMenu
                {
                
                    Button
                    {
                        
                        let _ = xcgLogMsg("...\(ClassInfo.sClsDisp):ContentView in Text.contextMenu.'copy' button #2...")
                        
                        copyLogFilespecToClipboard()
                        
                    }
                    label:
                    {
                        
                        Text("Copy to Clipboard")
                        
                    }
                
                }

            Spacer()

        }
        
    }
    
    func copyLogFilespecToClipboard()
    {
        
        xcgLogMsg("...\(ClassInfo.sClsDisp):ContentView in ContextMenu.copyLogFilespecToClipboard() for text of [\(jmAppDelegateVisitor.sAppDelegateVisitorLogFilespec!)]...")
        
    #if os(macOS)

        pasteboard.prepareForNewContents()
        pasteboard.setString(jmAppDelegateVisitor.sAppDelegateVisitorLogFilespec!, forType: .string)

    #elseif os(iOS)

        pasteboard.string = jmAppDelegateVisitor.sAppDelegateVisitorLogFilespec!

    #endif

        return
        
    }   // End of func copyLogFilespecToClipboard().
    
}

#Preview 
{
    
    LogFileView()
    
}


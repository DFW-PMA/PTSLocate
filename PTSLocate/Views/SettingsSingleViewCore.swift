//
//  SettingsSingleViewCore.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 11/25/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import SwiftUI

struct SettingsSingleViewCore: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "SettingsSingleViewCore"
        static let sClsVers      = "v1.0108"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):
    
//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
           private var bInternalZipTest:Bool                     = false

#if os(iOS)

    @State private var cAppAboutButtonPresses:Int                = 0
    @State private var cAppHelpViewButtonPresses:Int             = 0
    @State private var cAppLogViewButtonPresses:Int              = 0

    @State private var cAppZipFileButtonPresses:Int              = 0
    @State private var cAppCrashButtonPresses:Int                = 0

    @State private var cAppReleaseUpdateButtonPresses:Int        = 0
    @State private var cAppPreReleaseUpdateButtonPresses:Int     = 0

    @State private var isAppAboutViewModal:Bool                  = false
    @State private var isAppHelpViewModal:Bool                   = false
    @State private var isAppLogViewModal:Bool                    = false

    @State private var isAppZipFileShowing:Bool                  = false
    @State private var isAppCrashShowing:Bool                    = false

    @State private var isAppDownloadReleaseUpdateShowing:Bool    = false
    @State private var isAppDownloadPreReleaseUpdateShowing:Bool = false

#endif
    
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

    var body: some View 
    {
        
        let _ = self.xcgLogMsg("...'SettingsSingleViewCore(.swift):body' \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")

        Spacer()

        VStack(alignment:.leading)
        {

            Spacer()
                .frame(height:5)
            
        #if os(iOS)
      
            HStack(alignment:.center)
            {
      
                Button
                {
      
                    self.cAppAboutButtonPresses += 1
      
                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore in Button(Xcode).'App About'.#(\(self.cAppAboutButtonPresses))...")
      
                    self.isAppAboutViewModal.toggle()
      
                }
                label:
                {
                    
                    VStack(alignment:.center)
                    {
                        
                        Label("", systemImage: "questionmark.diamond")
                            .help(Text("App About Information"))
                            .imageScale(.large)
                        
                        Text("About")
                            .font(.caption)
                        
                    }
                    
                }
                .fullScreenCover(isPresented:$isAppAboutViewModal)
                {
                
                    AppAboutView()
                
                }
      
                Spacer()
      
                Button
                {
      
                    self.cAppHelpViewButtonPresses += 1
      
                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore in Button(Xcode).'App HelpView'.#(\(self.cAppHelpViewButtonPresses))...")
      
                    self.isAppHelpViewModal.toggle()
      
                }
                label:
                {
                    
                    VStack(alignment:.center)
                    {
                        
                        Label("", systemImage: "questionmark.circle")
                            .help(Text("App HELP Information"))
                            .imageScale(.large)
                        
                        Text("Help")
                            .font(.caption)
                        
                    }
                    
                }
                .fullScreenCover(isPresented:$isAppHelpViewModal)
                {
                
                    HelpBasicView(sHelpBasicContents: jmAppDelegateVisitor.getAppDelegateVisitorHelpBasicContents())
                        .navigationBarBackButtonHidden(true)
                
                }
      
                Spacer()
      
                Button
                {
      
                    self.cAppLogViewButtonPresses += 1
      
                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore in Button(Xcode).'App LogView'.#(\(self.cAppLogViewButtonPresses))...")
      
                    self.isAppLogViewModal.toggle()
      
                }
                label:
                {
                    
                    VStack(alignment:.center)
                    {
                        
                        Label("", systemImage: "doc.text.magnifyingglass")
                            .help(Text("App LOG Viewer"))
                            .imageScale(.large)
                        
                        Text("View Log")
                            .font(.caption)
                        
                    }
                    
                }
                .fullScreenCover(isPresented:$isAppLogViewModal)
                {
                
                    LogFileView()
                
                }
      
                Spacer()
      
                Button
                {
      
                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore.Button(Xcode).'Dismiss' pressed...")
                    
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
      
            }
      
            Spacer()
            
        #endif
      
            VStack(alignment:.center)
            {
      
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
                            Text("Application Setting(s):")
                                .bold()
                                .dynamicTypeSize(.small)
                        //
                        //  Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                        //      .italic()
                        //      .dynamicTypeSize(.small)
                        //
                        //  Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                        //      .italic()
                        //      .dynamicTypeSize(.small)
                        }
                        else
                        {
                            Text("Application Setting(s):")
                                .bold()
                        //
                        //  Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                        //      .italic()
                        //
                        //  Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                        //      .italic()
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
      
            }
      
            Spacer()
      
            if (AppGlobalInfo.bPerformAppDevTesting == true)
            {
      
                Spacer()
      
                HStack(alignment:.center)
                {
      
                    Spacer()
      
                    Button
                    {
      
                        self.cAppZipFileButtonPresses += 1
      
                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)SettingsSingleViewCore in Button(Xcode).'App ZipFile'.#(\(self.cAppZipFileButtonPresses))...")
      
                        self.isAppZipFileShowing.toggle()
      
                    }
                    label:
                    {
      
                        VStack(alignment:.center)
                        {
      
                            Label("", systemImage: "square.resize.down")
                                .help(Text("Test this App creating a ZIP File"))
                                .imageScale(.large)
      
                            Text("Test ZIP File")
                                .font(.caption)
      
                        }
      
                    }
                    .alert("Are you sure you want to TEST this App 'creating' a ZIP File?", isPresented:$isAppZipFileShowing)
                    {
                        Button("Cancel", role:.cancel)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'test' the App ZIP File - resuming...")
                        }
                        Button("Ok", role:.destructive)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'test' the App ZIP File - testing...")
      
                            self.uploadCurrentAppLogToDevs()
                        }
                    }
      
                    Spacer()
      
                    Button
                    {
      
                        self.cAppCrashButtonPresses += 1
      
                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)SettingsSingleViewCore in Button(Xcode).'App Crash'.#(\(self.cAppCrashButtonPresses))...")
      
                        self.isAppCrashShowing.toggle()
      
                    }
                    label:
                    {
      
                        VStack(alignment:.center)
                        {
      
                            Label("", systemImage: "autostartstop.slash")
                                .help(Text("FORCE this App to CRASH"))
                                .imageScale(.large)
      
                            Text("Force CRASH")
                                .font(.caption)
      
                        }
      
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
      
            }
      
        #if os(iOS)
      
            Spacer()
      
            VStack(alignment:.center)
            {
      
                HStack(alignment:.center)
                {
      
                    Spacer()
      
                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .bold()
      
                    Spacer()
      
                }
      
                HStack(alignment:.center)
                {
      
                    Spacer()
      
                    Button
                    {
      
                        self.cAppReleaseUpdateButtonPresses += 1
      
                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore in Button(Xcode).'App 'download' Release'.#(\(self.cAppReleaseUpdateButtonPresses))...")
      
                        self.isAppDownloadReleaseUpdateShowing.toggle()
      
                    }
                    label: 
                    {
      
                    if #available(iOS 14.0, *) 
                    {
      
                        VStack(alignment:.center)
                        {
      
                            Label("", systemImage: "arrow.down.app")
                                .help(Text("App 'download' RELEASE"))
                                .imageScale(.large)
      
                            Text("Download RELEASE")
                                .font(.caption)
      
                        }
      
                    } 
                    else
                    {
      
                        Text("App 'download' RELEASE")
      
                    }
      
                    }
                    .alert("Do you want to 'download' (and install) the App RELEASE?", isPresented:$isAppDownloadReleaseUpdateShowing)
                    {
                        Button("Cancel", role:.cancel)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'download' the App RELEASE - resuming...")
                        }
                        Button("Ok", role:.destructive)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'download' the App RELEASE - updating...")
      
                            self.downloadAppReleaseUpdate()
      
                        }
                    }
                    .padding()
      
                    Spacer()
      
                    Button
                    {
      
                        self.cAppPreReleaseUpdateButtonPresses += 1
      
                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):SettingsSingleViewCore in Button(Xcode).'App 'download' Pre-Release'.#(\(self.cAppPreReleaseUpdateButtonPresses))...")
      
                        self.isAppDownloadPreReleaseUpdateShowing.toggle()
      
                    }
                    label: 
                    {
      
                    if #available(iOS 14.0, *) 
                    {
      
                        VStack(alignment:.center)
                        {
      
                            Label("", systemImage: "arrow.down.app.fill")
                                .help(Text("App 'download' Pre-Release"))
                                .imageScale(.large)
      
                            Text("Download Pre-Release")
                                .font(.caption)
      
                        }
      
                    } 
                    else 
                    {
      
                        Text("App 'download' Pre-Release")
      
                    }
      
                    }
                    .alert("Do you want to 'download' (and install) the App Pre-Release?", isPresented:$isAppDownloadPreReleaseUpdateShowing)
                    {
                        Button("Cancel", role:.cancel)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'download' the App Pre-Release - resuming...")
                        }
                        Button("Ok", role:.destructive)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'download' the App Pre-Release - updating...")
      
                            self.downloadAppPreReleaseUpdate()
      
                        }
                    }
                    .padding()
      
                    Spacer()
      
                }

                HStack(alignment:.center)
                {
      
                    Spacer()
      
                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .bold()
      
                    Spacer()
      
                }
      
            }
      
        #endif

            Spacer()

        }
        .padding()

    }

    private func uploadCurrentAppLogToDevs()
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Prepare specifics to 'upload' the AppLog file...

        var urlAppDelegateVisitorLogFilepath:URL?     = nil
        var urlAppDelegateVisitorLogFilespec:URL?     = nil
        var sAppDelegateVisitorLogFilespec:String!    = nil
        var sAppDelegateVisitorLogFilepath:String!    = nil
        var sAppDelegateVisitorLogFilenameExt:String! = nil

        do 
        {

            urlAppDelegateVisitorLogFilepath  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask ,appropriateFor: nil, create: true)
            urlAppDelegateVisitorLogFilespec  = urlAppDelegateVisitorLogFilepath?.appendingPathComponent(AppGlobalInfo.sGlobalInfoAppLogFilespec)
            sAppDelegateVisitorLogFilespec    = urlAppDelegateVisitorLogFilespec?.path
            sAppDelegateVisitorLogFilepath    = urlAppDelegateVisitorLogFilepath?.path
            sAppDelegateVisitorLogFilenameExt = urlAppDelegateVisitorLogFilespec?.lastPathComponent

            self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilespec'    (computed) is [\(String(describing: sAppDelegateVisitorLogFilespec))]...")
            self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilepath'    (resolved #2) is [\(String(describing: sAppDelegateVisitorLogFilepath))]...")
            self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilenameExt' (computed) is [\(String(describing: sAppDelegateVisitorLogFilenameExt))]...")

        }
        catch
        {

            self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to 'stat' item(s) in the 'path' of [.documentDirectory] - Error: \(error)...")

        }

        // Check that the 'current' App LOG file 'exists'...

        let bIsCurrentAppLogFilePresent:Bool = JmFileIO.fileExists(sFilespec:sAppDelegateVisitorLogFilespec)

        if (bIsCurrentAppLogFilePresent == true)
        {

            self.xcgLogMsg("[\(sCurrMethodDisp)] Preparing to Zip the 'source' filespec ('current' App LOG) of [\(String(describing: sAppDelegateVisitorLogFilespec))]...")

        }
        else
        {

            let sZipFileErrorMsg:String = "Unable to Zip the 'current' App LOG of [\(String(describing: sAppDelegateVisitorLogFilespec))] - the file does NOT Exist - Error!"

            DispatchQueue.main.async
            {

                self.jmAppDelegateVisitor.setAppDelegateVisitorSignalGlobalAlert("Alert::\(sZipFileErrorMsg)",
                                                                                 alertButtonText:"Ok")

            }

            self.xcgLogMsg("[\(sCurrMethodDisp)] \(sZipFileErrorMsg)")

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return

        }

        // Create the AppLog's 'multipartRequestInfo' object (but WITHOUT any Data (yet))...

        let multipartRequestInfo:MultipartRequestInfo = MultipartRequestInfo()

        multipartRequestInfo.bAppZipSourceToUpload    = false
        multipartRequestInfo.sAppUploadURL            = ""          // "" takes the Upload URL 'default'...
        multipartRequestInfo.sAppUploadNotifyTo       = ""          // This is email notification - "" defaults to all Dev(s)...
        multipartRequestInfo.sAppUploadNotifyCc       = ""          // This is email notification - "" defaults to 'none'...
        multipartRequestInfo.sAppSourceFilespec       = sAppDelegateVisitorLogFilespec
        multipartRequestInfo.sAppSourceFilename       = sAppDelegateVisitorLogFilenameExt
        multipartRequestInfo.sAppZipFilename          = sAppDelegateVisitorLogFilenameExt
        multipartRequestInfo.sAppSaveAsFilename       = sAppDelegateVisitorLogFilenameExt
        multipartRequestInfo.sAppFileMimeType         = "text/plain"

        // Create the AppLog's 'multipartRequestInfo.dataAppFile' object...

        multipartRequestInfo.dataAppFile              = FileManager.default.contents(atPath: sAppDelegateVisitorLogFilespec)

        self.xcgLogMsg("\(sCurrMethodDisp) The 'upload' is using 'multipartRequestInfo' of [\(String(describing: multipartRequestInfo.toString()))]...")

        // Attempting to 'zip' the file (content(s))...

        let multipartZipFileCreator:MultipartZipFileCreator = MultipartZipFileCreator()

        multipartRequestInfo.sAppZipFilename = multipartRequestInfo.sAppSourceFilename

        var urlCreatedZipFile:URL? = multipartZipFileCreator.createTargetZipFileFromSource(multipartRequestInfo:multipartRequestInfo)

        // Check if we actually got the 'target' Zip file created...

        if let urlCreatedZipFile = urlCreatedZipFile 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Produced a Zip file 'urlCreatedZipFile' of [\(urlCreatedZipFile)]...")

            multipartRequestInfo.sAppZipFilename  = "\(multipartRequestInfo.sAppZipFilename).zip"

        } 
        else 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Failed to produce a Zip file - the 'target' Zip filename was [\(multipartRequestInfo.sAppZipFilename)] - Error!")

            multipartRequestInfo.sAppZipFilename  = "-N/A-"
            multipartRequestInfo.sAppFileMimeType = "text/plain"
            multipartRequestInfo.dataAppFile      = FileManager.default.contents(atPath: sAppDelegateVisitorLogFilespec)

            self.xcgLogMsg("\(sCurrMethodDisp) Reset the 'multipartRequestInfo' to upload the <raw> file without 'zipping'...")

            urlCreatedZipFile = nil

        }

        // If this is NOT an 'internal' Zip 'test', then send the upload:

        if (bInternalZipTest == false)
        {

            // Send the AppLog as an 'upload' to the Server...

            let multipartRequestDriver:MultipartRequestDriver = MultipartRequestDriver(bGenerateResponseLongMsg:true)

            self.xcgLogMsg("\(sCurrMethodDisp) Using 'multipartRequestInfo' of [\(String(describing: multipartRequestInfo.toString()))]...")
            self.xcgLogMsg("\(sCurrMethodDisp) Calling 'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")

            multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:multipartRequestInfo)

            self.xcgLogMsg("\(sCurrMethodDisp) Called  'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of private func uploadCurrentAppLogToDevs().

#if os(iOS)

    private func downloadAppReleaseUpdate()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Open the URL that will download (and install) the App Release UPDATE...

        let urlToOpen:URL = URL(string:"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/DFW-PMA/PTSLocate/refs/heads/main/PTSLocate.plist")!

        self.xcgLogMsg("\(sCurrMethodDisp) Calling 'AppDelegate.openAppSuppliedURL(urlToOpen:)' to download and install the App Release on the URL of [\(urlToOpen)]...")

        self.openAppSuppliedURL(urlToOpen:urlToOpen)

        self.xcgLogMsg("\(sCurrMethodDisp) Called  'AppDelegate.openAppSuppliedURL(urlToOpen:)' to download and install the App Release on the URL of [\(urlToOpen)]...")

        // Suspend this App...

        self.xcgLogMsg("\(sCurrMethodDisp) Suspending this App...")

        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func downloadAppReleaseUpdate().

    private func downloadAppPreReleaseUpdate()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Open the URL that will download (and install) the App Release UPDATE...

        let urlToOpen:URL = URL(string:"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/DFW-PMA/PTSLocate/refs/heads/main/PTSLocate_Pre.plist")!

        self.xcgLogMsg("\(sCurrMethodDisp) Calling 'AppDelegate.openAppSuppliedURL(urlToOpen:)' to download and install the App Pre-Release on the URL of [\(urlToOpen)]...")

        self.openAppSuppliedURL(urlToOpen:urlToOpen)

        self.xcgLogMsg("\(sCurrMethodDisp) Called  'AppDelegate.openAppSuppliedURL(urlToOpen:)' to download and install the App Pre-Release on the URL of [\(urlToOpen)]...")

        // Suspend this App...

        self.xcgLogMsg("\(sCurrMethodDisp) Suspending this App...")

        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func downloadAppPreReleaseUpdate().

#endif

    private func openAppSuppliedURL(urlToOpen:URL)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'urlToOpen' is [\(urlToOpen)]...")

        // Open the supplied URL...

    #if os(macOS)

        NSWorkspace.shared.open(urlToOpen)

    #elseif os(iOS)

        UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)

    #endif

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func openAppSuppliedURL(urlToOpen:URL).

}   // END of struct SettingsSingleViewCore(View). 

#Preview 
{
    
    SettingsSingleViewCore()
    
}


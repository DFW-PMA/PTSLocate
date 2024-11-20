//
//  HelpBasicView.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 05/07/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

struct HelpBasicView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "HelpBasicView"
        static let sClsVers        = "v1.1001"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

#if os(iOS)

    @Environment(\.presentationMode) var presentationMode

#endif

    @AppStorage("helpBasicMode") var helpBasicMode             = HelpBasicMode.hypertext
    @State                       var sHelpBasicContents:String = "----NOT-Loaded-(View)----"

    var jmAppDelegateVisitor:JmAppDelegateVisitor              = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

// --------------------------------------------------------------------------------------------------------------------
// NOTE: ANSWER: see below - must access the variable name with a leading '_' and
//                     >>>   wrap the inbound parameter with a 'State()' method ('wrapper').
// --------------------------------------------------------------------------------------------------------------------
  
    init(sHelpBasicContents:String)
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sHelpBasicContents' is [\(sHelpBasicContents)]...")
  
    //  self.sHelpBasicContents  = sHelpBasicContents
        self._sHelpBasicContents = State(initialValue: sHelpBasicContents)
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting 'self.sHelpBasicContents' is [\(self.sHelpBasicContents)] - parameter 'sHelpBasicContents' was [\(sHelpBasicContents)]...")
    
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

                Spacer()

                Button
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):HelpBasicView.Button(Xcode).'Dismiss' pressed...")

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

            Spacer(minLength:5)

        #endif

            HStack
            {
                
                ScrollView(.vertical)
                {
                    
                    renderHELPContentsInTextView()
                    
                }
                
            }
            .padding()

        }
        
    }
    
    func renderHELPContentsInTextView() -> Text
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        var tfHELPContents:Text

        switch helpBasicMode
        {
            
        case .hypertext:
            do 
            {
                
            #if os(macOS)

                if let nsAttributedString = try? NSAttributedString(data:               Data(sHelpBasicContents.utf8), 
                                                                    options:            [.documentType: NSAttributedString.DocumentType.html], 
                                                                    documentAttributes: nil),
                   let attributedString   = try? AttributedString(nsAttributedString, including: \.appKit) 
                {

                    tfHELPContents = Text(attributedString)

                }
                else
                {

                    tfHELPContents = Text(sHelpBasicContents)

                }

            #elseif os(iOS)

                tfHELPContents = Text(sHelpBasicContents)

            #endif
                
            }
            
        case .markdown:
            do
            {
                
                tfHELPContents = Text(try! AttributedString(markdown: sHelpBasicContents))
                
            }
            
        case .simpletext:
            do
            {
                
                tfHELPContents = Text(sHelpBasicContents)
                
            }
            
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'tfHELPContents' is [\(tfHELPContents)]...")
        
        return tfHELPContents

    }   // End of func renderHELPContentsInTextView().

}

#Preview 
{
    
    HelpBasicView(sHelpBasicContents: "---HELP 'Basic' Preview---")
    
}


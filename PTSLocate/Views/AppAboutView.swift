//
//  AppAboutView.swift
//  VisitVerify
//
//  Created by Daryl Cox on 08/24/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
struct AppAboutView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppAboutView"
        static let sClsVers      = "v1.0901"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright © JustMacApps 2023-2024. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

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
        
        let _ = self.xcgLogMsg("...'AppAboutView(.swift):body' \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")

        VStack
        {

            Spacer()

            HStack(alignment:.center)
            {

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

            }

            Spacer()

            if #available(iOS 17.0, *)
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal)
                        { size, axis in
                            size * 0.15
                        }

            }
            else
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .frame(width:75, height: 75, alignment:.center)

            }

            Spacer()

            Text("\(JmXcodeBuildSettings.jmAppDisplayName)")
                .bold()
            Text("")
            Text("Application Category:")
                .bold()
                .italic()
            Text("\(JmXcodeBuildSettings.jmAppCategory)")

            Spacer(minLength:2)

            Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                .italic()

            Spacer(minLength:4)

            Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                .italic()

            Spacer()

        }
    //  .padding()
        
    }
    
}

@available(iOS 14.0, *)
#Preview
{
    
    AppAboutView()
    
}


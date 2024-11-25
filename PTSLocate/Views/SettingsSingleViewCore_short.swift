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
        static let sClsVers      = "v1.0105"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):
    
//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
           private var bInternalZipTest:Bool                     = false

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

            Text("...setting(s) from 'core'...")
            
            Spacer()

        }
        .padding()

    }

}   // END of struct SettingsSingleViewCore(View). 

#Preview 
{
    
    SettingsSingleViewCore()
    
}


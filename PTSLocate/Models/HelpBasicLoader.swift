//
//  HelpBasicLoader.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 06/11/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(Cocoa)
import Cocoa
#else
import UIKit
#endif

@available(iOS 14.0, *)
class HelpBasicLoader: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId        = "HelpBasicLoader"
        static let sClsVers      = "v1.0801"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    var bHelpSetupRequired:Bool                   = true
    var sHelpBasicLoaderTag                       = ""
    var sHelpBasicFileExt:String                  = "md"        // 'help' File extension: "md", "html", or "txt"
    var sHelpBasicContents:String                 = "-N/A-"

    @AppStorage("helpBasicMode") 
    var helpBasicMode                             = HelpBasicMode.simpletext

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

    public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bHelpSetupRequired': [\(self.bHelpSetupRequired)],")
        asToString.append("'sHelpBasicLoaderTag': [\(self.sHelpBasicLoaderTag)],")
        asToString.append("'sHelpBasicFileExt': [\(self.sHelpBasicFileExt)],")
        asToString.append("'sHelpBasicContents': [\(self.sHelpBasicContents)],")
        asToString.append("'helpBasicMode': [\(self.helpBasicMode)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor)],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func loadHelpBasicContents(helpbasicfileext:String = "html", helpbasicloadertag:String = "-unknown-") -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"'"

        self.xcgLogMsg("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Invoked...")

        if (self.bHelpSetupRequired == true)
        {

            self.sHelpBasicLoaderTag = helpbasicloadertag

            if (self.sHelpBasicLoaderTag.count < 1)
            {

                self.sHelpBasicLoaderTag  = "-unknown-"

                let sSearchMessage:String = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Supplied 'help' Basic loader TAG string is an 'empty' string - defaulting it to [\(self.sHelpBasicLoaderTag)] - Warning!"

                self.xcgLogMsg(sSearchMessage)

            }

            self.sHelpBasicFileExt = helpbasicfileext

            if (self.sHelpBasicFileExt.count < 1)
            {

                self.sHelpBasicFileExt    = "md"

                let sSearchMessage:String = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Supplied 'help' Basic loader TAG string is an 'empty' string - defaulting it to [\(self.sHelpBasicFileExt)] - Warning!"

                self.xcgLogMsg(sSearchMessage)

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Loading the HELP 'Basic' contents from file extension of [\(self.sHelpBasicFileExt)] via [\(self.sHelpBasicLoaderTag)]...")

            if let fpBasicHelp = Bundle.main.path(forResource: "HelpBasic", ofType: self.sHelpBasicFileExt)
            {

                do 
                {

                    self.sHelpBasicContents = try String(contentsOfFile: fpBasicHelp)

                    self.xcgLogMsg("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - HELP 'basic' contents 'self.sHelpBasicContents' via [\(self.sHelpBasicLoaderTag)] are [\(self.sHelpBasicContents)]...")

                    if (self.sHelpBasicFileExt == "html")
                    {

                        self.helpBasicMode = HelpBasicMode.hypertext

                    }
                    else
                    {

                        if (self.sHelpBasicFileExt == "md")
                        {

                            self.helpBasicMode = HelpBasicMode.markdown

                        }
                        else
                        {

                            self.helpBasicMode = HelpBasicMode.simpletext

                        }

                    }

                } 
                catch 
                {

                    self.helpBasicMode      = HelpBasicMode.simpletext
                    self.sHelpBasicContents = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Resource file 'HelpBasic.\(self.sHelpBasicFileExt)' could NOT be loaded via [\(self.sHelpBasicLoaderTag)] - Error!"

                }

            }
            else 
            {

                self.helpBasicMode      = HelpBasicMode.simpletext
                self.sHelpBasicContents = "\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Resource file 'HelpBasic.\(self.sHelpBasicFileExt)' could NOT be found via [\(self.sHelpBasicLoaderTag)] - Error!"

            }

            self.xcgLogMsg("")

        }


        // Exit:

        self.xcgLogMsg("\(ClassInfo.sClsDisp) \(sCurrMethodDisp) - Exiting...")

        return self.sHelpBasicContents

    }   // End of public func loadHelpBasicContents().

}   // End of class HelpBasicLoader(NSObject).


//
//  FirstSwiftDataItem.swift
//  JustAFirstSwiftDataApp1
//
//  Created by Daryl Cox on 11/26/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftData

@Model
//NOTE: Do NOT Subclass in this Class - @Model will throw an error about using 'self' before 'super.init()'...
//class FirstSwiftDataItem: NSObject, Identifiable
final class FirstSwiftDataItem: Identifiable
{
    
    @Transient
    struct ClassInfo
    {
        
        static let sClsId        = "FirstSwiftDataItem"
        static let sClsVers      = "v1.0304"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    @Attribute(.unique) 
    var id:UUID                                   = UUID()
    var idPFAdminsObject:Int                      = 0
    var timestamp:Date                            = Date()
    var sCreatedBy:String                         = ""
    
    // Item 'keyed' field(s):

    var sPFAdminsParseName:String                 = "-N/A-"  // This will come from 'tid' lookup in 'TherapistFile'...
    var sPFAdminsParseTID:String                  = "-N/A-"
    var sPFAdminsParsePassword:String             = ""
    var sPFAdminsParseNewLvl:String               = "-N/A-"
    var sPFAdminsParseLevel:String                = "-N/A-"

    @Transient
    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
                                                    // NOTE: The AppDelegateVisitor MUST be wrapped with @Transient
                                                    //       or the compiler will fail this as referencing 'self'
                                                    //       before the 'super.init()' has been invoked...

    init(idPFAdminsObject:Int, timestamp:Date, sCreatedBy:String="-N/A-")
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  super.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter(s) are 'idPFAdminsObject' is (\(idPFAdminsObject)) - 'timestamp' is [\(timestamp)] - 'sCreatedBy' is [\(sCreatedBy)]...")

        // Finish the 'default' setup of field(s)...

        self.id                     = UUID()
        self.idPFAdminsObject       = idPFAdminsObject
        self.timestamp              = timestamp
        self.sCreatedBy             = sCreatedBy
        
        self.sPFAdminsParseName     = "-N/A-"
        self.sPFAdminsParseTID      = "-N/A-"
        self.sPFAdminsParsePassword = ""
        self.sPFAdminsParseNewLvl   = "-N/A-"
        self.sPFAdminsParseLevel    = "-N/A-"

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of init(idPFAdminsObject:Int, timestamp:Date, sCreatedBy).

    convenience init(timestamp:Date, sCreatedBy:String="-N/A-", pfAdminsItem:ParsePFAdminsDataItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.init(idPFAdminsObject:0, timestamp:timestamp, sCreatedBy:sCreatedBy)
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter(s) are 'timestamp' is [\(timestamp)] - 'sCreatedBy' is [\(sCreatedBy)] - 'pfAdminsItem' is [\(pfAdminsItem)]...")
        
        // Finish the 'convenience' setup of field(s)...
        
        self.idPFAdminsObject       = pfAdminsItem.idPFAdminsObject
        self.sPFAdminsParseName     = pfAdminsItem.sPFAdminsParseName
        self.sPFAdminsParseTID      = pfAdminsItem.sPFAdminsParseTID
        self.sPFAdminsParsePassword = pfAdminsItem.sPFAdminsParsePassword
        self.sPFAdminsParseNewLvl   = pfAdminsItem.sPFAdminsParseNewLvl
        self.sPFAdminsParseLevel    = pfAdminsItem.sPFAdminsParseLevel

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of convenience init(timestamp:Date, sCreatedBy:String, pfAdminsItem:ParsePFAdminsDataItem).

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

    public func toString()->String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'idPFAdminsObject': [\(String(describing: self.idPFAdminsObject))],")
        asToString.append("'timestamp': [\(String(describing: self.timestamp))],")
        asToString.append("'sCreatedBy': [\(String(describing: self.sCreatedBy))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFAdminsParseName': [\(String(describing: self.sPFAdminsParseName))],")
        asToString.append("'sPFAdminsParseTID': [\(String(describing: self.sPFAdminsParseTID))],")
        asToString.append("'sPFAdminsParsePassword': [\(String(describing: self.sPFAdminsParsePassword))],")
        asToString.append("'sPFAdminsParseNewLvl': [\(String(describing: self.sPFAdminsParseNewLvl))],")
        asToString.append("'sPFAdminsParseLevel': [\(String(describing: self.sPFAdminsParseLevel))],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayFirstSwiftDataItemWithLocalStore(bShowLocalStore:Bool=false)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'bShowLocalStore' is [\(bShowLocalStore)]...")

        // Display the various field(s) of this object...

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'id'                     is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'idPFAdminsObject'       is [\(String(describing: self.idPFAdminsObject))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'timestamp'              is [\(String(describing: self.timestamp))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseName'     is [\(String(describing: self.sPFAdminsParseName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseTID'      is [\(String(describing: self.sPFAdminsParseTID))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParsePassword' is [\(String(describing: self.sPFAdminsParsePassword))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseNewLvl'   is [\(String(describing: self.sPFAdminsParseNewLvl))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseLevel'    is [\(String(describing: self.sPFAdminsParseLevel))]...")
        
        // (Optionally) Display the location of the SwiftData 'local' store...

        if (bShowLocalStore == true)
        {

            let urlApp:URL?         = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            let urlDefaultStore:URL = urlApp!.appendingPathComponent("default.store")

            if FileManager.default.fileExists(atPath:urlDefaultStore.path)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): SwiftData 'local' DB is at [\(urlDefaultStore.absoluteString)]...")

            }

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayFirstSwiftDataItemWithLocalStore(bShowLocalStore:Bool).
    
}   // END of final class FirstSwiftDataItem(NSObject, Identifiable).

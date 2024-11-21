//
//  ParsePFAdminsDataItem.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 05/09/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import ParseCore

class ParsePFAdminsDataItem: NSObject, Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "ParsePFAdminsDataItem"
        static let sClsVers      = "v1.0102"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Item Data field(s):
    
    var id                                      = UUID()

    var idPFAdminsObject:Int                    = 0

    // ------------------------------------------------------------------------------------------
    //  'pfAdminsObject' is [<Admins: 0x301e16700, objectId: qpp1fxx68P, localId: (null)> 
    //  {
    //      tid      = "271";
    //      password = "...";
    //      newLvl   = "1";
    //      level    = "32";
    //  }]...
    // ------------------------------------------------------------------------------------------

    var pfAdminsObject:PFObject?                = nil

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfAdminsObject'                 is [PFObject]         - value is [<Admins: 0x302ee1080, objectId: ...
    //  TYPE of 'pfAdminsObject.parseClassName'  is [String]           - value is [Admins]...
    //  TYPE of 'pfAdminsObject.objectId'        is [Optional<String>] - value is [Optional("dztxUrBZLr")]...
    //  TYPE of 'pfAdminsObject.createdAt'       is [Optional<Date>]   - value is [Optional(2024-11-13 17:13:57 +0000)]...
    //  TYPE of 'pfAdminsObject.updatedAt'       is [Optional<Date>]   - value is [Optional(2024-11-14 22:30:00 +0000)]...
    //  TYPE of 'pfAdminsObject.acl'             is [Optional<PFACL>]  - value is [nil]...
    //  TYPE of 'pfAdminsObject.isDataAvailable' is [Bool]             - value is [true]...
    //  TYPE of 'pfAdminsObject.isDirty'         is [Bool]             - value is [false]...
    //  TYPE of 'pfAdminsObject.allKeys'         is [Array<String>]    - value is [["tid", "password", ...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'discrete' field(s):

    var sPFAdminsParseClassName:String          = ""
    var sPFAdminsParseObjectId:String?          = nil
    var datePFAdminsParseCreatedAt:Date?        = nil
    var datePFAdminsParseUpdatedAt:Date?        = nil
    var aclPFAdminsParse:PFACL?                 = nil
    var bPFAdminsParseIsDataAvailable:Bool      = false
    var bPFAdminsParseIdDirty:Bool              = false
    var sPFAdminsParseAllKeys:[String]          = []

    // ----------------------------------------------------------------------------------------------------------------
    //     TYPE of 'pfTherapistObject[name]'  is [Optional<Any>] - value is [Optional(xxx)]...
    //     TYPE of 'pfAdminsObject[tid]'      is [Optional<Any>] - value is [Optional(271)]...
    //     TYPE of 'pfAdminsObject[password]' is [Optional<Any>] - value is [Optional(...)]...
    //     TYPE of 'pfAdminsObject[newLvl]'   is [Optional<Any>] - value is [Optional(1)]...
    //     TYPE of 'pfAdminsObject[level]'    is [Optional<Any>] - value is [Optional(32)]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var sPFAdminsParseName:String               = "-N/A-"  // This will come from 'tid' lookup in 'TherapistFile'...
    var sPFAdminsParseTID:String                = "-N/A-"
    var sPFAdminsParsePassword:String           = ""
    var sPFAdminsParseNewLvl:String             = "-N/A-"
    var sPFAdminsParseLevel:String              = "-N/A-"

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        return

    }   // End of override init().

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
        asToString.append("'pfAdminsObject': [\(String(describing: self.pfAdminsObject))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFAdminsParseClassName': [\(String(describing: self.sPFAdminsParseClassName))],")
        asToString.append("'sPFAdminsParseObjectId': [\(String(describing: self.sPFAdminsParseObjectId))],")
        asToString.append("'datePFAdminsParseCreatedAt': [\(String(describing: self.datePFAdminsParseCreatedAt))],")
        asToString.append("'datePFAdminsParseUpdatedAt': [\(String(describing: self.datePFAdminsParseUpdatedAt))],")
        asToString.append("'aclPFAdminsParse': [\(String(describing: self.aclPFAdminsParse))],")
        asToString.append("'bPFAdminsParseIsDataAvailable': [\(String(describing: self.bPFAdminsParseIsDataAvailable))],")
        asToString.append("'bPFAdminsParseIdDirty': [\(String(describing: self.bPFAdminsParseIdDirty))],")
        asToString.append("'sPFAdminsParseAllKeys': [\(String(describing: self.sPFAdminsParseAllKeys))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFAdminsParseName': [\(String(describing: self.sPFAdminsParseName))],")
        asToString.append("'sPFAdminsParseTID': [\(String(describing: self.sPFAdminsParseTID))],")
        asToString.append("'sPFAdminsParsePassword': [\(String(describing: self.sPFAdminsParsePassword))],")
        asToString.append("'sPFAdminsParseNewLvl': [\(String(describing: self.sPFAdminsParseNewLvl))],")
        asToString.append("'sPFAdminsParseLevel': [\(String(describing: self.sPFAdminsParseLevel))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayParsePFAdminsDataItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object in the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'id'                            is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'idPFAdminsObject'              is [\(String(describing: self.idPFAdminsObject))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'pfAdminsObject'                is [\(String(describing: self.pfAdminsObject))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseClassName'       is [\(String(describing: self.sPFAdminsParseClassName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseObjectId'        is [\(String(describing: self.sPFAdminsParseObjectId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'datePFAdminsParseCreatedAt'    is [\(String(describing: self.datePFAdminsParseCreatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'datePFAdminsParseUpdatedAt'    is [\(String(describing: self.datePFAdminsParseUpdatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'aclPFAdminsParse'              is [\(String(describing: self.aclPFAdminsParse))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'bPFAdminsParseIsDataAvailable' is [\(String(describing: self.bPFAdminsParseIsDataAvailable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'bPFAdminsParseIdDirty'         is [\(String(describing: self.bPFAdminsParseIdDirty))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseAllKeys'         is [\(String(describing: self.sPFAdminsParseAllKeys))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseName'            is [\(String(describing: self.sPFAdminsParseName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseTID'             is [\(String(describing: self.sPFAdminsParseTID))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParsePassword'        is [\(String(describing: self.sPFAdminsParsePassword))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseNewLvl'          is [\(String(describing: self.sPFAdminsParseNewLvl))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFAdminsObject)): 'sPFAdminsParseLevel'           is [\(String(describing: self.sPFAdminsParseLevel))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayParsePFAdminsDataItemToLog().

    public func constructParsePFAdminsDataItemFromPFObject(idPFAdminsObject:Int = 0, pfAdminsObject:PFObject)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'idPFAdminsObject' is (\(idPFAdminsObject)) - 'pfAdminsObject' is [\(String(describing: pfAdminsObject))]...")

        // Assign the various field(s) of this object from the supplied PFObject...

        self.idPFAdminsObject                = idPFAdminsObject                                                             
        self.pfAdminsObject                  = pfAdminsObject                                                             
        
        self.sPFAdminsParseClassName         = pfAdminsObject.parseClassName
        self.sPFAdminsParseObjectId          = pfAdminsObject.objectId  != nil ? pfAdminsObject.objectId!  : ""
        self.datePFAdminsParseCreatedAt      = pfAdminsObject.createdAt != nil ? pfAdminsObject.createdAt! : nil
        self.datePFAdminsParseUpdatedAt      = pfAdminsObject.updatedAt != nil ? pfAdminsObject.updatedAt! : nil
        self.aclPFAdminsParse                = pfAdminsObject.acl
        self.bPFAdminsParseIsDataAvailable   = pfAdminsObject.isDataAvailable
        self.bPFAdminsParseIdDirty           = pfAdminsObject.isDirty
        self.sPFAdminsParseAllKeys           = pfAdminsObject.allKeys

        self.sPFAdminsParseName              = "-N/A-"
        self.sPFAdminsParseTID               = String(describing: (pfAdminsObject.object(forKey:"tid")      ?? "-N/A-"))
        self.sPFAdminsParsePassword          = String(describing: (pfAdminsObject.object(forKey:"password") ?? ""))
        self.sPFAdminsParseNewLvl            = String(describing: (pfAdminsObject.object(forKey:"newLvl")   ?? "-N/A-"))
        self.sPFAdminsParseLevel             = String(describing: (pfAdminsObject.object(forKey:"level")    ?? "-N/A-"))
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func constructParsePFAdminsDataItemFromPFObject(idPFAdminsObject:Int, pfAdminsObject:PFObject).

}   // End of class ParsePFAdminsDataItem(NSObject, Identifiable).


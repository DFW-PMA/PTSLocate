//
//  ScheduledPatientLocationItem.swift
//  JustAFirstSwiftDataApp1
//
//  Created by Daryl Cox on 12/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation

class ScheduledPatientLocationItem: NSObject, Identifiable
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ScheduledPatientLocationItem"
        static let sClsVers      = "v1.0102"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    var id:UUID                                   = UUID()

    var sTid:String                               = ""   // From 'FirstSwiftDataItem' <String>
    var iTid:Int                                  = -1   // Converted from 'sTid <String>'...
    var sTName:String                             = ""   // From 'PFQuery::PatientCalDay["tName"]'

    var sPid:String                               = ""   // Converted from 'iPid <Int>'...
    var iPid:Int                                  = -1   // From 'PFQuery::PatientCalDay["pid"]' <Int>
    var sPtName:String                            = ""   // From 'PFQuery::PatientCalDay["ptName"]'

    var sVDate:String                             = ""   // From 'PFQuery::PatientCalDay["VDate"]'
    var sVDateStartTime:String                    = ""   // From 'PFQuery::PatientCalDay["startTime"]'

    var sLastVDate:String                         = ""   // From 'PFQuery::BackupVisit["VDate"]'
    var iLastVDateType:Int                        = -1   // From 'PFQuery::BackupVisit["type"]'
    var sLastVDateAddress:String                  = ""   // From 'PFQuery::BackupVisit["address"]'
    var sLastVDateLatitude:String                 = ""   // From 'PFQuery::BackupVisit["lat"]'
    var sLastVDateLongitude:String                = ""   // From 'PFQuery::BackupVisit["long"]'

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Finish the 'default' setup of field(s)...

        self.id                  = UUID()
        self.sTid                = ""   // From 'FirstSwiftDataItem' <String>
        self.iTid                = -1   // Converted from 'sTid <String>'...
        self.sTName              = ""   // From 'PFQuery::PatientCalDay["tName"]'

        self.sPid                = ""   // Converted from 'iPid <Int>'...
        self.iPid                = -1   // From 'PFQuery::PatientCalDay["pid"]' <Int>
        self.sPtName             = ""   // From 'PFQuery::PatientCalDay["ptName"]'

        self.sVDate              = ""   // From 'PFQuery::PatientCalDay["VDate"]'
        self.sVDateStartTime     = ""   // From 'PFQuery::PatientCalDay["startTime"]'

        self.sLastVDate          = ""   // From 'PFQuery::BackupVisit["VDate"]'
        self.iLastVDateType      = -1   // From 'PFQuery::BackupVisit["type"]'
        self.sLastVDateAddress   = ""   // From 'PFQuery::BackupVisit["address"]'
        self.sLastVDateLatitude  = ""   // From 'PFQuery::BackupVisit["lat"]'
        self.sLastVDateLongitude = ""   // From 'PFQuery::BackupVisit["long"]'

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of override init().

//  convenience init(pfAdminsItem:ParsePFAdminsDataItem)
//  {
//      
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//
//      self.init()
//      
//      // Finish the 'convenience' setup of field(s)...
//
//      self.xxx = yyyzzz
//
//      // Exit:
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
//
//      return
//
//  }   // END of convenience init(pfAdminsItem:ParsePFAdminsDataItem).

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
        asToString.append("'sTid': [\(String(describing: self.sTid))],")
        asToString.append("'iTid': [\(String(describing: self.iTid))],")
        asToString.append("'sTName': [\(String(describing: self.sTName))],")
        asToString.append("'sPid': [\(String(describing: self.sPid))],")
        asToString.append("'iPid': [\(String(describing: self.iPid))],")
        asToString.append("'sPtName': [\(String(describing: self.sPtName))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sVDate': [\(String(describing: self.sVDate))],")
        asToString.append("'sVDateStartTime': [\(String(describing: self.sVDateStartTime))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sLastVDate': [\(String(describing: self.sLastVDate))],")
        asToString.append("'iLastVDateType': [\(String(describing: self.iLastVDateType))],")
        asToString.append("'sLastVDateAddress': [\(String(describing: self.sLastVDateAddress))],")
        asToString.append("'sLastVDateLatitude': [\(String(describing: self.sLastVDateLatitude))],")
        asToString.append("'sLastVDateLongitude': [\(String(describing: self.sLastVDateLongitude))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor)],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayScheduledPatientLocationItem()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object...

        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                  is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTid'                is [\(String(describing: self.sTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iTid'                is [\(String(describing: self.iTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTName'              is [\(String(describing: self.sTName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPid'                is [\(String(describing: self.sPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPid'                is [\(String(describing: self.iPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPtName'             is [\(String(describing: self.sPtName))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDate'              is [\(String(describing: self.sVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDateStartTime'     is [\(String(describing: self.sVDateStartTime))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDate'          is [\(String(describing: self.sLastVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iLastVDateType'      is [\(String(describing: self.iLastVDateType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateAddress'   is [\(String(describing: self.sLastVDateAddress))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLatitude'  is [\(String(describing: self.sLastVDateLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLongitude' is [\(String(describing: self.sLastVDateLongitude))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayScheduledPatientLocationItem().
    
}   // END of class ScheduledPatientLocationItem(NSObject, Identifiable).


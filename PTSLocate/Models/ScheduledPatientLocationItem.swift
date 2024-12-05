//
//  ScheduledPatientLocationItem.swift
//  JustAFirstSwiftDataApp1
//
//  Created by Daryl Cox on 12/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import ParseCore

class ScheduledPatientLocationItem: NSObject, Identifiable
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ScheduledPatientLocationItem"
        static let sClsVers      = "v1.0205"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    var id:UUID                                   = UUID()

    var sTid:String                               = "-1" // From 'FirstSwiftDataItem' <String>
                                                         // -OR- 'PFQuery::TherapistFile["ID"]'
                                                         // -OR- 'PFQuery::PatientCalDay["tid"]'
    var iTid:Int                                  = -1   // Converted from 'sTid <String>'...
    var sTName:String                             = ""   // From 'PFQuery::PatientCalDay["tName"]'
    var sTherapistName:String                     = ""   // From 'PFQuery::TherapistFile["name"]' 

    var sPid:String                               = "-1" // From 'PFQuery::PatientCalDay["pid"]' <Int>
    var iPid:Int                                  = -1   // Converted from 'sPid <String>'...
    var sPtName:String                            = ""   // From 'PFQuery::PatientCalDay["ptName"]'

    var sVDate:String                             = ""   // From 'PFQuery::PatientCalDay["VDate"]'
    var sVDateStartTime:String                    = ""   // From 'PFQuery::PatientCalDay["startTime"]'

    var sLastVDate:String                         = ""   // From 'PFQuery::BackupVisit["VDate"]'
    var sLastVDateType:String                     = "-1" // From 'PFQuery::BackupVisit["type"]'
    var iLastVDateType:Int                        = -1   // Converted from 'sLastVDateType <String>'...
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
        self.sTid                = "-1"
        self.iTid                = Int(self.sTid)!
        self.sTName              = ""
        self.sTherapistName      = ""

        self.sPid                = "-1"
        self.iPid                = Int(self.sPid)!
        self.sPtName             = ""

        self.sVDate              = ""
        self.sVDateStartTime     = ""

        self.sLastVDate          = ""
        self.sLastVDateType      = "-1"
        self.iLastVDateType      = Int(self.sLastVDateType)!
        self.sLastVDateAddress   = ""
        self.sLastVDateLatitude  = ""
        self.sLastVDateLongitude = ""

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of override init().

    convenience init(scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'scheduledPatientLocationItem' is [\(scheduledPatientLocationItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.sTid                = scheduledPatientLocationItem.sTid               
        self.iTid                = scheduledPatientLocationItem.iTid               
        self.sTName              = scheduledPatientLocationItem.sTName             
        self.sTherapistName      = scheduledPatientLocationItem.sTherapistName     
                                                                                   
        self.sPid                = scheduledPatientLocationItem.sPid               
        self.iPid                = scheduledPatientLocationItem.iPid               
        self.sPtName             = scheduledPatientLocationItem.sPtName            
                                                                                   
        self.sVDate              = scheduledPatientLocationItem.sVDate             
        self.sVDateStartTime     = scheduledPatientLocationItem.sVDateStartTime    
                                                                                   
        self.sLastVDate          = scheduledPatientLocationItem.sLastVDate         
        self.sLastVDateType      = scheduledPatientLocationItem.sLastVDateType     
        self.iLastVDateType      = scheduledPatientLocationItem.iLastVDateType     
        self.sLastVDateAddress   = scheduledPatientLocationItem.sLastVDateAddress  
        self.sLastVDateLatitude  = scheduledPatientLocationItem.sLastVDateLatitude 
        self.sLastVDateLongitude = scheduledPatientLocationItem.sLastVDateLongitude

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of convenience init(scheduledPatientLocationItem:ScheduledPatientLocationItem).

    convenience init(pfTherapistFileItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfTherapistFileItem.ID' is [\(pfTherapistFileItem.object(forKey:"ID"))]...")

        // Finish the 'convenience' setup of field(s)...

        self.updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:pfTherapistFileItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of convenience init(pfTherapistFileItem:PFObject).

    convenience init(pfPatientCalDayItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfPatientCalDayItem.tid' is [\(pfPatientCalDayItem.object(forKey:"tid"))]...")

        // Finish the 'convenience' setup of field(s)...

        self.updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:pfPatientCalDayItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of convenience init(pfPatientCalDayItem:PFObject).

    public func updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfTherapistFileItem.ID' is [\(pfTherapistFileItem.object(forKey:"ID"))]...")

        // Handle the 'update' (setup) of field(s)...

        if (self.sTid.count  < 1 ||
            self.sTid       == "-1")
        {

            self.sTid = String(describing: (pfTherapistFileItem.object(forKey:"ID") ?? "-1"))
            self.iTid = Int(self.sTid)!

        }
  
        self.sTherapistName = String(describing: (pfTherapistFileItem.object(forKey:"name") ?? ""))

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of public func updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:PFObject).

    public func updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfPatientCalDayItem.tid' is [\(pfPatientCalDayItem.object(forKey:"tid"))]...")

        // Handle the 'update' (setup) of field(s)...

        if (self.sTid.count  < 1 ||
            self.sTid       == "-1")
        {

            self.sTid = String(describing: (pfPatientCalDayItem.object(forKey:"tid") ?? "-1"))
            self.iTid = Int(self.sTid)!

        }
  
        self.sTName          = String(describing: (pfPatientCalDayItem.object(forKey:"tName")     ?? ""))

        self.sPid            = String(describing: (pfPatientCalDayItem.object(forKey:"pid")       ?? "-1"))
        self.iPid            = Int(self.sPid)!
        self.sPtName         = String(describing: (pfPatientCalDayItem.object(forKey:"ptName")    ?? ""))

        self.sVDate          = String(describing: (pfPatientCalDayItem.object(forKey:"VDate")     ?? ""))
        self.sVDateStartTime = String(describing: (pfPatientCalDayItem.object(forKey:"startTime") ?? ""))
  
        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of public func updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:PFObject).

    public func updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfBackupVisit.VDate' is [\(pfBackupVisit.object(forKey:"VDate"))] <for 'tid' of [\(pfBackupVisit.object(forKey:"tid"))]>...")

        // Handle the 'update' (setup) of field(s)...
  
        self.sLastVDate          = String(describing: (pfBackupVisit.object(forKey:"VDate")   ?? ""))
        self.sLastVDateType      = String(describing: (pfBackupVisit.object(forKey:"type")    ?? "-1"))
        self.iLastVDateType      = Int(self.sLastVDateType)!
        self.sLastVDateAddress   = String(describing: (pfBackupVisit.object(forKey:"address") ?? ""))
        self.sLastVDateLatitude  = String(describing: (pfBackupVisit.object(forKey:"lat")     ?? ""))
        self.sLastVDateLongitude = String(describing: (pfBackupVisit.object(forKey:"long")    ?? ""))

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // END of public func updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:PFObject).

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
        asToString.append("'sTherapistName': [\(String(describing: self.sTherapistName))],")
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
        asToString.append("'sLastVDateType': [\(String(describing: self.sLastVDateType))],")
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

    public func displayScheduledPatientLocationItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object...

        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                  is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTid'                is [\(String(describing: self.sTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iTid'                is [\(String(describing: self.iTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTName'              is [\(String(describing: self.sTName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTherapistName'      is [\(String(describing: self.sTherapistName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPid'                is [\(String(describing: self.sPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPid'                is [\(String(describing: self.iPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPtName'             is [\(String(describing: self.sPtName))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDate'              is [\(String(describing: self.sVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDateStartTime'     is [\(String(describing: self.sVDateStartTime))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDate'          is [\(String(describing: self.sLastVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateType'      is [\(String(describing: self.sLastVDateType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iLastVDateType'      is [\(String(describing: self.iLastVDateType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateAddress'   is [\(String(describing: self.sLastVDateAddress))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLatitude'  is [\(String(describing: self.sLastVDateLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLongitude' is [\(String(describing: self.sLastVDateLongitude))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayScheduledPatientLocationItemToLog().
    
}   // END of class ScheduledPatientLocationItem(NSObject, Identifiable).


//
//  ParsePFCscDataItem.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 05/09/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import ParseCore

class ParsePFCscDataItem: NSObject, Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "ParsePFCscDataItem"
        static let sClsVers      = "v1.0303"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Item Data field(s):
    
    var id                                        = UUID()

    var idPFCscObject:Int                         = 0

    // ------------------------------------------------------------------------------------------
    //  'pfCscObject' is [<CSC: 0x301e16700, objectId: qpp1fxx68P, localId: (null)> 
    //  {
    //      name        = "Office Ernesto";
    //      lastLocDate = "11/14/24";
    //      lastLocTime = "4:15\U202fPM";
    //      latitude    = "32.83285140991211";
    //      longitude   = "-97.071533203125";
    //  }]...
    // ------------------------------------------------------------------------------------------

    var pfCscObject:PFObject?                     = nil

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfCscObject'                 is [PFObject]         - value is [<CSC: 0x302ee1080, objectId: ...
    //  TYPE of 'pfCscObject.parseClassName'  is [String]           - value is [CSC]...
    //  TYPE of 'pfCscObject.objectId'        is [Optional<String>] - value is [Optional("dztxUrBZLr")]...
    //  TYPE of 'pfCscObject.createdAt'       is [Optional<Date>]   - value is [Optional(2024-11-13 17:13:57 +0000)]...
    //  TYPE of 'pfCscObject.updatedAt'       is [Optional<Date>]   - value is [Optional(2024-11-14 22:30:00 +0000)]...
    //  TYPE of 'pfCscObject.acl'             is [Optional<PFACL>]  - value is [nil]...
    //  TYPE of 'pfCscObject.isDataAvailable' is [Bool]             - value is [true]...
    //  TYPE of 'pfCscObject.isDirty'         is [Bool]             - value is [false]...
    //  TYPE of 'pfCscObject.allKeys'         is [Array<String>]    - value is [["lastLocTime", "latitude", ...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'discrete' field(s):

    var sPFCscParseClassName:String               = ""
    var sPFCscParseObjectId:String?               = nil
    var datePFCscParseCreatedAt:Date?             = nil
    var datePFCscParseUpdatedAt:Date?             = nil
    var aclPFCscParse:PFACL?                      = nil
    var bPFCscParseIsDataAvailable:Bool           = false
    var bPFCscParseIdDirty:Bool                   = false
    var sPFCscParseAllKeys:[String]               = []

    // ----------------------------------------------------------------------------------------------------------------
    //     TYPE of 'pfCscObject[name]'        is [Optional<Any>] - value is [Optional(Mihal Lasky)]...
    //     TYPE of 'pfCscObject[lastLocDate]' is [Optional<Any>] - value is [Optional(11/14/24)]...
    //     TYPE of 'pfCscObject[lastLocTime]' is [Optional<Any>] - value is [Optional(4:30 PM)]...
    //     TYPE of 'pfCscObject[latitude]'    is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //     TYPE of 'pfCscObject[longitude]'   is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var sPFCscParseName:String                    = "-N/A-"
    var sPFCscParseLastLocDate:String             = "-N/A-"
    var sPFCscParseLastLocTime:String             = "-N/A-"
    var sPFCscParseLastLatitude:String            = "-N/A-"
    var sPFCscParseLastLongitude:String           = "-N/A-"

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfCscObjectLatitude'         is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //  TYPE of 'pfCscObjectLongitude'        is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    //  TYPE of 'sPFCscObjectLatitude'        is [String]        - value is [32.77201080322266]...
    //  TYPE of 'sPFCscObjectLongitude'       is [String]        - value is [-96.5831298828125]...
    //  TYPE of 'dblPFCscObjectLatitude'      is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblPFCscObjectLongitude'     is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'dblConvertedLatitude'        is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblConvertedLongitude'       is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'sCurrentLocationName'        is [String]        - value is [-N/A-]...
    //  TYPE of 'sCurrentCity'                is [String]        - value is [-N/A-]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'calculated'/'converted'/'looked'-up field(s):

    var pfCscObjectLatitude:Any?                  = nil
    var pfCscObjectLongitude:Any?                 = nil

    var sPFCscObjectLatitude:String               = "0.0"
    var sPFCscObjectLongitude:String              = "0.0"

    var dblPFCscObjectLatitude:Double             = 0.0
    var dblPFCscObjectLongitude:Double            = 0.0

    var dblConvertedLatitude:Double               = 0.0
    var dblConvertedLongitude:Double              = 0.0

    var sCurrentLocationName:String               = ""
    var sCurrentCity:String                       = ""
    var sCurrentCountry:String                    = ""
    var sCurrentPostalCode:String                 = ""
    var sCurrentTimeZone:String                   = ""

    // Item address 'lookup' completed flag:

    var bCurrentAddessLookupComplete:Bool         = false

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
        asToString.append("'idPFCscObject': [\(String(describing: self.idPFCscObject))],")
        asToString.append("'pfCscObject': [\(String(describing: self.pfCscObject))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFCscParseClassName': [\(String(describing: self.sPFCscParseClassName))],")
        asToString.append("'sPFCscParseObjectId': [\(String(describing: self.sPFCscParseObjectId))],")
        asToString.append("'datePFCscParseCreatedAt': [\(String(describing: self.datePFCscParseCreatedAt))],")
        asToString.append("'datePFCscParseUpdatedAt': [\(String(describing: self.datePFCscParseUpdatedAt))],")
        asToString.append("'aclPFCscParse': [\(String(describing: self.aclPFCscParse))],")
        asToString.append("'bPFCscParseIsDataAvailable': [\(String(describing: self.bPFCscParseIsDataAvailable))],")
        asToString.append("'bPFCscParseIdDirty': [\(String(describing: self.bPFCscParseIdDirty))],")
        asToString.append("'sPFCscParseAllKeys': [\(String(describing: self.sPFCscParseAllKeys))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFCscParseName': [\(String(describing: self.sPFCscParseName))],")
        asToString.append("'sPFCscParseLastLocDate': [\(String(describing: self.sPFCscParseLastLocDate))],")
        asToString.append("'sPFCscParseLastLocTime': [\(String(describing: self.sPFCscParseLastLocTime))],")
        asToString.append("'sPFCscParseLastLatitude': [\(String(describing: self.sPFCscParseLastLatitude))],")
        asToString.append("'sPFCscParseLastLongitude': [\(String(describing: self.sPFCscParseLastLongitude))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'pfCscObjectLatitude': [\(String(describing: self.pfCscObjectLatitude))],")
        asToString.append("'pfCscObjectLongitude': [\(String(describing: self.pfCscObjectLongitude))],")
        asToString.append("'sPFCscObjectLatitude': [\(String(describing: self.sPFCscObjectLatitude))],")
        asToString.append("'sPFCscObjectLongitude': [\(String(describing: self.sPFCscObjectLongitude))],")
        asToString.append("'dblPFCscObjectLatitude': [\(String(describing: self.dblPFCscObjectLatitude))],")
        asToString.append("'dblPFCscObjectLongitude': [\(String(describing: self.dblPFCscObjectLongitude))],")
        asToString.append("'dblConvertedLatitude': [\(String(describing: self.dblConvertedLatitude))],")
        asToString.append("'dblConvertedLongitude': [\(String(describing: self.dblConvertedLongitude))],")
        asToString.append("'sCurrentLocationName': [\(String(describing: self.sCurrentLocationName))],")
        asToString.append("'sCurrentCity': [\(String(describing: self.sCurrentCity))],")
        asToString.append("'sCurrentCountry': [\(String(describing: self.sCurrentCountry))],")
        asToString.append("'sCurrentPostalCode': [\(String(describing: self.sCurrentPostalCode))],")
        asToString.append("'sCurrentTimeZone': [\(String(describing: self.sCurrentTimeZone))],")
        asToString.append("'bCurrentAddessLookupComplete': [\(String(describing: self.bCurrentAddessLookupComplete))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayParsePFCscDataItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object in the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'id'                           is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'idPFCscObject'                is [\(String(describing: self.idPFCscObject))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'pfCscObject'                  is [\(String(describing: self.pfCscObject))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseClassName'         is [\(String(describing: self.sPFCscParseClassName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseObjectId'          is [\(String(describing: self.sPFCscParseObjectId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'datePFCscParseCreatedAt'      is [\(String(describing: self.datePFCscParseCreatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'datePFCscParseUpdatedAt'      is [\(String(describing: self.datePFCscParseUpdatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'aclPFCscParse'                is [\(String(describing: self.aclPFCscParse))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'bPFCscParseIsDataAvailable'   is [\(String(describing: self.bPFCscParseIsDataAvailable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'bPFCscParseIdDirty'           is [\(String(describing: self.bPFCscParseIdDirty))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseAllKeys'           is [\(String(describing: self.sPFCscParseAllKeys))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseName'              is [\(String(describing: self.sPFCscParseName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseLastLocDate'       is [\(String(describing: self.sPFCscParseLastLocDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseLastLocTime'       is [\(String(describing: self.sPFCscParseLastLocTime))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseLastLatitude'      is [\(String(describing: self.sPFCscParseLastLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscParseLastLongitude'     is [\(String(describing: self.sPFCscParseLastLongitude))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'pfCscObjectLatitude'          is [\(String(describing: self.pfCscObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'pfCscObjectLongitude'         is [\(String(describing: self.pfCscObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscObjectLatitude'         is [\(String(describing: self.sPFCscObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sPFCscObjectLongitude'        is [\(String(describing: self.sPFCscObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'dblPFCscObjectLatitude'       is [\(String(describing: self.dblPFCscObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'dblPFCscObjectLongitude'      is [\(String(describing: self.dblPFCscObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'dblConvertedLatitude'         is [\(String(describing: self.dblConvertedLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'dblConvertedLongitude'        is [\(String(describing: self.dblConvertedLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sCurrentLocationName'         is [\(String(describing: self.sCurrentLocationName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sCurrentCity'                 is [\(String(describing: self.sCurrentCity))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sCurrentCountry'              is [\(String(describing: self.sCurrentCountry))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sCurrentPostalCode'           is [\(String(describing: self.sCurrentPostalCode))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'sCurrentTimeZone'             is [\(String(describing: self.sCurrentTimeZone))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): 'bCurrentAddessLookupComplete' is [\(String(describing: self.bCurrentAddessLookupComplete))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayParsePFCscDataItemToLog().

    public func constructParsePFCscDataItemFromPFObject(idPFCscObject:Int = 0, pfCscObject:PFObject)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'idPFCscObject' is (\(idPFCscObject)) - 'pfCscObject' is [\(String(describing: pfCscObject))]...")

        // Assign the various field(s) of this object from the supplied PFObject...

        self.idPFCscObject                = idPFCscObject                                                             
        self.pfCscObject                  = pfCscObject                                                             
        
        self.sPFCscParseClassName         = pfCscObject.parseClassName
    //  if pfCscObject.objectId != nil && pfCscObject.objectId?.count ?? <#default value#> > 0 { self.sPFCscParseObjectId = pfCscObject.objectId } else { self.sPFCscParseObjectId = "" }
        self.sPFCscParseObjectId          = pfCscObject.objectId  != nil ? pfCscObject.objectId!  : ""
        self.datePFCscParseCreatedAt      = pfCscObject.createdAt != nil ? pfCscObject.createdAt! : nil
        self.datePFCscParseUpdatedAt      = pfCscObject.updatedAt != nil ? pfCscObject.updatedAt! : nil
        self.aclPFCscParse                = pfCscObject.acl
        self.bPFCscParseIsDataAvailable   = pfCscObject.isDataAvailable
        self.bPFCscParseIdDirty           = pfCscObject.isDirty
        self.sPFCscParseAllKeys           = pfCscObject.allKeys

        self.sPFCscParseName              = String(describing: pfCscObject.object(forKey:"name")!)
        self.sPFCscParseLastLocDate       = String(describing: (pfCscObject.object(forKey:"lastLocDate") ?? ""))
        self.sPFCscParseLastLocTime       = String(describing: (pfCscObject.object(forKey:"lastLocTime") ?? "")).lowercased()
        self.sPFCscParseLastLatitude      = String(describing: (pfCscObject.object(forKey:"latitude")    ?? ""))
        self.sPFCscParseLastLongitude     = String(describing: (pfCscObject.object(forKey:"longitude")   ?? ""))
        
        self.pfCscObjectLatitude          = (pfCscObject.object(forKey:"latitude"))  != nil ? pfCscObject.object(forKey:"latitude")  : nil
        self.pfCscObjectLongitude         = (pfCscObject.object(forKey:"longitude")) != nil ? pfCscObject.object(forKey:"longitude") : nil
        self.sPFCscObjectLatitude         = String(describing: self.pfCscObjectLatitude!)
        self.sPFCscObjectLongitude        = String(describing: self.pfCscObjectLongitude!)
        self.dblPFCscObjectLatitude       = Double(self.sPFCscObjectLatitude)  ?? 0.0
        self.dblPFCscObjectLongitude      = Double(self.sPFCscObjectLongitude) ?? 0.0
        self.dblConvertedLatitude         = Double(String(describing: pfCscObject.object(forKey:"latitude")!))  ?? 0.0
        self.dblConvertedLongitude        = Double(String(describing: pfCscObject.object(forKey:"longitude")!)) ?? 0.0
        
        self.sCurrentLocationName         = ""
        self.sCurrentCity                 = ""
        self.sCurrentCountry              = ""
        self.sCurrentPostalCode           = ""
        self.sCurrentTimeZone             = ""

        self.bCurrentAddessLookupComplete = false

        if (self.jmAppDelegateVisitor.jmAppCLModelObservable2 != nil)
        {

            let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor.jmAppCLModelObservable2!

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): Calling 'updateGeocoderLocation()' for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)]...")

            let _ = clModelObservable2.updateGeocoderLocations(requestID: self.idPFCscObject, 
                                                               latitude:  self.dblConvertedLatitude, 
                                                               longitude: self.dblConvertedLongitude, 
                                                               withCompletionHandler:
                                                                   { (requestID:Int, dictCurrentLocation:[String:Any]) in
                                                               
                                                                       self.sCurrentLocationName         = String(describing: (dictCurrentLocation["sCurrentLocationName"] ?? ""))
                                                                       self.sCurrentCity                 = String(describing: (dictCurrentLocation["sCurrentCity"]         ?? ""))
                                                                       self.sCurrentCountry              = String(describing: (dictCurrentLocation["sCurrentCountry"]      ?? ""))
                                                                       self.sCurrentPostalCode           = String(describing: (dictCurrentLocation["sCurrentPostalCode"]   ?? ""))
                                                                       self.sCurrentTimeZone             = String(describing: (dictCurrentLocation["tzCurrentTimeZone"]    ?? ""))
                                                                       self.bCurrentAddessLookupComplete = true
                                                               
                                                                   }
                                                              )

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFCscObject)): CoreLocation (service) is NOT available...")

            self.bCurrentAddessLookupComplete = false

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func constructParsePFCscDataItemFromPFObject(idPFCscObject:Int, pfCscObject:PFObject).

}   // End of class ParsePFCscDataItem(NSObject, Identifiable).


//
//  JmAppParseCoreManager.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 11/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import ParseCore
import SwiftData

// Implementation class to handle access to the ParseCore framework.

//@MainActor
public class JmAppParseCoreManager: NSObject, ObservableObject
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppParseCoreManager"
        static let sClsVers      = "v1.1802"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // App Data field(s):

                    let timerPublisher                                                   = Timer.publish(every: (3 * 60), on: .main, in: .common).autoconnect()
                                                                                           // Note: implement .onReceive() on a field within the displaying 'View'...
                                                                                           // 
                                                                                           // @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager
                                                                                           // ...
                                                                                           // .onReceive(jmAppParseCoreManager.timerPublisher,
                                                                                           //     perform:
                                                                                           //     { dtObserved in
                                                                                           //         ...
                                                                                           //     })

       public       var parseConfig:ParseClientConfiguration?                            = nil       
       public       var pfInstallationCurrent:PFInstallation?                            = nil
       public       var bPFInstallationHasBeenEnumerated:Bool                            = false

    @Published      var cPFCscObjectsRefresh:Int                                         = 0
    @Published      var cPFCscObjects:Int                                                = 0
    @Published      var listPFCscDataItems:[ParsePFCscDataItem]                          = []
                    var listPFCscNameItems:[String]                                      = []

    @Published      var dictPFAdminsDataItems:[String:ParsePFAdminsDataItem]             = [:]

    @Published      var dictTherapistTidXref:[String:String]                             = [String:String]()
                                                                                           // [String:String]
                                                                                           // Key:Tid(String)                       -> TherapistName (String)
                                                                                           // Key:TherapistName(String)             -> Tid (String)
                                                                                           // Key:TherapistName(String)<lowercased> -> Tid (String)

    @Published      var dictSchedPatientLocItems:[String:[ScheduledPatientLocationItem]] = [String:[ScheduledPatientLocationItem]]()
                                                                                           // [String:[ScheduledPatientLocationItem]]

       private      var bHasDictSchedPatientLocItemsBeenDisplayed:Bool                   = false

                    var jmAppDelegateVisitor:JmAppDelegateVisitor?                       = nil
                                                                                           // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                                           // as having it reference the 'shared' instance of 
                                                                                           // JmAppDelegateVisitor causes a circular reference
                                                                                           // between the 'init()' methods of the 2 classes...
    @ObservedObject var jmAppSwiftDataManager:JmAppSwiftDataManager                      = JmAppSwiftDataManager.ClassSingleton.appSwiftDataManager

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

                    var  listPreXCGLoggerMessages:[String]                               = Array()

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")

        return

    }   // End of override init().

    private func xcgLogMsg(_ sMessage:String)
    {

        if (self.jmAppDelegateVisitor != nil)
        {

            if (self.jmAppDelegateVisitor!.bAppDelegateVisitorLogFilespecIsUsable == true)
            {

                self.jmAppDelegateVisitor!.xcgLogMsg(sMessage)

            }
            else
            {

                print("\(sMessage)")

                self.listPreXCGLoggerMessages.append(sMessage)

            }

        }
        else
        {

            print("\(sMessage)")

            self.listPreXCGLoggerMessages.append(sMessage)

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
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'parseConfig': [\(String(describing: self.parseConfig))]")
        asToString.append("'pfInstallationCurrent': [\(String(describing: self.pfInstallationCurrent))]")
        asToString.append("'bPFInstallationHasBeenEnumerated': [\(String(describing: self.bPFInstallationHasBeenEnumerated))]")
        asToString.append("'cPFCscObjectsRefresh': [\(String(describing: self.cPFCscObjectsRefresh))]")
        asToString.append("'cPFCscObjects': [\(String(describing: self.cPFCscObjects))]")
        asToString.append("'listPFCscDataItems': [\(String(describing: self.listPFCscDataItems))]")
        asToString.append("'listPFCscNameItems': [\(String(describing: self.listPFCscNameItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictPFAdminsDataItems': [\(String(describing: self.dictPFAdminsDataItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictSchedPatientLocItems': [\(String(describing: self.dictSchedPatientLocItems))]")
        asToString.append("'bHasDictSchedPatientLocItemsBeenDisplayed': [\(String(describing: self.bHasDictSchedPatientLocItemsBeenDisplayed))]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    // (Call-back) Method to set the jmAppDelegateVisitor instance...

    public func setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:JmAppDelegateVisitor)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - supplied parameter 'jmAppDelegateVisitor' is [\(jmAppDelegateVisitor)]...")

        // Set the AppDelegateVisitor instance...

        self.jmAppDelegateVisitor = jmAppDelegateVisitor
    
        // Spool <any> pre-XDGLogger (via the AppDelegateVisitor) message(s) into the Log...

        if (self.listPreXCGLoggerMessages.count > 0)
        {

            self.xcgLogMsg("")
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreManager === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreManager === >>>")
            self.xcgLogMsg("")

        }

        // Finish performing any setup with the ParseCore (Client) framework...
        // --------------------------------------------------------------------------------------------------
        // ParseCore doc: -> https://docs.parseplatform.org/ios/guide/
        //
        //     let parseConfig = ParseClientConfiguration {
        //                                                 $0.applicationId = "parseAppId"
        //                                                 $0.clientKey     = "parseClientKey"
        //                                                 $0.server        = "parseServerUrlString"
        //                                                }
        //     Parse.initialize(with: parseConfig)
        // --------------------------------------------------------------------------------------------------

        self.xcgLogMsg("\(sCurrMethodDisp) Creating the ParseCore (Client) 'configuration'...")

        self.parseConfig = ParseClientConfiguration
                               {
                                   $0.applicationId = "VDN7Gs0vvYMg5yokvC4I7Nh521hbm9NF2jluCgW3"
                                   $0.clientKey     = "txwqvA4yxFiShXAiVyY3tMNG00vKpiW6UmdugVnI"
                                   $0.server        = "https://pg-app-1ye5iesplk164f4dsvq8gtaddgv1xc.scalabl.cloud/1/"
                               }

        self.xcgLogMsg("\(sCurrMethodDisp) Passing the ParseCore (Client) 'configuration' on to ParseCore...")

        Parse.initialize(with:self.parseConfig!)

        self.xcgLogMsg("\(sCurrMethodDisp) Passed  the ParseCore (Client) 'configuration' on to ParseCore...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    public func getJmAppParsePFQueryForAdmins()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue a PFQuery for the 'Admins' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'Admins' class...")

        let pfQueryAdmins:PFQuery = PFQuery(className:"Admins")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'Admins' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryAdmins' is [\(String(describing: pfQueryAdmins))]...")

        do
        {
            
            pfQueryAdmins.whereKeyExists("tid")
            pfQueryAdmins.whereKeyExists("password")
            
            pfQueryAdmins.limit = 1000
            
            let listPFAdminsObjects:[PFObject]? = try pfQueryAdmins.findObjects()
            
            if (listPFAdminsObjects != nil &&
                listPFAdminsObjects!.count > 0)
            {
                
                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryAdmins' returned a count of #(\(listPFAdminsObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryAdmins'...")

                var cPFAdminsObjects:Int   = 0
                self.dictPFAdminsDataItems = [:]

                for pfAdminsObject in listPFAdminsObjects!
                {

                    cPFAdminsObjects += 1

                    let parsePFAdminsDataItem:ParsePFAdminsDataItem = ParsePFAdminsDataItem()

                    parsePFAdminsDataItem.constructParsePFAdminsDataItemFromPFObject(idPFAdminsObject:cPFAdminsObjects, pfAdminsObject:pfAdminsObject)

                    let sPFAdminsParseTID:String = parsePFAdminsDataItem.sPFAdminsParseTID

                    if (sPFAdminsParseTID.count  < 1 ||
                        sPFAdminsParseTID       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFAdminsObjects)) 'parsePFAdminsDataItem' - the 'tid' field is nil or '-N/A-' - Warning!")

                        continue

                    }

                    self.dictPFAdminsDataItems[sPFAdminsParseTID] = parsePFAdminsDataItem

                    self.xcgLogMsg("\(sCurrMethodDisp) Added object #(\(cPFAdminsObjects)) 'parsePFAdminsDataItem' keyed by 'sPFAdminsParseTID' of [\(sPFAdminsParseTID)] to the dictionary of item(s)...")

                }
                
                if (self.dictPFAdminsDataItems.count > 0)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Adding the 'TherapistFile' query data to the dictionary of 'parsePFAdminsDataItem' item(s)...")

                    self.getJmAppParsePFQueryForTherapistFileToAddToAdmins()

                    self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of 'parsePFAdminsDataItem' item(s)...")

                    for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
                    {

                        parsePFAdminsDataItem.displayParsePFAdminsDataItemToLog()

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) Copying the item(s) from the dictionary of 'parsePFAdminsDataItem' to SwiftData...")

                    self.copyJmAppParsePFAdminsToSwiftData()

                }

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryAdmins' - Details: \(error) - Error!")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForAdmins().

    public func getJmAppParsePFQueryForTherapistFileToAddToAdmins()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue a PFQuery for the 'TherapistFile' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'TherapistFile' class...")

        let pfQueryTherapist:PFQuery = PFQuery(className:"TherapistFile")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'TherapistFile' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryTherapist' is [\(String(describing: pfQueryTherapist))]...")

        do
        {
            
            pfQueryTherapist.whereKeyExists("ID")
            pfQueryTherapist.whereKeyExists("name")

            pfQueryTherapist.whereKey("notActive", equalTo:false)
            
            pfQueryTherapist.limit = 1000
            
            let listPFTherapistObjects:[PFObject]? = try pfQueryTherapist.findObjects()
            
            if (listPFTherapistObjects        != nil &&
                listPFTherapistObjects!.count  > 0)
            {
                
                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryTherapist' returned a count of #(\(listPFTherapistObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryTherapist'...")
                self.xcgLogMsg("\(sCurrMethodDisp) The 'tracking' location(s) list with #(\(self.listPFCscNameItems.count)) item(s) is [\(self.listPFCscNameItems)])...")

                var cPFTherapistObjects:Int   = 0

                for pfTherapistObject in listPFTherapistObjects!
                {

                    cPFTherapistObjects += 1

                    let sPFTherapistParseTID:String = String(describing: (pfTherapistObject.object(forKey:"ID")  ?? "-N/A-"))

                    if (sPFTherapistParseTID.count  < 1 ||
                        sPFTherapistParseTID       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'tid' field is nil or '-N/A-' - Warning!")

                        continue

                    }

                    let sPFTherapistParseName:String = String(describing: (pfTherapistObject.object(forKey:"name") ?? "-N/A-"))

                    if (sPFTherapistParseName.count  < 1 ||
                        sPFTherapistParseName       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'name' field is nil or '-N/A-' - Warning!")

                        continue

                    }

                    DispatchQueue.main.async
                    {
                    
                        // Build the Tid/TherapistName Xref dictionary...

                        let sPFTherapistParseNameLower:String = sPFTherapistParseName.lowercased()

                        self.dictTherapistTidXref[sPFTherapistParseTID]       = sPFTherapistParseName
                        self.dictTherapistTidXref[sPFTherapistParseName]      = sPFTherapistParseTID
                        self.dictTherapistTidXref[sPFTherapistParseNameLower] = sPFTherapistParseTID

                        // Track the Therapist in the dictionary of Scheduled Patient 'location' item(s)...

                        if (self.dictSchedPatientLocItems[sPFTherapistParseTID] == nil)
                        {
                    
                            let scheduledPatientLocationItem:ScheduledPatientLocationItem =
                                    ScheduledPatientLocationItem(pfTherapistFileItem:pfTherapistObject)
                    
                            var listScheduledPatientLocationItems:[ScheduledPatientLocationItem] = [ScheduledPatientLocationItem]()
                    
                            listScheduledPatientLocationItems.append(scheduledPatientLocationItem)
                    
                            self.dictSchedPatientLocItems[sPFTherapistParseTID] = listScheduledPatientLocationItems
                    
                            self.xcgLogMsg("\(sCurrMethodDisp) Added an initial Item 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] as a 'placeholder'...")
                    
                        }
                        else
                        {
                    
                            self.xcgLogMsg("\(sCurrMethodDisp) Skipped adding an initial Item 'ScheduledPatientLocationItem' (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) - key 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] already exists...")
                    
                        }
                    
                    }

                    // Track the Therapist 'name' in the PFAdminsDataItem(s) dictionary...
                
                    if let parsePFAdminsDataItem:ParsePFAdminsDataItem = self.dictPFAdminsDataItems[sPFTherapistParseTID]
                    {

                        parsePFAdminsDataItem.sPFAdminsParseName = sPFTherapistParseName

                        self.xcgLogMsg("\(sCurrMethodDisp) Using object #(\(cPFTherapistObjects)) 'pfTherapistObject' - to set the 'name' field of [\(sPFTherapistParseName)] in the dictionary of 'parsePFAdminsDataItem' item(s)...")

                    }
                    else
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'tid' field of [\(sPFTherapistParseTID)] is NOT in the dictionary of 'parsePFAdminsDataItem' item(s)...")

                        continue

                    }

                }
                
            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryTherapist' returned a count of #(\(listPFTherapistObjects!.count)) PFObject(s) - Error!")

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryAdmins' - Details: \(error) - Error!")
            
        }

        // If we created item(s) in the 'dictSchedPatientLocItems' and we haven't displayed them, then display them...

        if (bHasDictSchedPatientLocItemsBeenDisplayed == false)
        {

            bHasDictSchedPatientLocItemsBeenDisplayed = true

            if (self.dictSchedPatientLocItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s)...")

                let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
                var cPFTherapistParseTIDs:Int = 0

                for (sPFTherapistParseTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
                {

                    cPFTherapistParseTIDs += 1

                    if (sPFTherapistParseTID.count  < 1 ||
                        sPFTherapistParseTID       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                        continue

                    }

                    if (listScheduledPatientLocationItems.count < 1)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                        continue

                    }

                    var cScheduledPatientLocationItems:Int = 0

                    for scheduledPatientLocationItem in listScheduledPatientLocationItems
                    {

                        cScheduledPatientLocationItems += 1

                        self.xcgLogMsg("\(sCurrMethodDisp) Of #(\(cPFTherapistTotalTIDs)) TIDs - For TID [\(sPFTherapistParseTID)] - Displaying 'scheduledPatientLocationItem' item #(\(cPFTherapistParseTIDs).\(cScheduledPatientLocationItems)):")

                        scheduledPatientLocationItem.displayScheduledPatientLocationItemToLog()

                    }

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

            }

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForTherapistFileToAddToAdmins().

    public func getJmAppParsePFQueryForCSC()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue a PFQuery for the 'CSC' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'CSC' class...")

        let pfQueryCSC:PFQuery = PFQuery(className:"CSC")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'CSC' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryCSC' is [\(String(describing: pfQueryCSC))]...")

        do
        {
            
            pfQueryCSC.whereKeyExists("name")
            pfQueryCSC.whereKeyExists("lastLocDate")
            pfQueryCSC.whereKeyExists("lastLocTime")
            pfQueryCSC.whereKeyExists("latitude")
            pfQueryCSC.whereKeyExists("longitude")
            
            pfQueryCSC.whereKey("updatedAt", greaterThan:(Calendar.current.date(byAdding: .day, value: -1, to: .now)!))
            
            pfQueryCSC.addDescendingOrder("updatedAt")
            
            pfQueryCSC.limit = 1000
            
            let listPFCscObjects:[PFObject]? = try pfQueryCSC.findObjects()
            
            if (listPFCscObjects != nil &&
                listPFCscObjects!.count > 0)
            {
                
                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryCSC' returned a count of #(\(listPFCscObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryCSC'...")

                self.cPFCscObjects      = 0
                self.listPFCscDataItems = []
                self.listPFCscNameItems = []

                for pfCscObject in listPFCscObjects!
                {

                    self.cPFCscObjects += 1

                    let parsePFCscDataItem:ParsePFCscDataItem = ParsePFCscDataItem()

                    parsePFCscDataItem.constructParsePFCscDataItemFromPFObject(idPFCscObject:cPFCscObjects, pfCscObject:pfCscObject)

                    self.listPFCscNameItems.append(parsePFCscDataItem.sPFCscParseName)
                    self.listPFCscDataItems.append(parsePFCscDataItem)

                    self.xcgLogMsg("\(sCurrMethodDisp) Added object #(\(self.cPFCscObjects)) 'parsePFCscDataItem' to the list of name(s)/item(s)...")

                }

                // Gather the PFQueries to construct the new ScheduledPatientLocationItem(s) in the background...

                self.xcgLogMsg("\(sCurrMethodDisp) Calling 'self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient location data...")

                self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()
                
                self.xcgLogMsg("\(sCurrMethodDisp) Called  'self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient location data...")

            //  Thread.sleep(forTimeInterval: 0.2)  // This 'sleeps' but did NOT work to fix the location issue(s)...

                DispatchQueue.main.asyncAfter(deadline:(.now() + 0.6))
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Displaying the list of 'parsePFCscDataItem' item(s)...")

                    for parsePFCscDataItem in self.listPFCscDataItems
                    {

                        parsePFCscDataItem.displayParsePFCscDataItemToLog()

                    }

                    // Kick the 'cPFCscObjectsRefresh' count to force any SwiftUI display(s) to refresh...

                    self.cPFCscObjectsRefresh += 1

                }
                
            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryCSC' returned an 'empty' or nil list of PFObject(s)...")

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryCSC' - Details: \(error) - Error!")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForCSC().

    public func getJmAppParsePFInstallationCurrentInstance()->PFInstallation?
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Get and return the 'current' PFInstallation instance...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling the PFInstallation 'current()' method...")

        self.pfInstallationCurrent = PFInstallation.current()

        self.xcgLogMsg("\(sCurrMethodDisp) Called  the PFInstallation 'current()' method...")

        // If 'current' PFInstallation instance is NOT nil, then dump the PFInstallation 'properties'...

        if (self.bPFInstallationHasBeenEnumerated == false)
        {

            if (self.pfInstallationCurrent != nil)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.installationId' is [\(String(describing: self.pfInstallationCurrent?.installationId))]...")
                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.deviceType' is [\(String(describing: self.pfInstallationCurrent?.deviceType))]...")
                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.deviceToken' is [\(String(describing: self.pfInstallationCurrent?.deviceToken))]...")
                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.badge' is [\(String(describing: self.pfInstallationCurrent?.badge))]...")
                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.timeZone' is [\(String(describing: self.pfInstallationCurrent?.timeZone))]...")
                self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationCurrent.channels' is [\(String(describing: self.pfInstallationCurrent?.channels))]...")

                do
                {

                    let pfInstallationQuery = PFInstallation.query()

                    self.xcgLogMsg("\(sCurrMethodDisp) 'pfInstallationQuery' is (\(String(describing: pfInstallationQuery))...")

                    pfInstallationQuery?.whereKeyExists("AppVersionAndBuildNumber")

                    let listPFObjects:[PFObject]? = try pfInstallationQuery?.findObjects()

                    if (listPFObjects != nil &&
                        listPFObjects!.count > 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfInstallationCurrent' returned a count of #(\(listPFObjects!.count)) PFObject(s)...")

                    }

                }
                catch
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed to query 'pfInstallationCurrent' (but this is 'normal') - Details: \(error) - Error!")

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfInstallationCurrent' is nil - Error!")

            }

            self.bPFInstallationHasBeenEnumerated = true

        }

    //  // TESTING: Always call the various 'testing' method(s)...for PRODUCTION this is handled in a View...
    //
    //  self.getJmAppParsePFQueryForAdmins()
    //  self.getJmAppParsePFQueryForCSC()

        // Exit:
        
    //  self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.pfInstallationCurrent' is [\(String(describing: self.pfInstallationCurrent))] - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.pfInstallationCurrent' is [\(String(describing: self.pfInstallationCurrent))]...")
    
        return self.pfInstallationCurrent

    } // End of public func getJmAppParsePFInstallationCurrentInstance()->PFInstallation?.

    public func copyJmAppParsePFAdminsToSwiftData()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Copy (if any) PFQuery 'Admins' to SwiftData...

        if (self.dictPFAdminsDataItems.count > 0)
        {

            if (self.jmAppSwiftDataManager.modelContext != nil)
            {

            //  let pfAdminsSwiftDataItemsDescriptor = FetchDescriptor<PFAdminsSwiftDataItem>()

                DispatchQueue.main.async
                {

                    do
                    {

                    //  let pfAdminsSwiftDataItems:[PFAdminsSwiftDataItem] = try self.jmAppSwiftDataManager.modelContext!.fetch(pfAdminsSwiftDataItemsDescriptor)
                    //  let cPFAdminsSwiftDataItems:Int                    = pfAdminsSwiftDataItems.count
                    //
                    //  if (cPFAdminsSwiftDataItems > 0)
                        if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count > 0)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Deleting ALL #(\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) existing SwiftData PFQuery 'Admins' item(s)...")

                            try self.jmAppSwiftDataManager.modelContext!.delete(model:PFAdminsSwiftDataItem.self)

                            self.xcgLogMsg("\(sCurrMethodDisp) Deleted  ALL #(\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) existing SwiftData PFQuery 'Admins' item(s)...")

                        }
                        else
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping the deletion of ALL existing SwiftData PFQuery 'Admins' item(s) - there are NO existing item(s)...")

                        }

                    } 
                    catch
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Failed to delete ALL SwiftData PFQuery 'Admins' items() - Details: \(error) - Error!")

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) Copying (\(self.dictPFAdminsDataItems.count)) PFQuery 'Admins' item(s) to SwiftData...")

                    var cPFAdminsDataItemsAdded:Int = 0

                    for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
                    {

                        let newPFAdminsSwiftDataItem = PFAdminsSwiftDataItem(timestamp:   Date(),
                                                                             sCreatedBy:  "\(ClassInfo.sClsDisp)",
                                                                             pfAdminsItem:parsePFAdminsDataItem)

                    //  self.jmAppSwiftDataManager.modelContext!.insert(newPFAdminsSwiftDataItem)
                        self.jmAppSwiftDataManager.addAppSwiftDataItem(pfAdminsSwiftDataItem:newPFAdminsSwiftDataItem, 
                                                                       bShowDetailAfterAdd:  false)

                        self.xcgLogMsg("\(sCurrMethodDisp) Added 'newPFAdminsSwiftDataItem' of [\(String(describing: newPFAdminsSwiftDataItem.toString()))] to the SwiftDataManager...")

                        cPFAdminsDataItemsAdded += 1

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) Added #(\(cPFAdminsDataItemsAdded)) PFQuery 'Admins' item(s) to SwiftData from #(\(self.dictPFAdminsDataItems.count)) available item(s)...")

                    self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

                    self.jmAppSwiftDataManager.detailAppSwiftDataToLog()

                    self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

                //  do
                //  {
                //
                //      try self.jmAppSwiftDataManager.modelContext!.save()
                //
                //      self.xcgLogMsg("\(sCurrMethodDisp) SwiftData ModelContext has been saved after adding PFQuery 'Admins' item(s)...")
                //
                //      self.jmAppSwiftDataManager.pfAdminsSwiftDataItems   = try self.jmAppSwiftDataManager.modelContext!.fetch(pfAdminsSwiftDataItemsDescriptor)
                //  //  self.jmAppSwiftDataManager?.cPFAdminsSwiftDataItems = self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count
                //
                //      if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count > 0)
                //      {
                //
                //          self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable = true
                //      //  self.jmAppSwiftDataManager?.bArePFAdminsSwiftDataItemsAvailable.toggle()
                //
                //      }
                //
                //      self.xcgLogMsg("\(ClassInfo.sClsDisp) Toggling SwiftData 'self.jmAppSwiftDataManager?.pfAdminsSwiftDataItems' has (\(String(describing: self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count))) 'login' item(s)...")
                //      self.xcgLogMsg("\(ClassInfo.sClsDisp) Toggling SwiftData 'self.jmAppSwiftDataManager?.bArePFAdminsSwiftDataItemsAvailable' is [\(String(describing: self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable))]...")
                //
                //  }
                //  catch
                //  {
                //
                //      self.xcgLogMsg("\(sCurrMethodDisp) SwiftData ModelContext has failed to save after adding PFQuery 'Admins' item(s) - Details: \(error) - Error!")
                //
                //  }

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Copy failed - 'self.jmAppSwiftDataManager?.modelContent' is nil - NO 'target' to copy (\(self.dictPFAdminsDataItems.count)) item(s) too - Warning!")

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Copy failed - 'self.dictPFAdminsDataItems' has NO PFQuery 'Admins' item(s) - Warning!")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func copyJmAppParsePFAdminsToSwiftData().

    public func gatherJmAppParsePFQueriesForScheduledLocationsInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        let dispatchGroup = DispatchGroup()

        do
        {

            dispatchGroup.enter()

            let dispatchQueue = DispatchQueue(label: "GatherAppPFQueriesInBackground", qos: .userInitiated)

            dispatchQueue.async
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Invoking background PFQueries method(s)...");

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'PatientCalDay' class...")

                self.gatherJmAppParsePFQueriesForPatientCalDayInBackground()

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'PatientCalDay' class...")

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'BackupVisit' class...")

                self.gatherJmAppParsePFQueriesForBackupVisitInBackground()

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'BackupVisit' class...")

                self.xcgLogMsg("\(sCurrMethodDisp) Invoked  background PFQueries method(s)...");

                if (self.dictSchedPatientLocItems.count > 0)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s)...")

                    let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
                    var cPFTherapistParseTIDs:Int = 0

                    for (sPFTherapistParseTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
                    {

                        cPFTherapistParseTIDs += 1

                        if (sPFTherapistParseTID.count  < 1 ||
                            sPFTherapistParseTID       == "-N/A-")
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                            continue

                        }

                        if (listScheduledPatientLocationItems.count < 1)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                            continue

                        }

                        var cScheduledPatientLocationItems:Int = 0

                        for scheduledPatientLocationItem in listScheduledPatientLocationItems
                        {

                            cScheduledPatientLocationItems += 1

                            self.xcgLogMsg("\(sCurrMethodDisp) Of #(\(cPFTherapistTotalTIDs)) TIDs - For TID [\(sPFTherapistParseTID)] - Displaying 'scheduledPatientLocationItem' item #(\(cPFTherapistParseTIDs).\(cScheduledPatientLocationItems)):")

                            scheduledPatientLocationItem.displayScheduledPatientLocationItemToLog()

                        }

                    }

                }
                else
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

                }

            }

            dispatchGroup.leave()

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForScheduledLocationsInBackground().
    
    public func gatherJmAppParsePFQueriesForPatientCalDayInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        // Issue a PFQueries to pull Therapist data from PatientCalDay for the current day...

        let dtFormatterDate:DateFormatter = DateFormatter()

        dtFormatterDate.locale     = Locale(identifier: "en_US")
        dtFormatterDate.timeZone   = TimeZone.current
        dtFormatterDate.dateFormat = "yyyy-MM-dd"

        let dateForCurrentQuery:Date = Date.now
        let sCurrentQueryDate:String = dtFormatterDate.string(from:dateForCurrentQuery)

        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentQueryDate' is [\(String(describing: sCurrentQueryDate))] <formatted>...")

        // If we have item(s) in the 'dictSchedPatientLocItems' dictionary, then repopulate them with PatientCalDay information...

        if (self.dictSchedPatientLocItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s) to gather 'PatientCalDay' information...")

            let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
            var cPFTherapistParseTIDs:Int = 0

            for (sPFTherapistParseTID, listOfOldScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            {

                cPFTherapistParseTIDs += 1

                if (sPFTherapistParseTID.count  < 1 ||
                    sPFTherapistParseTID       == "-N/A-")
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                    continue

                }

                if (listOfOldScheduledPatientLocationItems.count < 1)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistTotalTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listOfOldScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                    continue

                }

                // 'listOfOldScheduledPatientLocationItems' has at least 1 item (added as a 'placeholder' when the 'dictSchedPatientLocItems' was built.
                // Grab the 1st item in the list to use as a 'template' object and then clear the list (to be rebuilt)...

                let scheduledPatientLocationItemTemplate:ScheduledPatientLocationItem = listOfOldScheduledPatientLocationItems[0]
                var listScheduledPatientLocationItems:[ScheduledPatientLocationItem]  = [ScheduledPatientLocationItem]()

                // Issue a PFQuery for the 'PatientCalDay' class...

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'PatientCalDay' class...")

                let pfQueryPatientCalDay:PFQuery = PFQuery(className:"PatientCalDay")

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'PatientCalDay' class...")

                // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

                self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryPatientCalDay' is [\(String(describing: pfQueryPatientCalDay))]...")

                do
                {

                //  "class" : "select * from PatientCalDay where tid = 261 and VDate = \"2024-12-03\";",

                    pfQueryPatientCalDay.whereKeyExists("pid")
                    pfQueryPatientCalDay.whereKeyExists("startTime")

                //  pfQueryPatientCalDay.whereKey("tid",   equalTo:sPFTherapistParseTID)
                    pfQueryPatientCalDay.whereKey("tid",   equalTo:Int(sPFTherapistParseTID) as Any)
                    pfQueryPatientCalDay.whereKey("VDate", equalTo:sCurrentQueryDate)

                //  pfQueryPatientCalDay.addAscendingOrder("startTime")

                    pfQueryPatientCalDay.limit = 1000

                    let listPFPatientCalDayObjects:[PFObject]? = try pfQueryPatientCalDay.findObjects()

                    if (listPFPatientCalDayObjects != nil &&
                        listPFPatientCalDayObjects!.count > 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryPatientCalDay' returned a count of #(\(listPFPatientCalDayObjects!.count)) PFObject(s)...")
                        self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryPatientCalDay'...")

                        var cPFPatientCalDayObjects:Int = 0

                        for pfPatientCalDayObject in listPFPatientCalDayObjects!
                        {

                            cPFPatientCalDayObjects += 1

                            let scheduledPatientLocationItem:ScheduledPatientLocationItem =
                                    ScheduledPatientLocationItem(scheduledPatientLocationItem:scheduledPatientLocationItemTemplate)

                            scheduledPatientLocationItem.updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:pfPatientCalDayObject)

                            listScheduledPatientLocationItems.append(scheduledPatientLocationItem)

                            self.xcgLogMsg("\(sCurrMethodDisp) Added an updated Item #(\(cPFPatientCalDayObjects)) 'scheduledPatientLocationItem' of [\(scheduledPatientLocationItem)] to the list 'listScheduledPatientLocationItems' for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                        }

                        if (cPFPatientCalDayObjects > 0)
                        {

                            if (cPFPatientCalDayObjects > 1)
                            {

                                self.xcgLogMsg("\(sCurrMethodDisp) Sorting #(\(cPFPatientCalDayObjects)) Item(s) in the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                                listScheduledPatientLocationItems.sort
                                { (scheduledPatientLocationItem1, scheduledPatientLocationItem2) in

                                    return scheduledPatientLocationItem1.iVDateStartTime24h > scheduledPatientLocationItem1.iVDateStartTime24h

                                }

                                self.xcgLogMsg("\(sCurrMethodDisp) Sorted  #(\(cPFPatientCalDayObjects)) Item(s) in the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                            }
                        
                            DispatchQueue.main.async
                            {

                                self.dictSchedPatientLocItems[sPFTherapistParseTID] = listScheduledPatientLocationItems

                                self.xcgLogMsg("\(sCurrMethodDisp) Added #(\(cPFPatientCalDayObjects)) updated Item(s) to the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                            }
                        
                        }

                    }
                    else
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryPatientCalDay' returned an 'empty' or nil list of PFObject(s)...")

                    }

                }
                catch
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryPatientCalDay' - Details: \(error) - Error!")

                }

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to enumerate the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForPatientCalDayInBackground().
    
    public func gatherJmAppParsePFQueriesForBackupVisitInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        // Issue a PFQueries to pull Patient (Visit) data from BackupVisit for the last 30 day(s)...
        //     :: From PFQuery Class: 'BackupVisit' ::
        //
        //     [Query::{ "pid"            : NumberLong(13556), 
        //               "billable"       : NumberLong(1), 
        //               "isTelepractice" : { "$ne" : NumberLong(1) },
        //               "VDate"          : { "$gt" : "2024-11-10" } }]  // Yields all visit(s) in last 30 day(s) or such...
        //     [Sort::{"VDate": -1}]                                     // Yields visit(s) newest to oldest (1st one is newest)...

        let dtFormatterDate:DateFormatter = DateFormatter()

        dtFormatterDate.locale     = Locale(identifier: "en_US")
        dtFormatterDate.timeZone   = TimeZone.current
        dtFormatterDate.dateFormat = "yyyy-MM-dd"

        let dateForCurrentQuery:Date = Calendar.current.date(byAdding: .day, value: -30, to: .now)!
        let sCurrentQueryDate:String = dtFormatterDate.string(from:dateForCurrentQuery)

        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentQueryDate' is [\(String(describing: sCurrentQueryDate))] <formatted>...")

        // If we have item(s) in the 'dictSchedPatientLocItems' dictionary, then repopulate them with BackupVisit information...

        if (self.dictSchedPatientLocItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s) to gather 'BackupVisit' information...")

            let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
            var cPFTherapistParseTIDs:Int = 0

            for (sPFTherapistParseTID, listOfScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            {

                cPFTherapistParseTIDs += 1

                if (sPFTherapistParseTID.count  < 1 ||
                    sPFTherapistParseTID       == "-N/A-")
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                    continue

                }

                if (listOfScheduledPatientLocationItems.count < 1)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistTotalTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listOfScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                    continue

                }

                var cPFPatientParsePIDs:Int = 0 

                for scheduledPatientLocationItem in listOfScheduledPatientLocationItems
                {

                    cPFPatientParsePIDs += 1 

                    if (scheduledPatientLocationItem.iPid < 1)
                    {
                    
                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFPatientParsePIDs)) for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the patient 'pid' field ('iPid') is < 1 - Warning!")

                        continue
                    
                    }
                    
                    // Issue a PFQuery for the 'BackupVisit' class...

                    self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'BackupVisit' class...")

                    let pfQueryBackupVisit:PFQuery = PFQuery(className:"BackupVisit")

                    self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'BackupVisit' class...")

                    // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

                    self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryBackupVisit' is [\(String(describing: pfQueryBackupVisit))]...")

                    do
                    {

                    //  :: From PFQuery Class: 'BackupVisit' ::
                    //
                    //  [Query::{ "pid"            : NumberLong(13556), 
                    //            "billable"       : NumberLong(1), 
                    //            "isTelepractice" : { "$ne" : NumberLong(1) },
                    //            "VDate"          : { "$gt" : "2024-11-10" } }]  // Yields all visit(s) in last 30 day(s) or such...
                    //  [Sort::{"VDate": -1}]                                     // Yields visit(s) newest to oldest (1st one is newest)...

                        self.xcgLogMsg("\(sCurrMethodDisp) Searching for 'pfQueryBackupVisit' Item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] for PID (\(scheduledPatientLocationItem.iPid))...")

                        pfQueryBackupVisit.whereKeyExists("lat")
                        pfQueryBackupVisit.whereKeyExists("long")

                        pfQueryBackupVisit.whereKey("pid",            equalTo:scheduledPatientLocationItem.iPid)
                        pfQueryBackupVisit.whereKey("billable",       equalTo:1)
                        pfQueryBackupVisit.whereKey("isTelepractice", notEqualTo:1)
                        pfQueryBackupVisit.whereKey("VDate",          greaterThan:sCurrentQueryDate)

                        pfQueryBackupVisit.addDescendingOrder("VDate")
                    //  pfQueryBackupVisit.addAscendingOrder("startTime")

                        pfQueryBackupVisit.limit = 1000

                        let listPFBackupVisitObjects:[PFObject]? = try pfQueryBackupVisit.findObjects()

                        if (listPFBackupVisitObjects != nil &&
                            listPFBackupVisitObjects!.count > 0)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryBackupVisit' returned a count of #(\(listPFBackupVisitObjects!.count)) PFObject(s)...")
                            self.xcgLogMsg("\(sCurrMethodDisp) Using the 1st returned 'pfQueryBackupVisit' item...")
                            self.xcgLogMsg("\(sCurrMethodDisp) The entire returned #(\(listPFBackupVisitObjects!.count)) 'pfQueryBackupVisit' item(s) are [\(listPFBackupVisitObjects!)]...")

                            // ------------------------------------------------------------------------------------------------
                            //  >>> Template 1st entry, then search for new Template
                            //  >>>     (if item(s) are available and address == ""),
                            //  >>> to re-Template an item that is address != ""; and posted = 1;...
                            // ------------------------------------------------------------------------------------------------

                            var pfQueryBackupVisitTemplate = listPFBackupVisitObjects![0]

                            if (listPFBackupVisitObjects!.count > 1 &&
                                String(describing: (pfQueryBackupVisitTemplate.object(forKey:"address"))) == "")
                            {

                                for pfBackupVisit in listPFBackupVisitObjects!
                                {

                                    if (String(describing: (pfBackupVisit.object(forKey:"address"))) != "" &&
                                        String(describing: (pfBackupVisit.object(forKey:"posted")))  == "1")
                                    {

                                        pfQueryBackupVisitTemplate = pfBackupVisit
                                        
                                        break;
                                    
                                    }

                                }

                            }

                            scheduledPatientLocationItem.updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:pfQueryBackupVisitTemplate)

                            if (scheduledPatientLocationItem.sLastVDateAddress == "")
                            {

                                self.xcgLogMsg("\(sCurrMethodDisp) Updating 'scheduledPatientLocationItem' by calling 'updateGeocoderLocation()' for Latitude/Longitude of [\(scheduledPatientLocationItem.sLastVDateLatitude)/\(scheduledPatientLocationItem.sLastVDateLongitude)]...")

                                if (self.jmAppDelegateVisitor!.jmAppCLModelObservable2 != nil)
                                {
                                
                                    let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor!.jmAppCLModelObservable2!

                                    let _ = clModelObservable2.updateGeocoderLocations(requestID: 1, 
                                                                                       latitude:  Double(scheduledPatientLocationItem.sLastVDateLatitude)!,
                                                                                       longitude: Double(scheduledPatientLocationItem.sLastVDateLongitude)!, 
                                                                                       withCompletionHandler:
                                                                                           { (requestID:Int, dictCurrentLocation:[String:Any]) in

                                                                                               let sStreetAddress:String = String(describing: (dictCurrentLocation["sCurrentLocationName"]       ?? ""))
                                                                                               let sCity:String          = String(describing: (dictCurrentLocation["sCurrentCity"]               ?? ""))
                                                                                               let sState:String         = String(describing: (dictCurrentLocation["sCurrentAdministrativeArea"] ?? ""))
                                                                                               let sZipCode:String       = String(describing: (dictCurrentLocation["sCurrentPostalCode"]         ?? ""))

                                                                                               scheduledPatientLocationItem.sLastVDateAddress = "\(sStreetAddress), \(sCity), \(sState), \(sZipCode)"

                                                                                               self.xcgLogMsg("\(sCurrMethodDisp) Updated 'scheduledPatientLocationItem' for an address of [\(scheduledPatientLocationItem.sLastVDateAddress)] for Latitude/Longitude of [\(scheduledPatientLocationItem.sLastVDateLatitude)/\(scheduledPatientLocationItem.sLastVDateLongitude)]...")

                                                                                           }
                                                                                      )
                                
                                }

                            }

                            self.xcgLogMsg("\(sCurrMethodDisp) Updated an Item 'scheduledPatientLocationItem' of [\(scheduledPatientLocationItem)] (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] for PID (\(scheduledPatientLocationItem.iPid))...")

                        }
                        else
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryBackupVisit' returned an 'empty' or nil list of PFObject(s)...")

                        }

                    }
                    catch
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryBackupVisit' - Details: \(error) - Error!")

                    }

                }

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to enumerate the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForBackupVisitInBackground().
    
    public func convertTidToTherapistName(sPFTherapistParseTID:String = "")->String
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")

        // Lookup and convert the 'sPFTherapistParseTID' to 'sPFTherapistParseName'...

        var sPFTherapistParseName:String = ""

        if (sPFTherapistParseTID.count > 0)
        {
        
            if (self.dictTherapistTidXref[sPFTherapistParseTID] != nil)
            {

                sPFTherapistParseName = self.dictTherapistTidXref[sPFTherapistParseTID] ?? ""

            }
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseName' is [\(sPFTherapistParseName)]...")
  
        return sPFTherapistParseName

    } // End of public func convertTidToTherapistName(sPFTherapistParseTID:String)->String.
    
    public func convertTherapistNameToTid(sPFTherapistParseName:String = "")->String
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseName' is [\(sPFTherapistParseName)]...")

        // Lookup and convert the 'sPFTherapistParseName' to 'sPFTherapistParseTID'...

        var sPFTherapistParseTID:String = ""

        if (sPFTherapistParseName.count > 0)
        {

            let sPFTherapistParseNameLower:String = sPFTherapistParseName.lowercased()
        
            if (self.dictTherapistTidXref[sPFTherapistParseNameLower] != nil)
            {

                sPFTherapistParseTID = self.dictTherapistTidXref[sPFTherapistParseNameLower] ?? ""

            }
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")
  
        return sPFTherapistParseTID

    } // End of public func convertTherapistNameToTid(sPFTherapistParseName:String)->String.
    
}   // End of public class JmAppParseCoreManager.


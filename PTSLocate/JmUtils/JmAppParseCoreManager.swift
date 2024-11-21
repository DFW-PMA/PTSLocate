//
//  JmAppParseCoreManager.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 11/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import ParseCore

// Implementation class to handle access to the ParseCore framework.

public class JmAppParseCoreManager: NSObject, ObservableObject
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppParseCoreManager"
        static let sClsVers      = "v1.0710"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // App Data field(s):

    let timerPublisher                                                  = Timer.publish(every: (3 * 60), on: .main, in: .common).autoconnect()
                                                                          // Note: implement .onReceive() on a field within the displaying 'View'...
                                                                          // 
                                                                          // @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager
                                                                          // ...
                                                                          // .onReceive(jmAppParseCoreManager.timerPublisher,
                                                                          //     perform:
                                                                          //     { dtObserved in
                                                                          //         ...
                                                                          //     })

       public  var parseConfig:ParseClientConfiguration?                = nil       
       public  var pfInstallationCurrent:PFInstallation?                = nil
       public  var bPFInstallationHasBeenEnumerated:Bool                = false

    @Published var cPFCscObjectsRefresh:Int                             = 0
    @Published var cPFCscObjects:Int                                    = 0
    @Published var listPFCscDataItems:[ParsePFCscDataItem]              = []

    @Published var dictPFAdminsDataItems:[String:ParsePFAdminsDataItem] = [:]

               var jmAppDelegateVisitor:JmAppDelegateVisitor?           = nil
                                                                        // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                        // as having it reference the 'shared' instance of 
                                                                        // JmAppDelegateVisitor causes a circular reference
                                                                        // between the 'init()' methods of the 2 classes...

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

               var listPreXCGLoggerMessages:[String]                    = Array()

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
        asToString.append("'dictPFAdminsDataItems': [\(String(describing: self.dictPFAdminsDataItems))]")
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

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.pfInstallationCurrent' is [\(String(describing: self.pfInstallationCurrent))] - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return self.pfInstallationCurrent

    } // End of public func getJmAppParsePFInstallationCurrentInstance()->PFInstallation?.

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
            
            pfQueryTherapist.limit = 1000
            
            let listPFTherapistObjects:[PFObject]? = try pfQueryTherapist.findObjects()
            
            if (listPFTherapistObjects != nil &&
                listPFTherapistObjects!.count > 0)
            {
                
                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryTherapist' returned a count of #(\(listPFTherapistObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryTherapist'...")

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
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryAdmins' - Details: \(error) - Error!")
            
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

                for pfCscObject in listPFCscObjects!
                {

                    self.cPFCscObjects += 1

                    let parsePFCscDataItem:ParsePFCscDataItem = ParsePFCscDataItem()

                    parsePFCscDataItem.constructParsePFCscDataItemFromPFObject(idPFCscObject:cPFCscObjects, pfCscObject:pfCscObject)

                    self.listPFCscDataItems.append(parsePFCscDataItem)

                    self.xcgLogMsg("\(sCurrMethodDisp) Added object #(\(self.cPFCscObjects)) 'parsePFCscDataItem' to the list of item(s)...")

                }
                
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

}   // End of public class JmAppParseCoreManager.


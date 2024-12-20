//
//  JmAppSwiftDataManager.swift
//  PTSLocate
//
//  Created by Daryl Cox on 12/11/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

public class JmAppSwiftDataManager: NSObject, ObservableObject
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "JmAppSwiftDataManager"
        static let sClsVers      = "v1.0301"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Class 'singleton' instance:

    struct ClassSingleton
    {

        static var appSwiftDataManager:JmAppSwiftDataManager           = JmAppSwiftDataManager()

    }

    // Various App field(s):

           private var bInternalTest:Bool                              = true

           private var cJmAppSwiftDataManagerMethodCalls:Int           = 0

    // Various App SwiftData field(s):

           public   var schema:Schema?                                 = nil
           public   var modelConfiguration:ModelConfiguration?         = nil
           public   var modelContainer:ModelContainer?                 = nil
           public   var modelContext:ModelContext?                     = nil

    @Published      var pfAdminsSwiftDataItems:[PFAdminsSwiftDataItem] = []
    @Published      var bArePFAdminsSwiftDataItemsAvailable:Bool       = false
    
    // App 'delegate' Visitor:

                    var jmAppDelegateVisitor:JmAppDelegateVisitor?     = nil
                                                                         // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                         // as having it reference the 'shared' instance of 
                                                                         // JmAppDelegateVisitor causes a circular reference
                                                                         // between the 'init()' methods of the 2 classes...

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

                    var listPreXCGLoggerMessages:[String]              = Array()

    private override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "(.swift):'"+sCurrMethod+"'"
        
        super.init()
      
        self.cJmAppSwiftDataManagerMethodCalls += 1
      
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' Invoked...")
      
        // Exit:
      
        self.xcgLogMsg("\(ClassInfo.sClsDisp)\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' Exiting...")

        return

    }   // End of init().
    
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

    @objc public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("bInternalTest': [\(self.bInternalTest)],")
        asToString.append("cJmAppSwiftDataManagerMethodCalls': [\(self.cJmAppSwiftDataManagerMethodCalls)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("SwiftData 'schema': (\(String(describing: self.schema))),")
        asToString.append("SwiftData 'modelConfiguration': (\(String(describing: self.modelConfiguration))),")
        asToString.append("SwiftData 'modelContainer': (\(String(describing: self.modelContainer))),")
        asToString.append("SwiftData 'modelContext': (\(String(describing: self.modelContext))),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("SwiftData 'pfAdminsSwiftDataItems': (\(String(describing: self.pfAdminsSwiftDataItems))),")
        asToString.append("SwiftData 'bArePFAdminsSwiftDataItemsAvailable': (\(String(describing: self.bArePFAdminsSwiftDataItemsAvailable))),")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of @objc public func toString().

    public func setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:JmAppDelegateVisitor)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.cJmAppSwiftDataManagerMethodCalls += 1
    
        self.xcgLogMsg("\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' Invoked - supplied parameter 'jmAppDelegateVisitor' is [\(jmAppDelegateVisitor)]...")

        // Set the AppDelegateVisitor instance...

        self.jmAppDelegateVisitor = jmAppDelegateVisitor

        // Spool <any> pre-XDGLogger (via the AppDelegateVisitor) message(s) into the Log...

        if (self.listPreXCGLoggerMessages.count > 0)
        {

            self.xcgLogMsg("")
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) === >>>")
            self.xcgLogMsg("")

        }

        // Finish any 'initialization' work:

        self.xcgLogMsg("\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' SwiftDataManager Invoking 'self.runPostInitializationTasks()'...")
    
        self.runPostInitializationTasks()

        self.xcgLogMsg("\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' SwiftDataManager Invoked  'self.runPostInitializationTasks()'...")
    
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp)#(\(self.cJmAppSwiftDataManagerMethodCalls))' Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    private func runPostInitializationTasks()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Initialize the SwiftData 'model' Container (on the 'model' Configuration)...
        
        do
        {

        // --------------------------------------------------------------------------------------------------
        //  let schema             = Schema([PFAdminsSwiftDataItem.self])
        //  let modelConfiguration = ModelConfiguration(schema:schema, isStoredInMemoryOnly:false)
        //                return try ModelContainer(for:schema, configurations:[modelConfiguration])
        // --------------------------------------------------------------------------------------------------

            self.schema = Schema([PFAdminsSwiftDataItem.self])

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Schema has been constructed for PFAdminsSwiftDataItem (class)...")

            self.modelConfiguration = ModelConfiguration(schema:self.schema!, isStoredInMemoryOnly:false, allowsSave:true)
        //  self.modelConfiguration = ModelConfiguration(schema:self.schema!, isStoredInMemoryOnly:false)

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager ModelConfiguration has been constructed on the Schema...")
            
        //  self.modelContainer = try ModelContainer(configurations:modelConfiguration!)
            self.modelContainer = try ModelContainer(for:self.schema!, configurations:modelConfiguration!)
            
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager ModelContainer has been constructed on the Schema/ModelConfiguration...")

        //  self.modelContext   = self.modelContainer!.mainContext
            self.modelContext   = ModelContext(self.modelContainer!)

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager ModelContext has been obtained (from the ModelContainer)...")

            if (self.modelContext != nil) 
            {

                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.fetchAppSwiftData()'...")

                self.fetchAppSwiftData(bShowDetailAfterFetch:true)

                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.fetchAppSwiftData()'...")
            //  self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.createAppSwiftDataDefaultsIfNone()'...")
            //
            //  self.createAppSwiftDataDefaultsIfNone()
            //
            //  self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.createAppSwiftDataDefaultsIfNone()'...")
          
            }

        }
        catch
        {
            
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager ModelContainer has failed construction - Details: \(error) - Error!")

            self.bArePFAdminsSwiftDataItemsAvailable = false
            self.modelContext                     = nil
            self.modelContainer                   = nil

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManagerManager 'self.pfAdminsSwiftDataItems' has #(\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManagerManager 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func runPostInitializationTasks().

    // Method(s) to fetch, add, delete, detail, and save SwiftData item(s):

    public func addAppSwiftDataItem(pfAdminsSwiftDataItem:PFAdminsSwiftDataItem, bShowDetailAfterAdd:Bool = false)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'pfAdminsSwiftDataItem' is [\(pfAdminsSwiftDataItem)] - 'bShowDetailAfterAdd' is [\(bShowDetailAfterAdd)]...")
  
        // Add the supplied SwiftData item to the ModelContext...
  
        if (self.modelContext != nil) 
        {

            self.modelContext!.insert(pfAdminsSwiftDataItem)
      
            self.xcgLogMsg("\(sCurrMethodDisp) Added a supplied 'pfAdminsSwiftDataItem' of [\(String(describing: pfAdminsSwiftDataItem.toString()))] to the SwiftData 'model' Context...")
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.saveAppSwiftData()'...")

            self.saveAppSwiftData()

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.saveAppSwiftData()'...")
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.fetchAppSwiftData()'...")

            self.fetchAppSwiftData(bShowDetailAfterFetch:bShowDetailAfterAdd)

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.fetchAppSwiftData()'...")

            if (self.pfAdminsSwiftDataItems.count > 0)
            {

                self.bArePFAdminsSwiftDataItemsAvailable = true

            }
            else
            {

                self.bArePFAdminsSwiftDataItemsAvailable = false

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Add) 'self.pfAdminsSwiftDataItems' has (\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Add) 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")

        }
        
        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfAdminsSwiftDataItem' is [\(pfAdminsSwiftDataItem)] - 'bShowDetailAfterAdd' is [\(bShowDetailAfterAdd)]...")
  
        return
  
    }   // End of public func addAppSwiftDataItem(pfAdminsSwiftDataItem:PFAdminsSwiftDataItem, bShowDetailAfterAdd:Bool).

    public func fetchAppSwiftData(bShowDetailAfterFetch:Bool = false)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'bShowDetailAfterFetch' is [\(bShowDetailAfterFetch)]...")

        // Fetch (or re-fetch) the SwiftData 'model' Container's ModelContext...
        
        do
        {

            if (self.modelContext != nil) 
            {

            //  let pfAdminsSwiftDataItemsPredicate  = #Predicate<PFAdminsSwiftDataItem>()
            //  let pfAdminsSwiftDataItemsDescriptor = FetchDescriptor<PFAdminsSwiftDataItem>(predicate:PFAdminsSwiftDataItemsPredicate)
                let pfAdminsSwiftDataItemsDescriptor = FetchDescriptor<PFAdminsSwiftDataItem>()
                self.pfAdminsSwiftDataItems          = try self.modelContext!.fetch(pfAdminsSwiftDataItemsDescriptor)

                if (self.pfAdminsSwiftDataItems.count > 0)
                {

                    if (bShowDetailAfterFetch == true)
                    {
                    
                        self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.detailAppSwiftDataToLog()'...")
                        
                        self.detailAppSwiftDataToLog()
                    
                        self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.detailAppSwiftDataToLog()'...")
                        
                    }
                    
                    self.bArePFAdminsSwiftDataItemsAvailable = true

                }
                else
                {

                    self.bArePFAdminsSwiftDataItemsAvailable = false

                }

                self.xcgLogMsg("\(ClassInfo.sClsDisp) #1 SwiftDataManager 'self.pfAdminsSwiftDataItems' has (\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
                self.xcgLogMsg("\(ClassInfo.sClsDisp) #1 SwiftDataManager 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")

            }

        }
        catch
        {
            
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftData ModelContext 'fetch' has failed - Details: \(error) - Error!")

            self.bArePFAdminsSwiftDataItemsAvailable = false
            self.modelContext                     = nil
            self.modelContainer                   = nil

            self.xcgLogMsg("\(ClassInfo.sClsDisp) #2 SwiftDataManager 'self.pfAdminsSwiftDataItems' has #(\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) #2 SwiftDataManager 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bShowDetailAfterFetch' is [\(bShowDetailAfterFetch)]...")

        return

    }   // End of public func fetchAppSwiftData(bShowDetailAfterFetch:Bool).

    public func deleteAppSwiftDataItems(offsets:IndexSet, bShowDetailAfterDeletes:Bool = false)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'offsets' is [\(offsets)] - 'bShowDetailAfterDeletes' is [\(bShowDetailAfterDeletes)]...")
  
        // Delete the supplied SwiftData item(s) from the ModelContext...
  
        if (self.modelContext != nil) 
        {

            for index in offsets
            {
            
                self.deleteAppSwiftDataItem(pfAdminsSwiftDataItem:self.pfAdminsSwiftDataItems[index], bShowDetailAfterDelete:false)
            
            }
            
            self.xcgLogMsg("\(sCurrMethodDisp) 'alarm' SwiftData 'item(s)' has been 'deleted' from the SwiftDataManager ModelContext...")

        //  We bypass the 'save' here as each individual 'delete' does a 'save'...
        //
        //  self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.saveAppSwiftData()'...")
        //
        //  self.saveAppSwiftData()
        //
        //  self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.saveAppSwiftData()'...")

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.fetchAppSwiftData()'...")

            self.fetchAppSwiftData(bShowDetailAfterFetch:bShowDetailAfterDeletes)

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.fetchAppSwiftData()'...")

            if (self.pfAdminsSwiftDataItems.count > 0)
            {

                self.bArePFAdminsSwiftDataItemsAvailable = true

            }
            else
            {

                self.bArePFAdminsSwiftDataItemsAvailable = false

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Deletes) 'self.pfAdminsSwiftDataItems' has (\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Deletes) 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")

        }
        
        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'offsets' is [\(offsets)] - 'bShowDetailAfterDeletes' is [\(bShowDetailAfterDeletes)]...")
  
        return
  
    }   // End of public func deleteAppSwiftDataItems(offsets:IndexSet, bShowDetailAfterDeletes:Bool).

    public func deleteAppSwiftDataItem(pfAdminsSwiftDataItem:PFAdminsSwiftDataItem, bShowDetailAfterDelete:Bool = false)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'pfAdminsSwiftDataItem' is [\(pfAdminsSwiftDataItem)] - 'bShowDetailAfterDelete' is [\(bShowDetailAfterDelete)]...")
  
        // Delete the supplied SwiftData item from the ModelContext...
  
        if (self.modelContext != nil) 
        {

            self.modelContext!.delete(pfAdminsSwiftDataItem)
      
            self.xcgLogMsg("\(sCurrMethodDisp) Deleted a supplied 'pfAdminsSwiftDataItem' of [\(String(describing: pfAdminsSwiftDataItem.toString()))] to the SwiftData 'model' Context...")
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.saveAppSwiftData()'...")

            self.saveAppSwiftData()

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.saveAppSwiftData()'...")
            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.fetchAppSwiftData()'...")

            self.fetchAppSwiftData(bShowDetailAfterFetch:bShowDetailAfterDelete)

            self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.fetchAppSwiftData()'...")

            if (self.pfAdminsSwiftDataItems.count > 0)
            {

                self.bArePFAdminsSwiftDataItemsAvailable = true

            }
            else
            {

                self.bArePFAdminsSwiftDataItemsAvailable = false

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Delete) 'self.pfAdminsSwiftDataItems' has (\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Delete) 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")

        }
        
        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfAdminsSwiftDataItem' is [\(pfAdminsSwiftDataItem)] - 'bShowDetailAfterDelete' is [\(bShowDetailAfterDelete)]...")
  
        return
  
    }   // End of public func deleteAppSwiftDataItem(pfAdminsSwiftDataItem:PFAdminsSwiftDataItem, bShowDetailAfterDelete:Bool).

    public func detailAppSwiftDataToLog()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Detail the SwiftData 'model' Container's ModelContext to the Log...
        
        if (self.modelContext != nil) 
        {

            if (self.pfAdminsSwiftDataItems.count > 0)
            {

                var idPFAdminsSwiftDataItem:Int = 0

                for currentSwiftDataItem:PFAdminsSwiftDataItem in self.pfAdminsSwiftDataItems
                {

                    idPFAdminsSwiftDataItem += 1

                    if (idPFAdminsSwiftDataItem == 1) 
                    {

                        currentSwiftDataItem.displayPFAdminsSwiftDataItemWithLocalStore(bShowLocalStore:true)

                    }
                    else
                    {

                        currentSwiftDataItem.displayPFAdminsSwiftDataItemWithLocalStore(bShowLocalStore:false)

                    }

                }

                self.bArePFAdminsSwiftDataItemsAvailable = true

            }
            else
            {

                self.bArePFAdminsSwiftDataItemsAvailable = false

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Details) 'self.pfAdminsSwiftDataItems' has (\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager (Details) 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func detailAppSwiftDataToLog().

    private func createAppSwiftDataDefaultsIfNone()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // NOTE: If necessary, the block below generates a 'default' SwiftData item (if there are NONE)...
        
        if (self.modelContext != nil) 
        {

        //  for i in 0..<3
            if (self.pfAdminsSwiftDataItems.count < 1)
            {
      
                let newPFAdminsSwiftDataItem = PFAdminsSwiftDataItem(idPFAdminsObject:0, timestamp:Date.now, sCreatedBy: "\(sCurrMethodDisp)")
      
                self.modelContext!.insert(newPFAdminsSwiftDataItem)
      
                self.xcgLogMsg("\(sCurrMethodDisp) There were NO SwiftData 'item(s)' - Added a default 'newPFAdminsSwiftDataItem' of [\(String(describing: newPFAdminsSwiftDataItem.toString()))] to the SwiftData 'model' Context...")
                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.saveAppSwiftData()'...")

                self.saveAppSwiftData()

                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.saveAppSwiftData()'...")
                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoking 'self.detailAppSwiftDataToLog()'...")

                self.detailAppSwiftDataToLog()

                self.xcgLogMsg("\(sCurrMethodDisp) SwiftDataManager Invoked  'self.detailAppSwiftDataToLog()'...")

            }
      
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func createAppSwiftDataDefaultsIfNone().

    public func saveAppSwiftData()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Save the SwiftData item(s) (if there are any)...
        
        if (self.modelContext != nil) 
        {

            if (self.pfAdminsSwiftDataItems.count > 0)
            {
      
                do
                {

                    try self.modelContext!.save()

                    self.xcgLogMsg("\(sCurrMethodDisp) SwiftData ModelContext has been saved - 'self.pfAdminsSwiftDataItems' had #(\(self.pfAdminsSwiftDataItems.count)) item(s)...")

                }
                catch
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) SwiftData ModelContext has failed to save - Details: \(error) - Error!")

                }

            }

            if (self.pfAdminsSwiftDataItems.count < 1)
            {
      
                self.bArePFAdminsSwiftDataItemsAvailable = false

            }
            else
            {

                self.bArePFAdminsSwiftDataItemsAvailable = true

            }

            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager 'self.pfAdminsSwiftDataItems' has #(\(self.pfAdminsSwiftDataItems.count)) 'alarm' item(s)...")
            self.xcgLogMsg("\(ClassInfo.sClsDisp) SwiftDataManager 'self.bArePFAdminsSwiftDataItemsAvailable' is [\(self.bArePFAdminsSwiftDataItemsAvailable)]...")
      
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func saveAppSwiftData().

}   // End of class JmAppSwiftDataManager(NSObject).


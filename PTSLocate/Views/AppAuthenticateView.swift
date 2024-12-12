//
//  AppAuthenticateView.swift
//  PTSLocate
//
//  Created by Daryl Cox on 11/21/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

struct AppAuthenticateView: View
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppAuthenticateView"
        static let sClsVers      = "v1.1201"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

//  @Environment(\.modelContext) var modelContext

    enum FocusedFields: Hashable
    {
       case fieldUsername
       case fieldPassword
    }

    @FocusState private var focusedField:FocusedFields?

    @Query              var pfAdminsSwiftDataItems:[PFAdminsSwiftDataItem]

    @State      private var shouldContentViewChange:Bool                = false
    @State      private var isUserAuthenticationAvailable:Bool          = false
    @State      private var sCredentialsCheckReason:String              = ""
    @State      private var isUserLoginFailureShowing:Bool              = false
    @State      private var isUserLoggedIn:Bool                         = false
    @State      private var sLoginUsername:String                       = ""
    @State      private var sLoginPassword:String                       = ""

                        var jmAppDelegateVisitor:JmAppDelegateVisitor   = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject     var jmAppSwiftDataManager:JmAppSwiftDataManager = JmAppSwiftDataManager.ClassSingleton.appSwiftDataManager

    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        // Check if we have SwiftData 'login' item(s)...
        
        if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count > 0)
        {
            
            self.isUserAuthenticationAvailable.toggle()
            
            self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) Toggling 'isUserAuthenticationAvailable' to 'true' - SwiftData has (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) 'login' item(s) - value is \(isUserAuthenticationAvailable)...")

        }

        // Continue App 'initialization'...

        let _ = self.finishAppInitializationInBackground()

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
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #1 Toggle 'jmAppSwiftDataManager.pfAdminsSwiftDataItems.count' is (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count))...")
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #1 Toggle 'jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable' is [\(self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable)]...")
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #1 Toggle 'isUserAuthenticationAvailable' is [\(isUserAuthenticationAvailable)]...")

        // Check if we have 'login' data available from SwiftData...

        if (self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable == false &&
            isUserAuthenticationAvailable                                  == false)
        {

            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #2 Toggle 'jmAppSwiftDataManager.pfAdminsSwiftDataItems.count' is (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count))...")
            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #2 Toggle 'jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable' is [\(self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable)]...")
            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #2 Toggle 'isUserAuthenticationAvailable' is [\(isUserAuthenticationAvailable)]...")

            VStack(alignment:.center)
            {

                Spacer()

            if #available(iOS 17.0, *)
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal)
                        { size, axis in
                            size * 0.15
                        }

            }
            else
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .frame(width:75, height: 75, alignment:.center)

            }

                Spacer()

                HStack
                {

                    Spacer()

                    Text("Gathering Authentication material(s)...")
                        .onReceive(jmAppDelegateVisitor.$appDelegateVisitorSwiftViewsShouldChange,
                            perform:
                            { bChange in
                                if (bChange == true)
                                {
                                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Received a 'view(s)' SHOULD Change - 'self.shouldContentViewChange' is [\(self.shouldContentViewChange)]...")

                                    self.shouldContentViewChange.toggle()

                                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Toggled 'self.shouldContentViewChange' which is now [\(self.shouldContentViewChange)]...")
                                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - 'self.isUserAuthenticationAvailable' is [\(self.isUserAuthenticationAvailable)]...")

                                    if (isUserAuthenticationAvailable                           == false &&
                                        self.jmAppDelegateVisitor.isUserAuthenticationAvailable == true)
                                    {

                                        self.isUserAuthenticationAvailable.toggle()

                                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Toggled 'self.isUserAuthenticationAvailable' value is now [\(self.isUserAuthenticationAvailable)]...")

                                    }

                                    if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count         > 0 &&
                                        self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable == false)
                                    {

                                        self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable.toggle()

                                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Toggled 'self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable' value is now [\(self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable)]...")

                                    }

                                    self.jmAppDelegateVisitor.resetAppDelegateVisitorSignalSwiftViewsShouldChange()
                                }
                            })

                    ProgressView()
                        .padding()

                    Spacer()

                }

                Spacer()

            }

        }
        else
        {

            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #3 Toggle 'jmAppSwiftDataManager.pfAdminsSwiftDataItems.count' is (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count))...")
            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #3 Toggle 'jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable' is [\(self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable)]...")
            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #3 Toggle 'isUserAuthenticationAvailable' is [\(isUserAuthenticationAvailable)]...")

            if (isUserLoggedIn == false)
            {

                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #3 Toggle 'isUserLoggedIn' is \(isUserLoggedIn)...")

                ScrollView
                {

                    VStack(alignment:.center)
                    {

                        Spacer()

                    if #available(iOS 17.0, *)
                    {

                        Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                            .resizable()
                            .scaledToFit()
                            .containerRelativeFrame(.horizontal)
                                { size, axis in
                                    size * 0.10
                                }

                    }
                    else
                    {

                        Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                            .resizable()
                            .scaledToFit()
                            .frame(width:50, height: 50, alignment:.center)

                    }

                        Spacer()

                        Text("")

                        Image(systemName: "person.badge.key")
                            .imageScale(.large)
                            .foregroundStyle(.tint)

                        Spacer()

                        Text("Enter your Login information:")
                            .onAppear
                            {
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).Text #1 - Received an .onAppear()...")

                                if sLoginUsername.isEmpty
                                {
                                    focusedField = .fieldUsername
                                }
                                else
                                {
                                    focusedField = .fieldPassword
                                }
                            }

                        TextField("Username", text: $sLoginUsername)
                            .focused($focusedField, equals: .fieldUsername)
                            .onSubmit
                            {
                                focusedField = .fieldPassword
                            }

                        SecureField("Password", text: $sLoginPassword)
                            .focused($focusedField, equals: .fieldPassword)
                            .onSubmit
                            {
                                let _ = self.isUserPasswordValidForLogin()
                            }
                            .alert("\(self.sCredentialsCheckReason) - try again...", isPresented:$isUserLoginFailureShowing)
                            {
                                Button("Ok", role:.cancel)
                                {
                                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to attempt the 'login' again...")
                                    focusedField = .fieldPassword
                                }
                            }

                        HStack
                        {

                            Spacer()

                            Button("Login")
                            {
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed the 'Login' button...")

                                if sLoginUsername.isEmpty
                                {
                                    focusedField = .fieldUsername
                                }
                                else
                                {
                                    if sLoginPassword.isEmpty
                                    {
                                        focusedField = .fieldPassword
                                    }
                                    else
                                    {
                                        let _ = self.isUserPasswordValidForLogin()
                                    }
                                }
                            }
                            .buttonStyle(.borderedProminent)

                            Spacer()

                        }

                    }
                    .padding()

                }

            }
            else
            {

                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #4 Toggle 'jmAppSwiftDataManager.pfAdminsSwiftDataItems.count' is (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count))...")
                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #4 Toggle 'jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable' is [\(self.jmAppSwiftDataManager.bArePFAdminsSwiftDataItemsAvailable)]...")
                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #4 Toggle 'isUserAuthenticationAvailable' is [\(isUserAuthenticationAvailable)]...")
                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) #4 Toggle 'isUserLoggedIn' is [\(isUserLoggedIn)]...")

                ContentView(isUserLoggedIn:$isUserLoggedIn, sLoginUsername:$sLoginUsername, sLoginPassword:$sLoginPassword)

            }

        }
        
    }
    
    private func finishAppInitializationInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        let dispatchGroup = DispatchGroup()

        do
        {

            dispatchGroup.enter()

            let dispatchQueue = DispatchQueue(label: "FinishAppInitializationInBackground", qos: .userInitiated)

            dispatchQueue.async
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Invoking background 'initialization' method(s)...");

                let isPFAdminsAvailable:Bool = self.checkIfAppParseCoreHasPFAdminsDataItems()

                if (isPFAdminsAvailable == true)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Toggling the 'isUserAuthenticationAvailable' flag...");

                    dispatchGroup.notify(queue: DispatchQueue.main, execute:
                    {
                    
                        self.isUserAuthenticationAvailable.toggle()

                        self.xcgLogMsg("\(sCurrMethodDisp) Toggled  the 'isUserAuthenticationAvailable' flag - value is now [\(self.isUserAuthenticationAvailable)]...");

                        self.jmAppDelegateVisitor.isUserAuthenticationAvailable = true

                        self.xcgLogMsg("\(sCurrMethodDisp) Set the 'self.jmAppDelegateVisitor.isUserAuthenticationAvailable' flag 'true' - value is now [\(self.jmAppDelegateVisitor.isUserAuthenticationAvailable)]...");

                        self.jmAppDelegateVisitor.setAppDelegateVisitorSignalSwiftViewsShouldChange()

                        self.xcgLogMsg("\(sCurrMethodDisp) Toggled  the 'self.jmAppDelegateVisitor.setAppDelegateVisitorSignalSwiftViewsShouldChange()' method - value is now [\(self.jmAppDelegateVisitor.appDelegateVisitorSwiftViewsShouldChange)]...");

                    })

                }

                let _ = self.checkIfAppParseCoreHasPFCscDataItems()
                let _ = self.checkIfAppParseCoreHasPFInstallationCurrent()

                self.xcgLogMsg("\(sCurrMethodDisp) Invoked  background 'initialization' method(s)...");

            }

            dispatchGroup.leave()

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of private func finishAppInitializationInBackground().
    
    private func checkIfAppParseCoreHasPFAdminsDataItems() -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForAdmins()' to get a 'authentication' dictionary...")

            let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.getJmAppParsePFQueryForAdmins()

            self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForAdmins()' to get a 'authentication' dictionary...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForAdmins()' to get a 'authentication' dictionary - 'jmAppParseCoreManager' is nil - Error!")

        }

        var bWasAppPFAdminsDataPresent:Bool = false

        if (jmAppDelegateVisitor.jmAppParseCoreManager == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' has a 'jmAppParseCoreManager' that is nil - 'bWasAppPFAdminsDataPresent' is [\(String(describing: bWasAppPFAdminsDataPresent))]...")

            bWasAppPFAdminsDataPresent = false

        }
        else
        {

            if ((jmAppDelegateVisitor.jmAppParseCoreManager?.dictPFAdminsDataItems.count)! < 1)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'dictPFAdminsDataItems' that is 'empty'...")

                bWasAppPFAdminsDataPresent = false

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'dictPFAdminsDataItems' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.dictPFAdminsDataItems))]...")

                bWasAppPFAdminsDataPresent = true

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFAdminsDataPresent' is [\(String(describing: bWasAppPFAdminsDataPresent))]...")
  
        return bWasAppPFAdminsDataPresent
  
    }   // End of private func checkIfAppParseCoreHasPFAdminsDataItems().

    private func checkIfAppParseCoreHasPFCscDataItems() -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

            let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.getJmAppParsePFQueryForCSC()

            self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list - 'jmAppParseCoreManager' is nil - Error!")

        }

        var bWasAppPFCscDataPresent:Bool = false

        if (jmAppDelegateVisitor.jmAppParseCoreManager == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' has a 'jmAppParseCoreManager' that is nil - 'bWasAppPFCscDataPresent' is [\(String(describing: bWasAppPFCscDataPresent))]...")

            bWasAppPFCscDataPresent = false

        }
        else
        {

            if ((jmAppDelegateVisitor.jmAppParseCoreManager?.listPFCscDataItems.count)! < 1)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is 'empty'...")

                bWasAppPFCscDataPresent = false

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.listPFCscDataItems))]...")

                bWasAppPFCscDataPresent = true

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFCscDataPresent' is [\(String(describing: bWasAppPFCscDataPresent))]...")
  
        return bWasAppPFCscDataPresent
  
    }   // End of private func checkIfAppParseCoreHasPFCscDataItems().

    private func checkIfAppParseCoreHasPFInstallationCurrent() -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        if (jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent'...")

            let _ = jmAppDelegateVisitor.jmAppParseCoreManager?.getJmAppParsePFInstallationCurrentInstance()

            self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent'...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Could NOT call the 'jmAppParseCoreManager' method 'getJmAppParsePFInstallationCurrentInstance()' to get a 'pfInstallationCurrent' - 'jmAppParseCoreManager' is nil - Error!")

        }

        var bWasAppPFInstallationCurrentPresent:Bool = false

        if (jmAppDelegateVisitor.jmAppParseCoreManager == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' has a 'jmAppParseCoreManager' that is nil - 'bWasAppPFInstallationCurrentPresent' is [\(String(describing: bWasAppPFInstallationCurrentPresent))]...")

            bWasAppPFInstallationCurrentPresent = false

        }
        else
        {

            if (jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent == nil)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is nil...")

                if (jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent == nil)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is STILL nil...")

                    bWasAppPFInstallationCurrentPresent = false

                }
                else
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent))]...")

                    bWasAppPFInstallationCurrentPresent = true

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'pfInstallationCurrent' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.pfInstallationCurrent))]...")

                bWasAppPFInstallationCurrentPresent = true

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFInstallationCurrentPresent' is [\(String(describing: bWasAppPFInstallationCurrentPresent))]...")
  
        return bWasAppPFInstallationCurrentPresent
  
    }   // End of private func checkIfAppParseCoreHasPFInstallationCurrent().

    private func getAppParseCoreManagerInstance()->JmAppParseCoreManager
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        let jmAppParseCoreManager:JmAppParseCoreManager = jmAppDelegateVisitor.jmAppParseCoreManager ?? JmAppParseCoreManager()
  
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor.jmAppParseCoreManager?' is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager))]...")
  
        return jmAppParseCoreManager
  
    }   // End of private func getAppParseCoreManagerInstance()->jmAppParseCoreManager.

    private func locateUserDataInPFAdmins()->ParsePFAdminsDataItem?
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'sLoginUsername' is [\(self.sLoginUsername)] - 'sLoginPassword' is [\(self.sLoginPassword)]...")

        // Attempt to locate the User data in 'dictPFAdminsDataItems'...

        var pfAdminsDataItem:ParsePFAdminsDataItem? = nil
        var sLookupUserName:String                  = ""

        if (self.sLoginUsername.count > 0)
        {

            sLookupUserName = self.sLoginUsername.lowercased()

        }
        else
        {

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.sLoginUsername' is nil or Empty - can NOT be 'validated' - Error!")

            pfAdminsDataItem = nil   

            return pfAdminsDataItem

        }

        let jmAppParseCoreManager:JmAppParseCoreManager = self.getAppParseCoreManagerInstance()

        if (jmAppParseCoreManager.dictPFAdminsDataItems.count < 1)
        {

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppParseCoreManager.dictPFAdminsDataItems' is nil or Empty - can NOT be 'validated' - Error!")

            pfAdminsDataItem = nil   

            return pfAdminsDataItem

        }

        for (_, parsePFAdminsDataItem) in jmAppParseCoreManager.dictPFAdminsDataItems
        {

            let sComparePFAdminsParseName:String = parsePFAdminsDataItem.sPFAdminsParseName.lowercased()

            if (sComparePFAdminsParseName.count  > 0 &&
                sComparePFAdminsParseName       == sLookupUserName)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] matches the 'sComparePFAdminsParseName' of [\(sComparePFAdminsParseName)] - setting 'pfAdminsDataItem' to this item...")

                pfAdminsDataItem = parsePFAdminsDataItem   

                break

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] does NOT match the 'sComparePFAdminsParseName' of [\(sComparePFAdminsParseName)] - continuing search...")

            }

        }

        if (pfAdminsDataItem == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] can NOT be found in the valid (\(jmAppParseCoreManager.dictPFAdminsDataItems.count)) login(s) dictionary - User can NOT be 'validated' - Warning!")

            pfAdminsDataItem = nil   

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfAdminsDataItem' is [\(String(describing: pfAdminsDataItem))]...")
  
        return pfAdminsDataItem
  
    }   // End of private func locateUserDataInPFAdmins()->ParsePFAdminsDataItem?.

    private func locateUserDataInSwiftData()->PFAdminsSwiftDataItem?
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'sLoginUsername' is [\(self.sLoginUsername)] - 'sLoginPassword' is [\(self.sLoginPassword)]...")

        // Attempt to locate the User data in SwiftData...

        var pfAdminsSwiftDataItem:PFAdminsSwiftDataItem? = nil
        var sLookupUserName:String                       = ""

        if (self.sLoginUsername.count > 0)
        {

            sLookupUserName = self.sLoginUsername.lowercased()

        }
        else
        {

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.sLoginUsername' is nil or Empty - can NOT be 'validated' - Error!")

            pfAdminsSwiftDataItem = nil   

            return pfAdminsSwiftDataItem

        }

        for listSwiftDataItem in self.jmAppSwiftDataManager.pfAdminsSwiftDataItems
        {

            let sComparePFAdminsParseName:String = listSwiftDataItem.sPFAdminsParseName.lowercased()

            if (sComparePFAdminsParseName.count  > 0 &&
                sComparePFAdminsParseName       == sLookupUserName)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] matches the 'sComparePFAdminsParseName' of [\(sComparePFAdminsParseName)] - setting 'pfAdminsSwiftDataItem' to this item...")

                pfAdminsSwiftDataItem = listSwiftDataItem   

                break

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] does NOT match the 'sComparePFAdminsParseName' of [\(sComparePFAdminsParseName)] - continuing search...")

            }

        }

        if (pfAdminsSwiftDataItem == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] can NOT be found in the valid SwiftData (\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) login(s) list - User can NOT be 'validated' - Warning!")

            pfAdminsSwiftDataItem = nil   

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfAdminsSwiftDataItem' is [\(String(describing: pfAdminsSwiftDataItem))]...")
  
        return pfAdminsSwiftDataItem
  
    }   // End of private func locateUserDataInSwiftData()->PFAdminsSwiftDataItem?.

    private func isUserPasswordValidForLogin()->Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'sLoginUsername' is [\(self.sLoginUsername)] - 'sLoginPassword' is [\(self.sLoginPassword)]...")

        // Validate the 'login' credential(s)...

        self.sCredentialsCheckReason = ""

        var bUserLoginValidated:Bool = false
        var sValidUserName:String    = ""

        if (self.sLoginUsername.count > 0)
        {

            sValidUserName  = self.sLoginUsername

        }

        // Check SwiftData (1st) for a match on the User...

        let pfAdminsSwiftDataItem:PFAdminsSwiftDataItem? = self.locateUserDataInSwiftData()

        if (pfAdminsSwiftDataItem == nil)
        {

            self.sCredentialsCheckReason = "The Username '\(sValidUserName)' is 'invalid'"

            bUserLoginValidated          = false

        }
        else
        {

            if let sValidUserPassword:String = pfAdminsSwiftDataItem?.sPFAdminsParsePassword
            {

                if (sValidUserPassword.count  > 0 &&
                    sValidUserPassword       == self.sLoginPassword)
                {

                    self.sCredentialsCheckReason = "User credential(s) are 'valid'"

                    bUserLoginValidated          = true

                }
                else
                {

                    self.sCredentialsCheckReason = "For the Username '\(sValidUserName)', the password is 'invalid'"

                    bUserLoginValidated          = false

                }

            }
            else
            {

                self.sCredentialsCheckReason = "The Username '\(sValidUserName)' is 'invalid'"

                bUserLoginValidated          = false

            }

        }
        
        // Handle the SwiftData valid credentials(s) action/response...

        if (bUserLoginValidated == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied credential(s) have been successfully 'validated'- credential(s) are good - reason [\(sCredentialsCheckReason)]...")

            self.isUserLoggedIn.toggle()

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bUserLoginValidated' is [\(String(describing: bUserLoginValidated))]...")

            return bUserLoginValidated

        }

        // SwiftData didn't have a match on the User - try PFAdmins...

        let pfAdminsDataItem:ParsePFAdminsDataItem? = self.locateUserDataInPFAdmins()

        if (pfAdminsDataItem == nil)
        {

            self.sCredentialsCheckReason = "The Username '\(sValidUserName)' is 'invalid'"

            bUserLoginValidated          = false

        }
        else
        {

            if let sValidUserPassword:String = pfAdminsDataItem?.sPFAdminsParsePassword
            {

                if (sValidUserPassword.count  > 0 &&
                    sValidUserPassword       == self.sLoginPassword)
                {

                    self.sCredentialsCheckReason = "User credential(s) are 'valid'"

                    bUserLoginValidated          = true

                }
                else
                {

                    self.sCredentialsCheckReason = "For the Username '\(sValidUserName)', the password is 'invalid'"

                    bUserLoginValidated          = false

                }

            }
            else
            {

                self.sCredentialsCheckReason = "The Username '\(sValidUserName)' is 'invalid'"

                bUserLoginValidated          = false

            }

        }
        
        // Handle the valid/invalid credentials(s) action/response...

        if (bUserLoginValidated == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied credential(s) have been successfully 'validated'- credential(s) are good - reason [\(sCredentialsCheckReason)]...")

            self.isUserLoggedIn.toggle()

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Supplied credential(s) have NOT been successfully 'validated' - credential(s) failure - reason [\(sCredentialsCheckReason)] - Error!")

            self.dumpUserAuthenticationDataToLog()

            self.sLoginPassword = ""

            self.isUserLoginFailureShowing.toggle()

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bUserLoginValidated' is [\(String(describing: bUserLoginValidated))]...")
  
        return bUserLoginValidated
  
    }   // End of private func isUserPasswordValidForLogin()->Bool.

    private func dumpUserAuthenticationDataToLog()
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Dump the User data in SwiftData to the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

        self.jmAppSwiftDataManager.detailAppSwiftDataToLog()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

    //  if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count > 0)
    //  {
    //
    //      var cPFAdminsSwiftDataItems:Int = 0
    //
    //      for currentSwiftDataItem:PFAdminsSwiftDataItem in self.pfAdminsSwiftDataItems
    //      {
    //
    //          cPFAdminsSwiftDataItems += 1
    //
    //          if (cPFAdminsSwiftDataItems == 1) 
    //          {
    //
    //              currentSwiftDataItem.displayPFAdminsSwiftDataItemWithLocalStore(bShowLocalStore:true)
    //
    //          }
    //          else
    //          {
    //
    //              currentSwiftDataItem.displayPFAdminsSwiftDataItemWithLocalStore(bShowLocalStore:false)
    //
    //          }
    //
    //      }
    //
    //  }
    //  else
    //  {
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) Unable to dump the SwiftData item(s) - the list is 'empty' - Warning!")
    //
    //  }

        // Dump the User data in PFAdminsDataItems to the Log...

        let jmAppParseCoreManager:JmAppParseCoreManager = self.getAppParseCoreManagerInstance()

        if (jmAppParseCoreManager.dictPFAdminsDataItems.count > 0)
        {

            for (_, parsePFAdminsDataItem) in jmAppParseCoreManager.dictPFAdminsDataItems
            {

                parsePFAdminsDataItem.displayParsePFAdminsDataItemToLog()

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to dump the PFAdminsData item(s) - the list is 'empty' - Warning!")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of private func dumpUserAuthenticationDataToLog().

}   // END of struct AppAuthenticateView(View).

#Preview
{
    
    AppAuthenticateView()
    
}

// --------------------------------------------------------------------------------------------------
//
// NOTES: Sample...   
//
//     let today         = Date()
//     let tripPredicate = #Predicate<Trip> 
//                             { 
//                               $0.destination == "New York" &&
//                               $0.name.contains("birthday") &&
//                               $0.startDate > today
//                             }
//
//     let descriptor    = FetchDescriptor<Trip>(predicate:tripPredicate)
//     let trips         = try context.fetch(descriptor)
//
//     --- OR ---
//
//     let descriptor        = FetchDescriptor<Student>()
//     var totalResults      = 0
//     var totalDistinctions = 0
//     var totalPasses       = 0
//
//     do 
//     {
//
//         try modelContext.enumerate(descriptor) 
//             { student in
//                 totalResults      += student.scores.count
//                 totalDistinctions += student.scores.filter { $0 >= 85 }.count
//                 totalPasses       += student.scores.filter { $0 >= 70 && $0 < 85 }.count
//             }
//     } 
//     catch 
//     {
//         print("Unable to calculate student results.")
//     }
//
//     print("Total test results: \(totalResults)")
//     print("Distinctions: \(totalDistinctions)")
//     print("Passes: \(totalPasses)")
//
// --------------------------------------------------------------------------------------------------


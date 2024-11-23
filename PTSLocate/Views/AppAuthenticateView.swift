//
//  AppAuthenticateView.swift
//  JustALoginAppTest1
//
//  Created by Daryl Cox on 11/21/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

struct AppAuthenticateView: View
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppAuthenticateView"
        static let sClsVers      = "v1.0503"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    enum FocusedFields: Hashable
    {
       case fieldUsername
       case fieldPassword
    }

    @FocusState private var focusedField:FocusedFields?

    @State      private var shouldContentViewChange:Bool              = false
    @State      private var isUserAuthenicationAvailable:Bool         = false
    @State      private var sCredentialsCheckReason:String            = ""
    @State      private var isUserLoginFailureShowing:Bool            = false
    @State      private var isUserLoggedIn:Bool                       = false
    @State      private var sLoginUsername:String                     = ""
    @State      private var sLoginPassword:String                     = ""

                        var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Continue App 'initialization'...

    //  let _ = checkIfAppParseCoreHasPFInstallationCurrent()
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
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) \(ClassInfo.sClsId)...")

        if (isUserAuthenicationAvailable == false)
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
                                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Received a 'view(s)' SHOULD Change...")

                                //  self.shouldContentViewChange = true
                                    self.shouldContentViewChange.toggle()
                                    self.isUserAuthenicationAvailable.toggle()

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

            if (isUserLoggedIn == false)
            {

                Spacer()

                NavigationStack
                {

                    Spacer()

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

                        Text("")

                        Image(systemName: "person.badge.key")
                            .imageScale(.large)
                            .foregroundStyle(.tint)

                        Spacer()

                        Form
                        {

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
                    .padding()

                }
                .padding()

            }
            else
            {

                ContentView(isUserLoggedIn:$isUserLoggedIn, sLoginUsername: $sLoginUsername, sLoginPassword: $sLoginPassword)

            //  VStack
            //  {
            //      
            //      Spacer()
            //      
            //      Image(systemName: "person.badge.key")
            //          .imageScale(.large)
            //          .foregroundStyle(.tint)
            //      
            //      Text("")
            //      
            //      Divider()
            //      
            //      Text(" - - - - - ")
            //      Text("\(ClassInfo.sClsDisp)")
            //      Text(" - - - - - ")
            //      Text("You are 'logged' in:")
            //      Text("UserName -> '\(sLoginUsername)'")
            //      Text("Password -> [\(sLoginPassword)]")
            //      Text(" - - - - - ")
            //      
            //      Divider()
            //      
            //      HStack
            //      {
            //
            //          Spacer()
            //
            //          Button("Logout")
            //          {
            //
            //              self.sLoginPassword = ""
            //              
            //              isUserLoggedIn.toggle()
            //
            //          }
            //          .buttonStyle(.borderedProminent)
            //
            //          Spacer()
            //
            //      }
            //
            //      Spacer()
            //
            //  }
            //  .padding()

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

                    self.xcgLogMsg("\(sCurrMethodDisp) Toggling the 'isUserAuthenicationAvailable' flag...");

                    dispatchGroup.notify(queue: DispatchQueue.main, execute:
                    {
                    
                        self.isUserAuthenicationAvailable.toggle()

                        self.xcgLogMsg("\(sCurrMethodDisp) Toggled  the 'isUserAuthenicationAvailable' flag - value is now [\(self.isUserAuthenicationAvailable)]...");

                        self.jmAppDelegateVisitor.setAppDelegateVisitorSignalSwiftViewsShouldChange()

                        self.xcgLogMsg("\(sCurrMethodDisp) Toggled  the 'jmAppDelegateVisitor.setAppDelegateVisitorSignalSwiftViewsShouldChange()' method - value is now [\(self.jmAppDelegateVisitor.appDelegateVisitorSwiftViewsShouldChange)]...");

                    //  self.objectWillChange.send()    // NOT available in a View...

                    //  NOTE: Directly setting the variable outside of 'init()' fails in the compiler...
                    //
                    //  self._isUserAuthenicationAvailable = true
                    //
                    //  self.xcgLogMsg("\(sCurrMethodDisp) Hard-set the '_isUserAuthenicationAvailable' flag to 'true' - value is now [\(self.isUserAuthenicationAvailable)]...");
                    
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

        for (_, parsePFAdminsDataItem) in jmAppParseCoreManager.dictPFAdminsDataItems
        {

            let sComparePFAdminsParseName:String = parsePFAdminsDataItem.sPFAdminsParseName.lowercased()

            if (sComparePFAdminsParseName.count  > 0 &&
                sComparePFAdminsParseName       == sLookupUserName)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName'  of [\(sLookupUserName)]matches the 'sComparePFAdminsParseName' of [\(sComparePFAdminsParseName)] - setting 'pfAdminsDataItem' to this item...")

                pfAdminsDataItem = parsePFAdminsDataItem   

                break

            }

        }

        if (pfAdminsDataItem == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'sLookupUserName' of [\(sLookupUserName)] can NOT be found in the valid login(s) dictionary - User can NOT be 'validated' - Warning!")

            pfAdminsDataItem = nil   

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfAdminsDataItem' is [\(String(describing: pfAdminsDataItem))]...")
  
        return pfAdminsDataItem
  
    }   // End of private func locateUserDataInPFAdmins()->ParsePFAdminsDataItem?.

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

            self.sLoginPassword = ""

            self.isUserLoginFailureShowing.toggle()

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bUserLoginValidated' is [\(String(describing: bUserLoginValidated))]...")
  
        return bUserLoginValidated
  
    }   // End of private func isUserPasswordValidForLogin()->Bool.

}   // END of struct AppAuthenticateView(View).

#Preview
{
    
    AppAuthenticateView()
    
}

//
//  JmAppUserNotificationManager.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 11/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import UserNotifications

// Implementation class to handle access to the Apple XXUserNotificationCenter.

public class JmAppUserNotificationManager: NSObject, UNUserNotificationCenterDelegate
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppUserNotificationManager"
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // App Data field(s):

    public  var bAppIsAuthorizedForUserNotifications:Bool  = false

            var jmAppDelegateVisitor:JmAppDelegateVisitor? = nil
                                                             // 'jmAppDelegateVisitor' MUST remain declared this way
                                                             // as having it reference the 'shared' instance of 
                                                             // JmAppDelegateVisitor causes a circular reference
                                                             // between the 'init()' methods of the 2 classes...

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

            var listPreXCGLoggerMessages:[String]          = Array()

    // App 'Alarm' Data field(s) for UserNotification 'testing':

    var bAlarmWasAddedToUNUserNotificationCenter:Bool      = false
    var iAlarmUUID:UUID                                    = UUID()
    var sAlarmUUID:String                                  = ""
    var bAlarmSnoozeEnabled:Bool                           = false
    var bAlarmRepeatsEnabled:Bool                          = true
    var iAlarmRepeatsInterval:Int                          = 1                   // Repeats 'interval' is # of minutes...
    var sAlarmRingtoneName:String                          = "AlarmRingtone"
    var sAlarmContentTitle:String                          = "Alarm"
    var sAlarmContentBody:String                           = "Wake UP!!!"

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
        
        // Finish initializing the App 'Alarm' for UserNotification for 'testing'...
        
        self.sAlarmUUID = self.iAlarmUUID.uuidString

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")

        return

    }   // End of override init().

    // NOTE: Unfortunately, 'deinit' in the class is TOO late for orderly 'termination' of the UserNotification 'center'...

//  deinit
//  {
//      
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
//
//      // Pass the 'deinit' on to the App 'termination' method...
//
//      self.terminateAppUserNotifications()
//
//      // Exit:
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppIsAuthorizedForUserNotifications' is [\(self.bAppIsAuthorizedForUserNotifications)]...")
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
//
//      return
//
//  }   // End of deinit.

    public func terminateAppUserNotifications()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")

        // If the 'test' Alarm was added to the UNUserNotificationCenter, then remove it...

        if (AppGlobalInfo.bIssueTestAppUserNotifications == true)
        {

            if (self.bAlarmWasAddedToUNUserNotificationCenter == true)
            {

                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:[self.sAlarmUUID])

                self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAlarmWasAddedToUNUserNotificationCenter' is [\(self.bAlarmWasAddedToUNUserNotificationCenter)] - UserNotification was added - the Alarm has been 'cancelled'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAlarmWasAddedToUNUserNotificationCenter' is [\(self.bAlarmWasAddedToUNUserNotificationCenter)] - UserNotification was NOT added - the Alarm 'cancel' has been bypassed...")

            }

            self.bAlarmWasAddedToUNUserNotificationCenter = false

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) 'self.bAppIsAuthorizedForUserNotifications' is [\(self.bAppIsAuthorizedForUserNotifications)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")

        return

    }   // End of public func terminateAppUserNotifications().

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
        asToString.append("'bAppIsAuthorizedForUserNotifications': [\(self.bAppIsAuthorizedForUserNotifications)]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bAlarmWasAddedToUNUserNotificationCenter': [\(self.bAlarmWasAddedToUNUserNotificationCenter)]")
        asToString.append("'iAlarmUUID': (\(self.iAlarmUUID))")
        asToString.append("'sAlarmUUID': [\(self.sAlarmUUID)]")
        asToString.append("'bAlarmSnoozeEnabled': [\(self.bAlarmSnoozeEnabled)]")
        asToString.append("'bAlarmRepeatsEnabled': [\(self.bAlarmRepeatsEnabled)]")
        asToString.append("'iAlarmRepeatsInterval': (\(self.iAlarmRepeatsInterval))")
        asToString.append("'sAlarmRingtoneName': [\(self.sAlarmRingtoneName)]")
        asToString.append("'sAlarmContentTitle': [\(self.sAlarmContentTitle)]")
        asToString.append("'sAlarmContentBody': [\(self.sAlarmContentBody)]")
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
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppUserNotificationManager === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppUserNotificationManager === >>>")
            self.xcgLogMsg("")

        }

        // Finish performing any setup with the UNUserNotificationCenter...

        self.xcgLogMsg("\(sCurrMethodDisp) Registering 'self' as the UNUserNotificationCenterDelegate to the UNUserNotificationCenter...")

        UNUserNotificationCenter.current().delegate = self

        self.xcgLogMsg("\(sCurrMethodDisp) Registered  'self' as the UNUserNotificationCenterDelegate to the UNUserNotificationCenter...")

        self.xcgLogMsg("\(sCurrMethodDisp) Requesting authorization for UserNotification(s) via 'self.requestUserNotificationAuthorization()'...")

        self.requestUserNotificationAuthorization()

        self.xcgLogMsg("\(sCurrMethodDisp) Requested  authorization for UserNotification(s) via 'self.requestUserNotificationAuthorization()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Registering the categories for UserNotification(s) via 'self.registerNotificationCategories()'...")

        self.registerUserNotificationCategories()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Registered  the categories for UserNotification(s) via 'self.registerNotificationCategories()'...")

        // Setup a 'default' (testing) UserNotification <maybe>...

        if (AppGlobalInfo.bIssueTestAppUserNotifications == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Creating a 'default' UserNotification(s) <for 'testing'> via 'self.createUserNotificationEvent()'...")

            self.createUserNotificationEvent(createTestNofification:true)

            self.xcgLogMsg("\(sCurrMethodDisp) Created  a 'default' UserNotification(s) <for 'testing'> via 'self.createUserNotificationEvent()'...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    // Method(s) 'required' by the UNUserNotificationCenter for a 'delegate'...

    public func userNotificationCenter(_ center:UNUserNotificationCenter, willPresent notification:UNNotification, withCompletionHandler completionHandler:@escaping (UNNotificationPresentationOptions)->Void)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Asks the Delegate how to handle a Notification that arrived while the App was running in the foreground...

        let userInfo                        = notification.request.content.userInfo
        let sUserNotificationDetails:String = "Notification received for [\(notification)] - 'userInfo' is [\(userInfo)]..."

        self.xcgLogMsg("\(sCurrMethodDisp) \(sUserNotificationDetails)")

        // Signal an 'Alert' for the Notification...

        let sNotificationAlertMsg:String = "Alert::App 'Alarm' received - Details are: [\(userInfo)]..."

        DispatchQueue.main.async
        {

            self.jmAppDelegateVisitor?.setAppDelegateVisitorSignalGlobalAlert(sNotificationAlertMsg,
                                                                              alertButtonText:"Ok")

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Triggered an App Notification 'Alert' - Details are: [\(userInfo)]...")
        
        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
        
        completionHandler(.list)

        return

    }   // END of public func userNotificationCenter(_ center:UNUserNotificationCenter, willPresent notification:UNNotification, withCompletionHandler completionHandler:@escaping (UNNotificationPresentationOptions)->Void).

    public func userNotificationCenter(_ center:UNUserNotificationCenter, didReceive response:UNNotificationResponse, withCompletionHandler completionHandler:@escaping ()->Void)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Asks the Delegate to process the User’s Response to a delivered Notification...

        
        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        completionHandler()

        return

    }   // END of public func userNotificationCenter(_ center:UNUserNotificationCenter, didReceive response:UNNotificationResponse, withCompletionHandler completionHandler:@escaping ()->Void).

    public func userNotificationCenter(_ center:UNUserNotificationCenter, openSettingsFor:UNNotification?)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Asks the Delegate to process the User’s Response to a delivered Notification...

        
        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
        
        return

    }   // END of public func userNotificationCenter(_ center:UNUserNotificationCenter, openSettingsFor:UNNotification?).

    // Method(s) to request Authorization and register Notification categories...

    private func requestUserNotificationAuthorization()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self.bAppIsAuthorizedForUserNotifications' is [\(self.bAppIsAuthorizedForUserNotifications)]...")

        // Request Authorization (from the User) for UserNotification(s)...
        // Note:
        //   The first time your app makes this authorization request, the system prompts
        //   the person to grant or deny the request and records that response. 
        //   Subsequent authorization requests don’t prompt the person.

        self.bAppIsAuthorizedForUserNotifications     = false
        var bWasAppAuthorizationExplicitlyFailed:Bool = false

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        { (authorized, _) in

            if (authorized) 
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Request for UserNotification(s) was 'authorized' by the User...")

                bWasAppAuthorizationExplicitlyFailed = false

            } 
            else 
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Request for UserNotification(s) was NOT 'authorized' by the User - Warning!")

                bWasAppAuthorizationExplicitlyFailed = true

            }

        }

        if (bWasAppAuthorizationExplicitlyFailed == true)
        {

            self.bAppIsAuthorizedForUserNotifications = false

        }
        else
        {

            self.bAppIsAuthorizedForUserNotifications = true

        }
        
        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bAppIsAuthorizedForUserNotifications' is [\(self.bAppIsAuthorizedForUserNotifications)]...")
        
        return

    }   // END of private func requestUserNotificationAuthorization().

    private func registerUserNotificationCategories()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Register the categories of UserNotification(s)...

        let unAlarmActionStop   = UNNotificationAction(identifier:JmAppUserNotificationIdentifiers.sAppNotificationIdentifierActionStop, 
                                                       title:     "Ok", 
                                                       options:   [.foreground])

        let unAlarmActionSnooze = UNNotificationAction(identifier:JmAppUserNotificationIdentifiers.sAppNotificationIdentifierActionSnooze, 
                                                       title:     "Snooze", 
                                                       options:   [.foreground])

        let unAlarmCategoryStop:UNNotificationCategory   = 
                UNNotificationCategory(identifier:                   JmAppUserNotificationIdentifiers.sAppNotificationIdentifierActionStop, 
                                       actions:                      [unAlarmActionStop],
                                       intentIdentifiers:            [],
                                       hiddenPreviewsBodyPlaceholder:"",
                                       options:                      .customDismissAction)

        let unAlarmCategorySnooze:UNNotificationCategory = 
                UNNotificationCategory(identifier:                   JmAppUserNotificationIdentifiers.sAppNotificationIdentifierActionSnooze, 
                                       actions:                      [unAlarmActionSnooze, unAlarmActionStop],
                                       intentIdentifiers:            [],
                                       hiddenPreviewsBodyPlaceholder:"",
                                       options:                      .customDismissAction)

        self.xcgLogMsg("\(sCurrMethodDisp) Registering the categories for UserNotification(s) via 'UNUserNotificationCenter.current().setNotificationCategories([unAlarmCategoryStop, unAlarmCategorySnooze])'...")

        UNUserNotificationCenter.current().setNotificationCategories([unAlarmCategoryStop, unAlarmCategorySnooze])
        
        self.xcgLogMsg("\(sCurrMethodDisp) Registered  the categories for UserNotification(s) via 'UNUserNotificationCenter.current().setNotificationCategories([unAlarmCategoryStop, unAlarmCategorySnooze])'...")

        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
        
        return

    }   // END of private func registerUserNotificationCategories().

    // Method(s) for manipulating UserNotification(s)...

    private func createUserNotificationEvent(createTestNofification:Bool=false)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        if (createTestNofification == true)
        {

            // Create the UserNotification event...

            let unMutableNotificationContent:UNMutableNotificationContent = UNMutableNotificationContent()

            unMutableNotificationContent.title              = self.sAlarmContentTitle
            unMutableNotificationContent.body               = self.sAlarmContentBody
        //  unMutableNotificationContent.sound              = UNNotificationSound(named:"\(self.sAlarmRingtoneName).mp3")
            unMutableNotificationContent.userInfo           = ["idNotification" : self.sAlarmUUID,
                                                               "ringtone"       : self.sAlarmRingtoneName,
                                                               "bSnoozeEnabled" : self.bAlarmSnoozeEnabled]
            unMutableNotificationContent.categoryIdentifier = 
                self.bAlarmSnoozeEnabled ? JmAppUserNotificationIdentifiers.sAppNotificationIdentifierCategorySnooze
                                         : JmAppUserNotificationIdentifiers.sAppNotificationIdentifierCategoryAlarm

            // Create the 'trigger' to set when the UserNotification is sent...

            let unNotificationTrigger:UNTimeIntervalNotificationTrigger = 
            UNTimeIntervalNotificationTrigger(timeInterval:TimeInterval((self.iAlarmRepeatsInterval * 60)),
                                                  repeats: self.bAlarmRepeatsEnabled)

            // Create the UserNotification event 'request'...

            let unNotficationRequest:UNNotificationRequest = 
                UNNotificationRequest(identifier:self.sAlarmUUID,
                                      content:   unMutableNotificationContent,
                                      trigger:   unNotificationTrigger)

            // Add the UserNotification event 'request'...

            self.xcgLogMsg("\(sCurrMethodDisp) Adding the UserNotfication 'request' with an Alarm ID of [\(self.sAlarmUUID)] to the 'UNUserNotificationCenter'...")

            var bWasAppNotificationAddExplicitlyFailed:Bool = false

            UNUserNotificationCenter.current().add(unNotficationRequest) 
            { error in

                if let ex = error 
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Failed to add the UserNotfication 'request' with an Alarm ID of [\(self.sAlarmUUID)] to the 'UNUserNotificationCenter' - error was [\(ex.localizedDescription)] - Error!")

                    bWasAppNotificationAddExplicitlyFailed = true

                }
                else
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Added  the UserNotfication 'request' with an Alarm ID of [\(self.sAlarmUUID)] to the 'UNUserNotificationCenter'...")

                    bWasAppNotificationAddExplicitlyFailed = false

                }

            }

            if (bWasAppNotificationAddExplicitlyFailed == true)
            {

                self.bAlarmWasAddedToUNUserNotificationCenter = false

            }
            else
            {

                self.bAlarmWasAddedToUNUserNotificationCenter = true

            }

        }

        // Exit:
        
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
        
        return

    }   // END of private func createUserNotificationEvent().

}   // End of public class JmAppUserNotificationManager.


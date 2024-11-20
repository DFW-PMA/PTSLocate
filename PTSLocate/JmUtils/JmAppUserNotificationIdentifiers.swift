//
//  JmAppUserNotificationIdentifiers.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 11/04/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation

// Structure to define various UserNotification identifiers.

struct JmAppUserNotificationIdentifiers
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppUserNotificationIdentifiers"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // App Data field(s):

    static let sAppNotificationIdentifierActionStop     = "APP_NOTIFICATION_ACTION_ALARM_STOP"
    static let sAppNotificationIdentifierActionSnooze   = "APP_NOTIFICATION_ACTION_ALARM_SNOOZE"
    static let sAppNotificationIdentifierCategoryAlarm  = "APP_NOTIFICATION_CATEGORY_ALARM_SINGLE"
    static let sAppNotificationIdentifierCategorySnooze = "APP_NOTIFICATION_CATEGORY_ALARM_SNOOZE"

}   // End of struct JmAppUserNotificationIdentifiers.


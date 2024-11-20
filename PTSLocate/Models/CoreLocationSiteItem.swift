//
//  CoreLocationSiteItem.swift
//  PTSLocate
//
//  Created by JustMacApps.net on 05/09/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI

struct CoreLocationSiteItem: Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationSiteItem"
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Item Data field(s):
    
    let id                      = UUID()

    var sCLSiteItemName:String  = "-N/A-"
    var sCLSiteItemDesc:String  = "-N/A-"
    var sCLSiteItemValue:String = "-N/A-"
    var objCLSiteItemValue:Any? = nil
    
}   // End of struct CoreLocationSiteItem(Identifiable).


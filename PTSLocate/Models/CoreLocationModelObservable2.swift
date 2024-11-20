//
//  CoreLocationModelObservable2.swift
//  PTSLocate
//
//  Created by Daryl Cox on 11/14/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

class CoreLocationModelObservable2: NSObject, CLLocationManagerDelegate, ObservableObject
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "CoreLocationModelObservable2"
        static let sClsVers      = "v1.0208"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):
    
               var locationManager:CLLocationManager?         = nil

    @Published var bCLManagerHeadingAvailable:Bool            = false
    
    @Published var clCurrentLocation:CLLocation?              = nil       // Contains: Latitude, Longitude...
    @Published var sCurrentLocationName:String                = "-N/A-"   // This is actually the Street Address (Line #1) <# Street> (i.e. 8908 Michelle Ln)...
    @Published var sCurrentCity:String                        = "-N/A-"   // City (i.e. North Richland Hills)...
    @Published var sCurrentCountry:String                     = "-N/A-"   // Country (i.e. United States)...
    @Published var sCurrentPostalCode:String                  = "-N/A-"   // Zip Code (i.e. 76182) (Zip-5)...
    @Published var tzCurrentTimeZone:TimeZone?                = nil       // This is TimeZone in English (i.e. 'America/Chicago')...
    @Published var clCurrentRegion:CLRegion?                  = nil       // ???
    @Published var sCurrentSubLocality:String                 = "-N/A-"   // ??? 
    @Published var sCurrentThoroughfare:String                = "-N/A-"   // Street Name (Michelle Ln)...
    @Published var sCurrentSubThoroughfare:String             = "-N/A-"   // Address (Building) # (i.e. 8908)...
    @Published var sCurrentAdministrativeArea:String          = "-N/A-"   // State  (i.e. TX)...
    @Published var sCurrentSubAdministrativeArea:String       = "-N/A-"   // County (i.e. Tarrant County)

    @Published var listCoreLocationSiteItems:[CoreLocationSiteItem]
                                                              = []        // List of the 'current' Location Site Item(s)
                                                                          //      as CoreLocationSiteItem(s)...
    
               var jmAppDelegateVisitor:JmAppDelegateVisitor? = nil
                                                                          // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                          // as having it reference the 'shared' instance of 
                                                                          // JmAppDelegateVisitor causes a circular reference
                                                                          // between the 'init()' methods of the 2 classes...

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

               var listPreXCGLoggerMessages:[String]          = Array()

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        self.locationManager = CLLocationManager()
        
        self.locationManager?.delegate = self
        
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
    //  self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestAlwaysAuthorization()
        
        self.requestLocationUpdate()

        self.bCLManagerHeadingAvailable = CLLocationManager.headingAvailable()
        
        if (self.bCLManagerHeadingAvailable == true)
        {

            self.locationManager?.startUpdatingHeading()

        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

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
        asToString.append("'locationManager': [\(String(describing: self.locationManager))]")
        asToString.append("'bCLManagerHeadingAvailable': [\(String(describing: self.bCLManagerHeadingAvailable))]")
        asToString.append("'clCurrentLocation': [\(String(describing: self.clCurrentLocation))]")
        asToString.append("'sCurrentCity': [\(String(describing: self.sCurrentCity))]")
        asToString.append("'sCurrentCountry': [\(String(describing: self.sCurrentCountry))]")
        asToString.append("'sCurrentPostalCode': [\(String(describing: self.sCurrentPostalCode))]")
        asToString.append("'tzCurrentTimeZone': [\(String(describing: self.tzCurrentTimeZone))]")
        asToString.append("'clCurrentRegion': [\(String(describing: self.clCurrentRegion))]")
        asToString.append("'sCurrentSubLocality': [\(String(describing: self.sCurrentSubLocality))]")
        asToString.append("'sCurrentThoroughfare': [\(String(describing: self.sCurrentThoroughfare))]")
        asToString.append("'sCurrentSubThoroughfare': [\(String(describing: self.sCurrentSubThoroughfare))]")
        asToString.append("'sCurrentAdministrativeArea': [\(String(describing: self.sCurrentAdministrativeArea))]")
        asToString.append("'sCurrentSubAdministrativeArea': [\(String(describing: self.sCurrentSubAdministrativeArea))]")
        asToString.append("'listCoreLocationSiteItems': [\(String(describing: self.listCoreLocationSiteItems))]")
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
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from CoreLocationModelObservable2 === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from CoreLocationModelObservable2 === >>>")
            self.xcgLogMsg("")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    public func clearLastCLLocationSettings()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        }
        
        // Clear the 'last' CLLocation setting(s)...

        self.clCurrentLocation             = nil
        self.sCurrentLocationName          = "-N/A-"
        self.sCurrentCity                  = "-N/A-"
        self.sCurrentCountry               = "-N/A-"
        self.sCurrentPostalCode            = "-N/A-"
        self.tzCurrentTimeZone             = nil
        self.clCurrentRegion               = nil
        self.sCurrentSubLocality           = "-N/A-"
        self.sCurrentThoroughfare          = "-N/A-"
        self.sCurrentSubThoroughfare       = "-N/A-"
        self.sCurrentAdministrativeArea    = "-N/A-"
        self.sCurrentSubAdministrativeArea = "-N/A-"
        self.listCoreLocationSiteItems     = []

        // Exit:

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        }
    
        return

    } // End of public func clearLastCLLocationSettings().

    public func requestLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.requestLocation()
        
    //  self.locationManager?.startUpdatingLocation()

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of public func requestLocationUpdate().
    
    public func stopLocationUpdate()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of public func stopLocationUpdate().
    
    public func updateGeocoderLocation(latitude: Double, longitude: Double) -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        }
        
        // Instantiate a CLGeocoder and attempt to convert latitude/longitude into an address...

        self.clearLastCLLocationSettings()
        
        let clGeocoder:CLGeocoder      = CLGeocoder()
        let currentLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        clGeocoder.reverseGeocodeLocation(currentLocation, completionHandler: 
            { (placemarks, error) in

                if error == nil 
                {

                    let firstLocation                  = placemarks?[0]

                    self.clCurrentLocation             = firstLocation?.location
                    self.sCurrentLocationName          = firstLocation?.name                  ?? "-N/A-"
                    self.sCurrentCity                  = firstLocation?.locality              ?? "-N/A-"
                    self.sCurrentCountry               = firstLocation?.country               ?? "-N/A-"
                    self.sCurrentPostalCode            = firstLocation?.postalCode            ?? "-N/A-"
                    self.tzCurrentTimeZone             = firstLocation?.timeZone
                    self.clCurrentRegion               = firstLocation?.region
                    self.sCurrentSubLocality           = firstLocation?.subLocality           ?? "-N/A-"
                    self.sCurrentThoroughfare          = firstLocation?.thoroughfare          ?? "-N/A-"
                    self.sCurrentSubThoroughfare       = firstLocation?.subThoroughfare       ?? "-N/A-"
                    self.sCurrentAdministrativeArea    = firstLocation?.administrativeArea    ?? "-N/A-"
                    self.sCurrentSubAdministrativeArea = firstLocation?.subAdministrativeArea ?? "-N/A-"

                    let _ = self.updateCoreLocationSiteItemList()

                    if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) CLGeocoder 'reverseGeocodeLocation()' returned a 'location' of [\(self.sCurrentLocationName)]/[\(self.sCurrentCity)]...")

                    }

                }
                else 
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) CLGeocoder 'reverseGeocodeLocation()' failed to return a 'location' - Details: [\(String(describing: error))] - Error!")

                    self.clearLastCLLocationSettings()

                }

                // Exit...

                if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

                }

                return

            }

        )

        // Exit...

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        }
        
        return true
        
    }   // End of public func updateGeocoderLocations().

    public func updateGeocoderLocations(requestID:Int = 1, latitude: Double, longitude: Double, withCompletionHandler completionHandler:@escaping(_ requestID:Int, _ dictCurrentLocation:[String:Any])->Void) -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        }
        
        // Instantiate a CLGeocoder and attempt to convert latitude/longitude into an address...

        self.clearLastCLLocationSettings()
        
        let clGeocoder:CLGeocoder      = CLGeocoder()
        let currentLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        clGeocoder.reverseGeocodeLocation(currentLocation, completionHandler: 
            { (placemarks, error) in

                var dictCurrentLocation:[String:Any] = [:]

                if error == nil 
                {

                    let firstLocation                  = placemarks?[0]

                    self.clCurrentLocation             = firstLocation?.location
                    self.sCurrentLocationName          = firstLocation?.name                  ?? "-N/A-"
                    self.sCurrentCity                  = firstLocation?.locality              ?? "-N/A-"
                    self.sCurrentCountry               = firstLocation?.country               ?? "-N/A-"
                    self.sCurrentPostalCode            = firstLocation?.postalCode            ?? "-N/A-"
                    self.tzCurrentTimeZone             = firstLocation?.timeZone
                    self.clCurrentRegion               = firstLocation?.region
                    self.sCurrentSubLocality           = firstLocation?.subLocality           ?? "-N/A-"
                    self.sCurrentThoroughfare          = firstLocation?.thoroughfare          ?? "-N/A-"
                    self.sCurrentSubThoroughfare       = firstLocation?.subThoroughfare       ?? "-N/A-"
                    self.sCurrentAdministrativeArea    = firstLocation?.administrativeArea    ?? "-N/A-"
                    self.sCurrentSubAdministrativeArea = firstLocation?.subAdministrativeArea ?? "-N/A-"

                    let _ = self.updateCoreLocationSiteItemList()

                    dictCurrentLocation["clCurrentLocation"]             = self.clCurrentLocation            
                    dictCurrentLocation["sCurrentLocationName"]          = self.sCurrentLocationName         
                    dictCurrentLocation["sCurrentCity"]                  = self.sCurrentCity                 
                    dictCurrentLocation["sCurrentCountry"]               = self.sCurrentCountry              
                    dictCurrentLocation["sCurrentPostalCode"]            = self.sCurrentPostalCode           
                    dictCurrentLocation["tzCurrentTimeZone"]             = self.tzCurrentTimeZone            
                    dictCurrentLocation["clCurrentRegion"]               = self.clCurrentRegion              
                    dictCurrentLocation["sCurrentSubLocality"]           = self.sCurrentSubLocality          
                    dictCurrentLocation["sCurrentThoroughfare"]          = self.sCurrentThoroughfare         
                    dictCurrentLocation["sCurrentSubThoroughfare"]       = self.sCurrentSubThoroughfare      
                    dictCurrentLocation["sCurrentAdministrativeArea"]    = self.sCurrentAdministrativeArea   
                    dictCurrentLocation["sCurrentSubAdministrativeArea"] = self.sCurrentSubAdministrativeArea

                    if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) CLGeocoder 'reverseGeocodeLocation()' returned a 'location' of [\(self.sCurrentLocationName)]/[\(self.sCurrentCity)]...")

                    }

                }
                else 
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) CLGeocoder 'reverseGeocodeLocation()' failed to return a 'location' - Details: [\(String(describing: error))] - Error!")

                    self.clearLastCLLocationSettings()

                }

                // Exit...

                if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

                }

                completionHandler(requestID, dictCurrentLocation)

                return

            }

        )

        // Exit...

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        }
        
        return true
        
    }   // END of public func updateGeocoderLocations(requestID:Int, latitude:Double, longitude:Double, withCompletionHandler completionHandler:@escaping(_ requestID:Int, _ dictCurrentLocation:[String:Any])->Void) -> Bool

    public func updateCoreLocationSiteItemList() -> Bool
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        }
        
        // Build the CoreLocationSiteItem(s) list...

        self.listCoreLocationSiteItems = []
        
        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Location",
                                                                   sCLSiteItemDesc:    "(Latitude,Longitude)",
                                                                   sCLSiteItemValue:   "\(String(describing:self.clCurrentLocation))",
                                                                   objCLSiteItemValue: self.clCurrentLocation))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Street Address",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentLocationName))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "City",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentCity))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Zip Code",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentPostalCode))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "County",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentSubAdministrativeArea))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "State",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentAdministrativeArea))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "TimeZone",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.tzCurrentTimeZone))",
                                                                   sCLSiteItemValue:   "\(String(describing:self.tzCurrentTimeZone))",
                                                                   objCLSiteItemValue: self.tzCurrentTimeZone))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Country",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentCountry))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Street Name",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentThoroughfare))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Building #",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentSubThoroughfare))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Sub Locality",
                                                                   sCLSiteItemDesc:    "\(String(describing:self.sCurrentSubLocality))"))

        self.listCoreLocationSiteItems.append(CoreLocationSiteItem(sCLSiteItemName:    "Region",
                                                                   sCLSiteItemDesc:    "-N/A-",
                                                                   sCLSiteItemValue:   "\(String(describing:self.clCurrentRegion))",
                                                                   objCLSiteItemValue: self.clCurrentRegion))

        // Exit...

        if (AppGlobalInfo.bPerformAppCoreLocationTesting == true)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        }
        
        return true

    }   // End of public func updateCoreLocationSiteItemList().
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        guard let location = locations.last
        else { return }
        
        self.xcgLogMsg("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManager().
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        self.locationManager?.stopUpdatingLocation()
        
        if let clErr = error as? CLError
        {
            
            switch clErr.code
            {
                
            case .locationUnknown, .denied, .network:
                
                self.xcgLogMsg("Location request failed with error: \(clErr.localizedDescription)...")
                
            case .headingFailure:
                
                self.xcgLogMsg("Heading request failed with error: \(clErr.localizedDescription)...")
                
            case .rangingUnavailable, .rangingFailure:
                
                self.xcgLogMsg("Ranging request failed with error: \(clErr.localizedDescription)...")
                
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                
                self.xcgLogMsg("Region monitoring request failed with error: \(clErr.localizedDescription)...")
                
            default:
                
                self.xcgLogMsg("Unknown 'location manager' error: \(clErr.localizedDescription)...")
                
            }
            
        }
        else
        {
            
            self.xcgLogMsg("Unknown error occurred while handling the 'location manager' error: \(error.localizedDescription)...")
            
        }
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManager().
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        switch manager.authorizationStatus
        {
            
        case .notDetermined:
            
            self.xcgLogMsg("The User has NOT yet determined authorization...")
            
        case .restricted:
            
            self.xcgLogMsg("Authorization is RESTRICTED by Parental control...")
            
        case .denied:
            
            self.xcgLogMsg("The User has selected 'Do NOT Allow' (denied)...")
            
        case .authorizedAlways:
            
            self.xcgLogMsg("The User has changed the selection to 'Always Allow'...")
            
        case .authorizedWhenInUse:
            
            self.xcgLogMsg("The User has selected 'Allow while Using' or 'Allow Once'...")
            
            self.locationManager?.requestAlwaysAuthorization()
            
        default:
            
            self.xcgLogMsg("This is the 'default' option...")
            
        }
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    }   // End of func locationManagerDidChangeAuthorization().

}   // End of class CoreLocationModelObservable2(NSObject, CLLocationManagerDelegate, ObservableObject).


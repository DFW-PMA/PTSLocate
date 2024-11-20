//
//  RestURLEndpoint.swift
//  PTSLocate
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

// A class acting as a repository of Rest URL 'endpoint' data:

public class RestURLEndpoint: NSObject
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "RestURLEndpoint"
        static let sClsVers      = "v1.0201"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (c) JustMacApps 2018-2024. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true        

    } // End of struct ClassInfo.

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    // Rest URL Endpoint 'name' (Dictionary KEY):
    
    var sRestURLEndpointName:String?              = nil

    // Rest URL Endpoint is 'currently active'?

    var bRestURLEndpointActive:Bool               = false

    // Rest URL Endpoint Component(s):

    var sHttpProtocol:String?                     = nil
    var sHttpHost:String?                         = nil
    var sHttpPort:String?                         = nil

    // Rest URL Endpoint (default) Credentials (UserID/Pswd):

    var sUsername:String?                         = nil
    var sPassword:String?                         = nil

    // Rest URL Endpoint operational field(s):

    var sURLAccessToken:String                    = ""      // If needed...
    
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
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sRestURLEndpointName': [\(String(describing: self.sRestURLEndpointName))],")
        asToString.append("'bRestURLEndpointActive': [\(String(describing: self.bRestURLEndpointActive))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sHttpProtocol': [\(String(describing: self.sHttpProtocol))],")
        asToString.append("'sHttpHost': [\(String(describing: self.sHttpHost))],")
        asToString.append("'sHttpPort': [\(String(describing: self.sHttpPort))],")
        asToString.append("'sUsername': [\(String(describing: self.sUsername))],")
        asToString.append("'sPassword': [\(String(describing: self.sPassword))],")
        asToString.append("'sURLAccessToken': [\(String(describing: self.sURLAccessToken))],")
        asToString.append("]")
        
        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"
        
        return sContents
        
    } // End of public func toString().
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
      
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of (override) init().
    
    convenience init(name:String, active: Bool, httpProtocol:String, httpHost:String, httpPort:String?, user:String, password:String)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - Convenience Init #1...")

        self.sRestURLEndpointName   = name
        self.bRestURLEndpointActive = active
        self.sHttpProtocol          = httpProtocol
        self.sHttpHost              = httpHost
        self.sHttpPort              = httpPort
        self.sUsername              = user
        self.sPassword              = password

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of (convenience) init().

    convenience init(restURLEndpoint:RestURLEndpoint)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - Convenience Init #2...")

        self.sRestURLEndpointName   = restURLEndpoint.sRestURLEndpointName
        self.bRestURLEndpointActive = restURLEndpoint.bRestURLEndpointActive
        self.sHttpProtocol          = restURLEndpoint.sHttpProtocol   
        self.sHttpHost              = restURLEndpoint.sHttpHost     
        self.sHttpPort              = restURLEndpoint.sHttpPort
        self.sUsername              = restURLEndpoint.sUsername
        self.sPassword              = restURLEndpoint.sPassword

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of (convenience) init().

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

    public func splitHttpURLToComponentParts(sHttpURL:String)->(httpProtocol:String, httpHost:String, httpPort:String?)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        var sHttpProtocol      = "http"
        var sHttpHost          = "localhost"
        var sHttpPort:String?  = nil

        if (sHttpURL.count > 0)
        {

            var sWorkHttpURL:String = sHttpURL
            var asHttpURL:[String]? = sWorkHttpURL.leftPartitionStrings(target: "://")!
            
            if (asHttpURL != nil)
            {
                
                sHttpProtocol = asHttpURL![0]
                sWorkHttpURL  = asHttpURL![2]
                
            }
            
             if (sWorkHttpURL.count > 0)
            {
                
                asHttpURL = sWorkHttpURL.leftPartitionStrings(target: ":")!
                
                if (asHttpURL != nil)
                {
                    
                    sHttpHost = asHttpURL![0]
                    sHttpPort = asHttpURL![2]
                    
                }
                else
                {
                    
                    sHttpHost = sWorkHttpURL
                    
                }
                
            }
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return (sHttpProtocol, sHttpHost, sHttpPort)
        
    } // End of public func splitHttpURLToComponentParts().
    
    public func joinHttpURLFromComponentParts() -> String?
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        var sHttpURL:String?   = nil
        var sHttpProtocol      = "http"
        var sHttpHost          = "localhost"
 
        if (self.sHttpProtocol!.count > 0)
        {
            
            sHttpProtocol = self.sHttpProtocol!
            
        }
        if (self.sHttpHost!.count > 0)
        {
            
            sHttpHost = self.sHttpHost!
            
        }
        
        let sHttpURLPrefix = "\(sHttpProtocol)://\(sHttpHost)"
        
        if (self.sHttpPort        != nil &&
            self.sHttpPort!.count > 0)
        {
            
            sHttpURL = "\(sHttpURLPrefix):\(self.sHttpPort!)"
            
        }
        else
        {
            
            sHttpURL = sHttpURLPrefix
            
        }
        
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return sHttpURL
        
    } // End of public func joinHttpURLFromComponentParts().
    
} // End of public class RestURLEndpoint.

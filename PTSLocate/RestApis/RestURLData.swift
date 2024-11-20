//
//  RestURLData.swift
//  PTSLocate
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation

class RestURLData: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId          = "RestURLData"
        static let sClsVers        = "v1.0201"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2018-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    var restURLEndpoint:RestURLEndpoint?          = nil
    var sHttpURI:String                           = ""
    var sHttpParams:String                        = ""
    var sHttpGeneratedURL:String                  = ""

    var sLastJsonAPIRequestURL                    = ""
    var bLastJsonAPIQueryOk                       = false
    var iLastJsonAPIResponseStatus                = 0
    var sLastJsonAPIResponseError                 = ""

    var svJsonAPIResponseStack:[String]           = Array()

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
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'restURLEndpoint': [\(String(describing: self.restURLEndpoint!.toString()))],")
        asToString.append("'sHttpURI': [\(String(describing: self.sHttpURI))],")
        asToString.append("'sHttpParams': [\(String(describing: self.sHttpParams))],")
        asToString.append("'sHttpGeneratedURL': [\(String(describing: self.sHttpGeneratedURL))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sLastJsonAPIRequestURL': [\(self.sLastJsonAPIRequestURL))],")
        asToString.append("'bLastJsonAPIQueryOk': [\(self.bLastJsonAPIQueryOk))],")
        asToString.append("'iLastJsonAPIResponseStatus': [\(self.iLastJsonAPIResponseStatus))],")
        asToString.append("'sLastJsonAPIResponseError': [\(String(describing: self.sLastJsonAPIResponseError))],")
        asToString.append("'svJsonAPIResponseStack': [\(String(describing: svJsonAPIResponseStack))],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (public) func toString().

    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
      
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of init().

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

    func generateHttpURL() -> (bGenerateHttpURLOk:Bool, sGeneratedHttpURL:String)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'restURLEndpoint' [\(self.restURLEndpoint!.toString())] - 'sHttpURI' [\(self.sHttpURI)] - 'sHttpParams' [\(self.sHttpParams)]...")

        var sHttpURLPrefix = "\(self.restURLEndpoint!.sHttpProtocol!)://\(self.restURLEndpoint!.sHttpHost!)"

        if (self.restURLEndpoint!.sHttpPort        != nil &&
            self.restURLEndpoint!.sHttpPort!.count > 0)
        {

            sHttpURLPrefix = "\(sHttpURLPrefix):\(self.restURLEndpoint!.sHttpPort!)"

        }

        sHttpURLPrefix = "\(sHttpURLPrefix)/"

        if (self.sHttpURI.count > 0)
        {

            sHttpURLPrefix = "\(sHttpURLPrefix)\(self.sHttpURI)"

        }

        if (self.sHttpParams.count > 0)
        {

            sHttpURLPrefix = "\(sHttpURLPrefix)?\(self.sHttpParams)"

        }

        self.sHttpGeneratedURL = sHttpURLPrefix

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return (true, self.sHttpGeneratedURL)

    } // End of func generateHttpURL().

    func addJsonAPIResponse(bJsonAPIQueryOk:Bool = false, jsonAPIReqURL:URLRequest? = nil, iJsonAPIRespStatus:Int = 0, sJsonAPIRespError:String = "", adJsonAPIRespResult:[NSDictionary]? = nil) -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        var cdJsonAPIRespResults = 0

        if (adJsonAPIRespResult != nil)
        {

            cdJsonAPIRespResults = adJsonAPIRespResult!.count

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'bJsonAPIQueryOk' [\(bJsonAPIQueryOk)] - 'jsonAPIReqURL' [\(String(describing: jsonAPIReqURL))] - 'iJsonAPIRespStatus' [\(iJsonAPIRespStatus)] - 'sJsonAPIRespError' [\(String(describing: sJsonAPIRespError))] - 'adJsonAPIRespResult' (\(cdJsonAPIRespResults)) element(s)...")

        self.sLastJsonAPIRequestURL = "-N/A"

        if (jsonAPIReqURL != nil)
        {

            self.sLastJsonAPIRequestURL = "\(jsonAPIReqURL!.httpMethod!):\(String(describing: jsonAPIReqURL!))"
 
        }

        self.bLastJsonAPIQueryOk        = bJsonAPIQueryOk
        self.iLastJsonAPIResponseStatus = iJsonAPIRespStatus
        self.sLastJsonAPIResponseError  = sJsonAPIRespError

        var asLastJsonAPIRespResult:[String] = Array()

        asLastJsonAPIRespResult.append(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
        asLastJsonAPIRespResult.append("The 'last' Json API 'sLastJsonAPIRequestURL' is [\(self.sLastJsonAPIRequestURL)]...")
        asLastJsonAPIRespResult.append("The 'last' Json API 'bLastJsonAPIQueryOk' is [\(self.bLastJsonAPIQueryOk)]...")
        asLastJsonAPIRespResult.append("The 'last' Json API 'iLastJsonAPIResponseStatus' is [\(self.iLastJsonAPIResponseStatus)]...")
        asLastJsonAPIRespResult.append("The 'last' Json API 'sLastJsonAPIResponseError' is [\(self.sLastJsonAPIResponseError)]...")

        if (adJsonAPIRespResult != nil &&
            adJsonAPIRespResult!.count > 0)
        {

            asLastJsonAPIRespResult.append("The 'last' Json API response data contains (\(adJsonAPIRespResult!.count)) lines:")

            for (i, dictJsonResult) in adJsonAPIRespResult!.enumerated()
            {
                
                var j = 0

                for (dictJsonKey, dictJsonValue) in dictJsonResult
                {

                    j += 1
                    
                    asLastJsonAPIRespResult.append("JSON result #(\(i + 1):\(j)): Key [\(dictJsonKey)], Value [\(dictJsonValue)]...")

                }
                
            }

        }

        self.svJsonAPIResponseStack.append(asLastJsonAPIRespResult.joined(separator: "\n"))

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    } // End of func addJsonAPIResponse().

    func clearJsonAPIResponses() -> Bool
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'svJsonAPIResponseStack' contains (\(self.svJsonAPIResponseStack.count)) element(s)...")

        self.svJsonAPIResponseStack = Array()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return true

    } // End of func clearJsonAPIResponses().

    func renderJsonAPIResponsesToString() -> String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'svJsonAPIResponseStack' contains (\(self.svJsonAPIResponseStack.count)) element(s)...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return (self.svJsonAPIResponseStack.joined(separator: "\n"))

    } // End of func renderJsonAPIResponsesToString().

} // End of class RestURLData.


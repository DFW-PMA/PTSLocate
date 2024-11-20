//
//  RestURLProcessor.swift
//  PTSLocate
//
//  Created by Daryl Cox on 08/11/2024.
//  Copyright (c) JustMacApps 2018-2024. All rights reserved.
//

import Foundation
// import Cocoa

class RestURLProcessor: NSObject
{

    struct ClassInfo
    {
        
        static let sClsId          = "RestURLProcessor"
        static let sClsVers        = "v1.0201"
        static let sClsDisp        = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2018-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    var id:String
    var restURLData:RestURLData?

    var jsonRequest:NSMutableURLRequest?
    var jsonResponse:HTTPURLResponse?
    var aiJsonResponseStatusCodes:[Int]?
    var sJsonResponseData:String                  = ""
    var adJsonResult:[NSDictionary]               = Array()

    open func toString()->String
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
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'restURLData': [\(String(describing: self.restURLData))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jsonRequest': [\(String(describing: self.jsonRequest)))],")
        asToString.append("'jsonResponse': [\(String(describing: self.jsonResponse)))],")
        asToString.append("'aiJsonResponseStatusCodes': [\(String(describing: self.aiJsonResponseStatusCodes)))],")
        asToString.append("'sJsonResponseData': [\(String(describing: self.sJsonResponseData)))],")
        asToString.append("'adJsonResult': [\(String(describing: self.adJsonResult)))],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    } // End of (open) func toString().

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.id = UUID().uuidString
        
        super.init()
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return
        
    } // End of (override) init().

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

    func generateURLRequestBoundaryString() -> String
    {

        return "Web-Form-Boundary-\(NSUUID().uuidString)";

    } // End of func generateURLRequestBoundaryString().

    func handleURLRequestWithJsonResponse(reset: Bool) -> RestURLResponse
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'reset' [\(reset)] - 'jsonRequest' [\(String(describing: self.jsonRequest))]...")

        let basicURLResponse = handleURLRequestWithBasicResponse(reset: reset)

        if (basicURLResponse.bRestURLQueryOk == false)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return basicURLResponse

        }

        self.adJsonResult = []

        let sJsonDataRead:String    = (basicURLResponse.sRestURLResponseData.stringByReplacingAllOccurrencesOfString(target: "\r", withString: ""))
        let asJsonDataRead:[String] = sJsonDataRead.components(separatedBy: "\n")
        
        self.xcgLogMsg("\(sCurrMethodDisp) The converted RAW Data response 'sJsonDataRead' is (\(sJsonDataRead.count)) byte(s)...")
        self.xcgLogMsg("\(sCurrMethodDisp) The returned 'asJsonDataRead' contains (\(asJsonDataRead.count)) lines...")

        let sJsonDataBlock      = asJsonDataRead.joined(separator: "")
        let dataJsonLine:NSData = sJsonDataBlock.data(using: String.Encoding.utf8)! as NSData

        self.xcgLogMsg("The generated 'sJsonDataBlock' is (\(sJsonDataBlock.count)) [\(sJsonDataBlock)]...")

        var jsonData1:NSDictionary?             = nil
        var jsonData2:[Dictionary<String,Any>]? = nil
        
        if (basicURLResponse.sRestURLResponseData.length > 0 &&
            sJsonResponseData.count > 0)
        {

            if (sJsonDataBlock.hasPrefix("{") == true)
            {

                do
                {
                    
                    jsonData1 = try JSONSerialization.jsonObject(with: dataJsonLine as Data, options:JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                    
                }
                catch let error as NSError
                {
                    
                    self.xcgLogMsg("\(sCurrMethodDisp) JSON Decoding of line [\(dataJsonLine)] (1st pass @ Dictionary) - raw: [\(sJsonDataBlock)] - error: [\(error.domain)]!")
                    
                    jsonData1 = nil
                    
                }

                if (jsonData1 != nil)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) The 'deserialized' JSON result dictionary 'jsonData1' is [\(String(describing: jsonData1!))]...")

                    self.adJsonResult.append(jsonData1!)

                }

            }
            else
            {

                do
                {

                    jsonData2 = try JSONSerialization.jsonObject(with: dataJsonLine as Data, options:JSONSerialization.ReadingOptions.allowFragments) as? [Dictionary<String,Any>]

                }
                catch let error as NSError
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) JSON Decoding of line [\(dataJsonLine)] (2nd pass @ Array of Dictionaries) - raw: [\(sJsonDataBlock)] - error: [\(error.domain)]!")

                    jsonData2 = nil

                }

                if (jsonData2 != nil)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) The 'deserialized' JSON result array of dictonaries 'jsonData2' is [\(String(describing: jsonData2!))]...")
                    
                    for (_, dictJsonResult) in jsonData2!.enumerated()
                    {
                        
                        let dictJsonAppend = NSDictionary(dictionary: dictJsonResult)
                                               
                        self.adJsonResult.append(dictJsonAppend)
                        
                    }
                        
                }

            }

        }

        if (jsonData1 == nil &&
            jsonData2 == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The 'deserialized' JSON result dictonaries 'jsonData1' and 'jsonData2' are BOTH 'nil'...")

        }

        if (basicURLResponse.sRestURLResponseData.length > 0 &&
            asJsonDataRead.count                         > 0 &&
            adJsonResult.count                           < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Failed to 'deserialize' a JSON result array that is a Dictionary-of-Dictionaries - Error!")

        }

        _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: basicURLResponse.bRestURLQueryOk, jsonAPIReqURL: URLRequest(url: URL(string: basicURLResponse.sRestURLRequest)!), iJsonAPIRespStatus: basicURLResponse.iRestURLResponseStatus, sJsonAPIRespError: basicURLResponse.sRestURLResponseError, adJsonAPIRespResult: self.adJsonResult)

        if (self.adJsonResult.count > 0)
        {

            basicURLResponse.adRestURLResponseResult = self.adJsonResult

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return basicURLResponse
       
    } // End of func handleURLRequestWithJsonResponse().

    func handleURLRequestWithBasicResponse(reset: Bool, dataIsBinary:Bool? = false) -> RestURLResponse
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "'"+sCurrMethod+"()'"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'reset' [\(reset)] - 'dataIsBinary' [\(String(describing: dataIsBinary))] - 'jsonRequest' [\(String(describing: self.jsonRequest))]...")

        let bJsonAPIReqURLReset      = reset
        let jsonAPIReqURL:URLRequest = self.jsonRequest! as URLRequest
        var iJsonAPIRespStatus       = -1
        var sJsonAPIRespError        = "-N/A-"

        if (self.restURLData == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The 'restURLData' object is 'nil' - Severe Error!")

            _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: false, jsonAPIReqURL: jsonAPIReqURL, iJsonAPIRespStatus: iJsonAPIRespStatus, sJsonAPIRespError: sJsonAPIRespError, adJsonAPIRespResult: nil)

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return RestURLResponse(bHandleURLRequestOk: false, sURLRequest: self.jsonRequest!.url!.absoluteString, iURLResponseStatus: iJsonAPIRespStatus, sURLResponseMsg: sJsonAPIRespError)

        }
        
        var bWaiting:Bool = true
    //  let session       = URLSession.shared
        let session       = URLSession(configuration: URLSessionConfiguration.ephemeral)

        if (bJsonAPIReqURLReset == true)
        {

            bWaiting = true
        
        //  session.flush(completionHandler:
            session.reset(completionHandler:
                {
                    
                    bWaiting = false
            
                }
                
            )

            while(bWaiting == true)
            {

                // Delay for 5/1000th of a second to let the URL session to 'reset' (and loop til its' done)...

                usleep(5000)

            }

        }

        var urlData:NSData? = nil
        var urlResponse:URLResponse?
        var urlError:NSError?

        bWaiting = true
        
        let dataTask = session.dataTask(with: self.jsonRequest! as URLRequest, completionHandler:
            {   (data, response, responseError) -> Void in

                if (responseError != nil)
                {

                    print(responseError as Any)

                    self.xcgLogMsg("\(sCurrMethodDisp) 'responseError' [\(String(describing: responseError))] - 'domain' \(responseError!._domain) - 'description' \(responseError!.localizedDescription)!!!")
  
                    urlData     = nil
                    urlResponse = nil
                    urlError    = responseError! as NSError

                }
                else 
                {

                    let httpResponse = response as? HTTPURLResponse

                    print(httpResponse as Any)

                    urlResponse = response

                    self.xcgLogMsg("\(sCurrMethodDisp) 'urlResponse' [\(String(describing: urlResponse))]...")

                    if (data != nil)
                    {

                        urlData = data! as NSData

                        self.xcgLogMsg("\(sCurrMethodDisp) 'urlData' response contains (\(urlData!.length)) byte(s)...")
                        
                    }
                    else
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) 'data' is 'nil' - Error!")

                        urlData = nil

                    }

                    urlError = nil

                }
            
                bWaiting = false

            }

        )

        dataTask.resume()

        while(bWaiting == true)
        {
            
            // Delay for 5/1000th of a second to let the URL request process (and loop til its' done)...

            usleep(5000)
            
        }
  
        if (urlError == nil)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The 'urlError' object is 'nil'...")

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The 'urlError' object is NOT 'nil' - 'urlError' is [\(String(describing: urlError))]...")

            iJsonAPIRespStatus = urlError!.code
            sJsonAPIRespError  = "\(urlError!.localizedDescription)"

        }

        if (urlResponse == nil)
        {

            if (urlError == nil)
            {

                iJsonAPIRespStatus = -2
                sJsonAPIRespError  = "The 'urlResponse' object is 'nil' - Error!"

            }

            self.xcgLogMsg("\(sCurrMethodDisp) 'sJsonAPIRespError' is [\(sJsonAPIRespError)]...")

            _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: false, jsonAPIReqURL: jsonAPIReqURL, iJsonAPIRespStatus: iJsonAPIRespStatus, sJsonAPIRespError: sJsonAPIRespError, adJsonAPIRespResult: nil)

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return RestURLResponse(bHandleURLRequestOk: false, sURLRequest: self.jsonRequest!.url!.absoluteString, iURLResponseStatus: iJsonAPIRespStatus, sURLResponseMsg: sJsonAPIRespError)

        }

        if (urlData == nil)
        {

            if (urlError == nil)
            {

                iJsonAPIRespStatus = -3
                sJsonAPIRespError  = "The 'urlData' object is 'nil' - Error!"

            }

            self.xcgLogMsg("\(sCurrMethodDisp) 'sJsonAPIRespError' is [\(sJsonAPIRespError)]...")

            _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: false, jsonAPIReqURL: jsonAPIReqURL, iJsonAPIRespStatus: iJsonAPIRespStatus, sJsonAPIRespError: sJsonAPIRespError, adJsonAPIRespResult: nil)

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return RestURLResponse(bHandleURLRequestOk: false, sURLRequest: self.jsonRequest!.url!.absoluteString, iURLResponseStatus: iJsonAPIRespStatus, sURLResponseMsg: sJsonAPIRespError)

        }

        self.jsonResponse      = urlResponse as? HTTPURLResponse
        self.sJsonResponseData = ""
        self.adJsonResult      = []
            
        self.xcgLogMsg("\(sCurrMethodDisp) The 'urlData' object is NOT 'nil' - contains (\(urlData!.length)) byte(s) - HTTP 'response' status code is (\(String(describing: self.jsonResponse!.statusCode)))...")

        var bHandleURLRequestOk = false;

        if self.aiJsonResponseStatusCodes!.contains(jsonResponse!.statusCode)
        {

            bHandleURLRequestOk = true
            sJsonAPIRespError   = "Request 'handled' Ok..."

        }
        else
        {

            bHandleURLRequestOk = false
            sJsonAPIRespError   = "Request FAILED - Error!"

        }

        iJsonAPIRespStatus = jsonResponse!.statusCode

        if (dataIsBinary == false)
        {

            self.sJsonResponseData = NSString(data:urlData! as Data, encoding:String.Encoding.utf8.rawValue)! as String

            self.xcgLogMsg("\(sCurrMethodDisp) The RAW Data response 'string' is (\(self.sJsonResponseData.count)) byte(s)...")

            if (bHandleURLRequestOk == false)
            {

                _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: bHandleURLRequestOk, jsonAPIReqURL: jsonAPIReqURL, iJsonAPIRespStatus: jsonResponse!.statusCode, sJsonAPIRespError: sJsonAPIRespError, adJsonAPIRespResult: self.adJsonResult)

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return RestURLResponse(bHandleURLRequestOk: bHandleURLRequestOk, sURLRequest: self.jsonRequest!.url!.absoluteString, iURLResponseStatus: iJsonAPIRespStatus, sURLResponseMsg: sJsonAPIRespError, sURLResponseData: self.sJsonResponseData)

        }

        if (bHandleURLRequestOk == false)
        {

            _ = self.restURLData!.addJsonAPIResponse(bJsonAPIQueryOk: bHandleURLRequestOk, jsonAPIReqURL: jsonAPIReqURL, iJsonAPIRespStatus: jsonResponse!.statusCode, sJsonAPIRespError: sJsonAPIRespError, adJsonAPIRespResult: self.adJsonResult)

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return RestURLResponse(bHandleURLRequestOk: bHandleURLRequestOk, sURLRequest: self.jsonRequest!.url!.absoluteString, iURLResponseStatus: iJsonAPIRespStatus, sURLResponseMsg: sJsonAPIRespError, nsURLResponseData: urlData!)
       
    } // End of func handleURLRequestWithBasicResponse().

} // End of class RestURLProcessor.


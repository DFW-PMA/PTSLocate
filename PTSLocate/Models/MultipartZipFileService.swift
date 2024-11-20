//
//  MultipartZipFileService.swift
//  JustAMultipartRequestTest1
//
//  Created by JustMacApps.net on 11/06/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

import Foundation

// Enum(s):

enum ZipServiceError:Swift.Error 
{

    case urlNotADirectory(URL)
    case failedToCreateZIP(Swift.Error)
    case failedToGetDataFromZipURL

}   // END of enum ZipServiceError:Swift.Error.

enum ZipFileDetails 
{

    case data(Data, filename:String)
    case existingFile(URL)
    case renamedFile(URL, toFilename:String)

}   // END of enum ZipFileDetails.

// Extension(s):

extension URL 
{

    var isDirectory: Bool 
    {

       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true

    }

}   // END of extension URL.

extension ZipFileDetails 
{

    static func text(_ text:String, filename:String)->ZipFileDetails 
    {

        .data(text.data(using: .utf8) ?? Data(), filename: filename)

    }   // END of static func text(_ text:String, filename:String)->ZipFileDetails

}   // END of extension ZipFileDetails.

extension ZipFileDetails 
{

    func prepareInDirectory(directoryURL:URL) throws 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "Extension<ZipFileDetails>.'"+sCurrMethod+"':"

        print("\(sCurrMethodDisp) Invoked - parameter 'directoryURL' is [\(directoryURL)]...")

        switch self 
        {

        case .data(let data, filename:let filename):

            let fileURL = directoryURL.appendingPathComponent(filename)

            print("\(sCurrMethodDisp) <case .data> Writing .data to 'fileURL' is [\(fileURL)]...")

            try data.write(to:fileURL)

        case .existingFile(let existingFileURL):

            let filename                      = existingFileURL.lastPathComponent
            let newFileURL                    = directoryURL.appendingPathComponent(filename)
            var sTargetFilespec:String        = newFileURL.path
            let bIsTargetFilespecPresent:Bool = JmFileIO.fileExists(sFilespec:sTargetFilespec)

            if (bIsTargetFilespecPresent == true)
            {

                print("\(sCurrMethodDisp) <case .existingFile> 'target' file [\(String(describing: sTargetFilespec))] exists - deleting it...")

                try FileManager.default.removeItem(at:newFileURL)

                print("\(sCurrMethodDisp) <case .existingFile> Successfully removed the 'target' URL of [\(String(describing: newFileURL))]...")

            }

            print("\(sCurrMethodDisp) <case .existingFile> Copying 'existingFileURL' of [\(existingFileURL)] to 'newFileURL' of [\(newFileURL)]...")

            try FileManager.default.copyItem(at:existingFileURL, to:newFileURL)

        case .renamedFile(let existingFileURL, toFilename:let filename):

            let newFileURL = directoryURL.appendingPathComponent(filename)

            print("\(sCurrMethodDisp) <case .renamedFile> Copying 'existingFileURL' of [\(existingFileURL)] to 'newFileURL' of [\(newFileURL)]...")

            try FileManager.default.copyItem(at:existingFileURL, to:newFileURL)

        }

        // Exit:

        print("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of func prepareInDirectory(directoryURL:URL) throws.

}   // END of extension ZipFileDetails.

// Method(s) - ZIP 'service':

class MultipartZipFileService: NSObject 
{

    struct ClassInfo
    {
        
        static let sClsId          = "MultipartZipFileService"
        static let sClsVers        = "v1.0205"
        static let sClsDisp        = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    // App Data field(s):

            var bShouldOverwriteZipIfNecessary:Bool       = true

            var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor

    override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        super.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of override init().

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

    public func createZip(zipFinalURL:URL, fromDirectory directoryURL:URL)throws->URL 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFinalURL' is [\(zipFinalURL)] - 'directoryURL' is [\(directoryURL)]...")

        // See URL extension below...

        guard directoryURL.isDirectory 
        else { throw ZipServiceError.urlNotADirectory(directoryURL) }
        
        var fileManagerError:Swift.Error?
        var coordinatorError:NSError?

        let coordinator = NSFileCoordinator()

        coordinator.coordinate(readingItemAt:directoryURL, options:.forUploading, error:&coordinatorError) 
        { zipAccessURL in

            do 
            {

                if (self.bShouldOverwriteZipIfNecessary)
                {

                    let _ = try FileManager.default.replaceItemAt(zipFinalURL, withItemAt:zipAccessURL)

                } 
                else 
                {

                    try FileManager.default.moveItem(at:zipAccessURL, to:zipFinalURL)

                }

            } 
            catch 
            {

                fileManagerError = error

                self.xcgLogMsg("\(sCurrMethodDisp) <do/catch> Failed to create the 'target' Zip file [\(zipFinalURL)] - Details: [\(error)] - Error!")

            }

        }

        if let zipServiceError = (coordinatorError ?? fileManagerError)
        {

            throw ZipServiceError.failedToCreateZIP(zipServiceError)

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'zipFinalURL' is [\(String(describing: zipFinalURL))]...")

        return zipFinalURL

    }   // END of public func createZip(zipFinalURL:URL, fromDirectory directoryURL:URL)throws->URL.

    public func createZipAtTmp(zipFilename:String, zipExtension:String="zip", fromDirectory directoryURL:URL)throws->URL 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFilename' is [\(zipFilename)] - 'zipExtension' is [\(zipExtension)] - 'directoryURL' is [\(directoryURL)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Creating the Final 'finalDirectoryToZipURL'...")

    #if os(macOS)

    //  let urlForZipFilename:URL  = URL(fileURLWithPath:zipFilename)
    //  let finalDirectoryToZipURL = try FileManager.default.url(for:           .itemReplacementDirectory,
    //                                                           in:            .userDomainMask,
    //                                                           appropriateFor:urlForZipFilename,
    //                                                           create:        true)
    //                                                           .appending(path:UUID().uuidString).appending(path:zipFilename)
    //                                                       //  .appending(path:zipFilename).appendingPathExtension(zipExtension)

        let finalDirectoryToZipURL = directoryURL

        self.xcgLogMsg("\(sCurrMethodDisp) Using the <macOS> Final 'finalDirectoryToZipURL' of [\(String(describing: finalDirectoryToZipURL))]...")

    #elseif os(iOS)

        let finalDirectoryToZipURL = FileManager.default.temporaryDirectory.appending(path:zipFilename).appendingPathExtension(zipExtension)

        self.xcgLogMsg("\(sCurrMethodDisp) Created the <iOS> Final 'finalDirectoryToZipURL' of [\(String(describing: finalDirectoryToZipURL))]...")

    #endif

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'finalDirectoryToZipURL' is [\(String(describing: finalDirectoryToZipURL))]...")

        return try createZip(zipFinalURL:finalDirectoryToZipURL, fromDirectory:directoryURL)

    }   // END of public func createZipAtTmp(zipFilename:String, zipExtension:String="zip", fromDirectory directoryURL:URL)throws->URL.

    public func createZipAtTmp(zipFilename:String, zipExtension:String="zip", filesToZip:[ZipFileDetails])throws->URL 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFilename' is [\(zipFilename)] - 'zipExtension' is [\(zipExtension)] - 'filesToZip' is [\(filesToZip)]...")

        self.xcgLogMsg("\(sCurrMethodDisp) Creating the 'directoryToZipURL'...")

    #if os(macOS)

        let urlForZipFilename:URL = URL(fileURLWithPath:zipFilename)
        let directoryToZipURL     = try FileManager.default.url(for:           .itemReplacementDirectory,
                                                                in:            .userDomainMask,
                                                                appropriateFor:urlForZipFilename,
                                                                create:        true)
                                                                .appending(path:UUID().uuidString).appending(path:zipFilename)

    #elseif os(iOS)

        let directoryToZipURL = FileManager.default.temporaryDirectory.appending(path:UUID().uuidString).appending(path:zipFilename)

    #endif

        self.xcgLogMsg("\(sCurrMethodDisp) Calculated that the Temporary 'directoryToZipURL' is [\(String(describing: directoryToZipURL))]...")

        try FileManager.default.createDirectory(at:directoryToZipURL, withIntermediateDirectories:true, attributes:[:])

        self.xcgLogMsg("\(sCurrMethodDisp) Created the Temporary 'directoryToZipURL' of [\(String(describing: directoryToZipURL))]...")

        for zipFileDetails in filesToZip 
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Adding the file 'zipFileDetails' of [\(zipFileDetails)] to the Temporary 'directoryToZipURL' of [\(String(describing: directoryToZipURL))]...")

            try zipFileDetails.prepareInDirectory(directoryURL:directoryToZipURL)

            self.xcgLogMsg("\(sCurrMethodDisp) Added  the file 'zipFileDetails' of [\(zipFileDetails)] to the Temporary 'directoryToZipURL' of [\(String(describing: directoryToZipURL))]...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'directoryToZipURL' is [\(String(describing: directoryToZipURL))]...")

        return try createZipAtTmp(zipFilename:zipFilename, zipExtension:zipExtension, fromDirectory:directoryToZipURL)

    }   // END of public func createZipAtTmp(zipFilename:String, zipExtension:String="zip", filesToZip:[ZipFileDetails])throws->URL.
    
    public func getZipData(zipFilename:String=UUID().uuidString, fromDirectory directoryURL:URL)throws->Data 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFilename' is [\(zipFilename)] - 'directoryURL' is [\(directoryURL)]...")

        let tmpZipURL = try self.createZipAtTmp(zipFilename:zipFilename, fromDirectory:directoryURL)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'tmpZipURL' is [\(tmpZipURL)]...")

        return try self.getZipData(zipFileURL:tmpZipURL)

    }   // END of public func getZipData(zipFilename:String=UUID().uuidString, fromDirectory directoryURL:URL)throws->Data.
    
    public func getZipData(zipFilename:String=UUID().uuidString, filesToZip:[ZipFileDetails])throws->Data 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFilename' is [\(zipFilename)] - 'filesToZip' is [\(filesToZip)]...")

        let tmpZipURL = try self.createZipAtTmp(zipFilename:zipFilename, filesToZip:filesToZip)

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'tmpZipURL' is [\(tmpZipURL)]...")

        return try self.getZipData(zipFileURL:tmpZipURL)

    }   // END of func public getZipData(zipFilename:String=UUID().uuidString, filesToZip:[ZipFileDetails])throws->Data.

    private func getZipData(zipFileURL:URL)throws->Data 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'zipFileURL' is [\(zipFileURL)]...")

        if let data = FileManager.default.contents(atPath:zipFileURL.path)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) FileManager read the contents of the ZIP file 'zipFileURL' is [\(String(describing: zipFileURL))]...")
            
            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return data

        } 
        else 
        {

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - via 'throw' of 'ZipServiceError.failedToGetDataFromZipURL' - Error!")

            throw ZipServiceError.failedToGetDataFromZipURL

        }

    }   // END of private func getZipData(zipFileURL:URL)throws->Data.

}   // END of final class MultipartZipFileService(NSObject).


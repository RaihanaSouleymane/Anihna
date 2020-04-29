//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.


import Foundation


public extension Data
{
    // Returns a hex String representation of the data

    func hexString() -> String
    {
        var result:String = ""
        self.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Void in
            for i in 0 ..< count {
                let byte = bytes[i]
                let hex = String(format: "%02x", byte)
                result.append(hex)
            }
        }

        return result
    }
    
    static func fromHexString(_ hexString:String) -> Data?
    {
        let trimmedString = hexString.trimmingCharacters(in: CharacterSet(charactersIn: "<> ")).replacingOccurrences(of: " ", with: "")
        // make sure the cleaned up string consists solely of hex digits, and that we have even number of them
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]*$", options: .caseInsensitive)
        let found = regex.firstMatch(in: trimmedString, options: [], range: NSMakeRange(0, trimmedString.count))
        if found == nil || found?.range.location == NSNotFound || trimmedString.count % 2 != 0 {
            return nil
        }
        
        // everything ok, so now let's build NSData
        
        let data = trimmedString.data(using: String.Encoding.utf8)!

        return data as Data?
    }
}


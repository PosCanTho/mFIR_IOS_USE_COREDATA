//
//  Utils.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/31/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Utils {
    
    //String to hex md5
    static func hexMD5(string: String) -> String {
        
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        let hexMd5 = digestData.map { String(format: "%02hhx", $0) }.joined()
        return hexMd5
    }
    
    //String to encrypt sha1
    static func encyptSha1(string: String) -> String {
   
        let data = string.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        return Data(bytes: digest).base64EncodedString()
        
    }
    
    //Password encrypt
    static func passwordEncrypt (password: String) -> String {
        let hash = encyptSha1(string: hexMD5(string: password)).data(using: .utf8)
        let pass = hash?.base64EncodedString()
        return pass!
    }
    
    
    
}

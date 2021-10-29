//
//  PallyConUtil.swift
//  DrmSDK_iOS
//
//  Created by Peter Kuo on 2021/10/25.
//

import Foundation
import CryptoSwift

class PallyConUtil {
    static func generateToken(configuation: PallyConConfiguration) throws -> PallyconToken {
        
        // encrypt policy
        let policyData = try JSONEncoder().encode(configuation.policy)
        let policyBytes = [UInt8](policyData)
        let aes = try AES(key: configuation.site.siteKey, iv: configuation.aesIv, padding: .pkcs7)
        let encryptedPolicyBytes = try aes.encrypt(policyBytes)
        let encryptedPolicyData = Data(encryptedPolicyBytes)
        let encryptedPolicyBase64 = encryptedPolicyData.base64EncodedString()
        
        // timestamp
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: .zero)
        let timestampString = formatter.string(from: Date())
        
        // hash
        let hashInputString = configuation.site.accessKey
            + configuation.license.drmType.rawValue
            + configuation.site.siteId
            + configuation.license.userId
            + configuation.license.contentId
            + encryptedPolicyBase64
            + timestampString
        let hashInputData = hashInputString.data(using: .utf8)!
        let hashOutputData = hashInputData.sha256()
        let hashOutputBase64 = hashOutputData.base64EncodedString()
        
        //
        return PallyconToken(drmType: configuation.license.drmType.rawValue,
                             siteId: configuation.site.siteId,
                             userId: configuation.license.userId,
                             contentId: configuation.license.contentId,
                             policy: encryptedPolicyBase64,
                             timestamp: timestampString,
                             hash: hashOutputBase64)
    }
    
    static func generateTokenString(configuation: PallyConConfiguration) throws -> String  {
        
        let token = try generateToken(configuation: configuation)
        let tokenData = try JSONEncoder().encode(token)
        let tokenBase64 = tokenData.base64EncodedString()
        
        return tokenBase64
    }
}

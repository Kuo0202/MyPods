//
//  PallyconToken.swift
//  DrmSDK_iOS
//
//  Created by Peter Kuo on 2021/10/25.
//

import Foundation

struct PallyconToken: Encodable {
    var drmType: String
    var siteId: String
    var userId: String
    var contentId: String
    var policy: String
    var timestamp: String
    var hash: String
    
    private enum CodingKeys : String, CodingKey {
        case drmType =      "drm_type"
        case siteId =       "site_id"
        case userId =       "user_id"
        case contentId =    "cid"
        case policy =       "policy"
        case timestamp =    "timestamp"
        case hash =         "hash"
    }
}

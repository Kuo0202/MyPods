//
//  PallyconPlaybackPolicy.swift
//  DrmSDK_iOS
//
//  Created by Peter Kuo on 2021/10/25.
//

import Foundation

struct PallyconPlaybackPolicy: Encodable {
    var limit: Bool
    var persistent: Bool
    var duration: Int
}

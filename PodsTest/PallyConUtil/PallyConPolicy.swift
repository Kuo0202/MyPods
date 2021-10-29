//
//  PallyConPolicy.swift
//  DrmSDK_iOS
//
//  Created by Peter Kuo on 2021/10/25.
//

import Foundation
import AVFAudio

struct PallyConPolicy: Encodable {
    var playbackPolicy: PallyconPlaybackPolicy
    
    private enum CodingKeys : String, CodingKey {
        case playbackPolicy = "playback_policy"
    }
    
    init(playback_policy: PallyconPlaybackPolicy) {
        self.playbackPolicy = playback_policy
    }
    
    init(limit: Bool, persistent: Bool, duration: Int) {
        self.playbackPolicy = PallyconPlaybackPolicy(limit: limit, persistent: persistent, duration: duration)
    }
}

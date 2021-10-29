//
//  DrmPlayerView.swift
//  DrmSDK_iOS
//
//  Created by Peter Kuo on 2021/10/25.
//

import UIKit
import AVKit
import PallyConFPSSDK

public class DrmPlayerView: UIView {
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    
    public override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private(set) var site: PallyConSite!
    
    var license = PallyConLicense(drmType: .fairPlay, userId: "", contentId: "")
    
    private let policy = PallyConPolicy(limit: true, persistent: false, duration: 0) // default
    
    private let pallyConAesIv = "0123456789abcdef"
    
    private var configration: PallyConConfiguration {
        PallyConConfiguration(site: self.site, license: license, policy: policy, aesIv: pallyConAesIv)
    }
    
    private lazy var fpsSDK: PallyConFPSSDK? = {
        
        do {
            return try PallyConFPSSDK(siteId: site.siteId, siteKey: site.siteKey, fpsLicenseDelegate: self)
        } catch let error {
            
            print("PallyConFPSSDK initialize failed.\n\(checkPallyConSDKExceptionError(error: error))")
            
            return nil
        }
    }()
}

extension DrmPlayerView {
    
    public func setupConfig(siteId: String, siteKey: String, accessKey: String) {
        
        site = PallyConSite(siteId: siteId, siteKey: siteKey, accessKey: accessKey)
    }
    
    public func setupPlayer(urlString: String) {
        
        guard let contentUrl = URL(string: urlString) else {
            return
        }
        
        let urlAsset = AVURLAsset(url: contentUrl)
        
        //
        let tokenBase64 = try! PallyConUtil.generateTokenString(configuation: configration)
        
        // 2. Acquire a CustomData information
        fpsSDK?.prepare(urlAsset: urlAsset, userId: license.userId, contentId: license.contentId, token: tokenBase64)
        
        let playerItem = AVPlayerItem(asset: urlAsset)
        
        let player = AVPlayer(playerItem: playerItem)
        
        self.player = player
    }
    
    private func checkPallyConSDKExceptionError(error: Error) -> String {
        
        guard let error = error as? PallyConSDKException else  {
            
            return "Error: \(error). Unkown"
        }
        
        switch error {
        case .ServerConnectionFail(let message):
            return "server connection fail = \(message)"
        case .NetworkError(let networkError):
            return "Network Error = \(networkError)"
        case .AcquireLicenseFailFromServer(let code, let message):
            return "ServerCode = \(code).\n\(message)"
        case .DatabaseProcessError(let message):
            return "DB Error = \(message)"
        case .InternalException(let message):
            return "SDK internal Error = \(message)"
        default:
            return "Error: \(error). Unkown."
        }
    }
}

extension DrmPlayerView: PallyConFPSLicenseDelegate {
    
    public func fpsLicenseDidSuccessAcquiring(contentId: String) {
        print("fpsLicenseDidSuccessAcquiring. (\(contentId))")
    }
    
    public func fpsLicense(contentId: String, didFailWithError error: Error) {
        
        print("didFailWithError. error message (\(error.localizedDescription))")
        
        print(checkPallyConSDKExceptionError(error: error))
    }
}

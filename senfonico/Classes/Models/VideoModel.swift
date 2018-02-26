//
//  VideoModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class VideoModel: PhotoModel {

    var referralDestinations: MediaModel?
    
    override func mapping(json: [String : Any]) {
        super.mapping(json: json)
        if let obj = json["referral_destinations"] as? [String: Any] {
            self.referralDestinations = MediaModel(json: obj)
        }
    }
}

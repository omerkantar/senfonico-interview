//
//  PhotoModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotoModel: BaseModel {

    var owner: String?
    var server: String?
    var secret: String?
    var title: String?
    var farmId: Int = 0
    
    override func mapping(json: [String : Any]) {
        self.owner = json["owner"] as? String
        self.server = json["server"] as? String
        self.secret = json["secret"] as? String
        self.title = json["title"] as? String
        self.farmId = json["farm"] as? Int ?? 0
    }
    
    var imageURL: URL? {
        return FlickrManager.imageURL(photoModel: self)
    }
}

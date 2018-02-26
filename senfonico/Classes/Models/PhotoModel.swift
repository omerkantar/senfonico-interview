//
//  PhotoModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class PhotoModel: BaseModel {

    var title: String?
    var collectionCode: String?
    var collectionId: Int = 0
    var collectionName: String?
    var imageModels: [MediaModel]?
    var maxDimensionsModel: DimensionModel?
    var license: String?
    
    override func mapping(json: [String : Any]) {
        self.title = json["title"] as? String
        self.collectionCode = json["collection_code"] as? String
        self.collectionId = (json["collection_id"] ?? 0) as! Int
        self.collectionName = json["collection_name"] as? String
        self.license = json["license_model"] as? String

        if let dimensions = json["max_dimensions"] as? [String: Any] {
            self.maxDimensionsModel = DimensionModel(json: dimensions)
        }
    
        if let list = json["display_sizes"] as? Array<[String: Any]> {
            self.imageModels = list.map({ (obj) -> MediaModel in
                return MediaModel(json: obj)
            })
        }
    }
    
    var imageURL: URL? {
        return self.imageModels?.first?.imageURL
    }
}


class DimensionModel: BaseModel {
    
    var height: Int = 0
    var width = 0
    
    override func mapping(json: [String : Any]) {
        self.height = (json["height"] ?? 0) as! Int
        self.width = (json["height"] ?? 0) as! Int
    }
    
    var text: String {
        if height != 0 && width != 0 {
            return "WxH: \(width)x\(height)"
        }
        return ""
    }
    
}

class MediaModel: BaseModel {
    var name: String?
    var uri: String?
    var siteName: String?
    
    var imageURL: URL? {
        return uri?.url
    }
    override func mapping(json: [String : Any]) {
        self.name = json["name"] as? String
        self.siteName = json["site_name"] as? String
        self.uri = json["uri"] as? String
    }
}

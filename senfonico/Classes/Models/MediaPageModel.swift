//
//  PhotosModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class MediaPageModel {
    
    var resultCount: Int = 1001
    var medias: [PhotoModel]?
    var type: MediaPageModel.MediaType 
    
    init(json: [String: Any], type: MediaType) {
        self.type = type
        self.mapping(json: json)
    }
    
    func mapping(json: [String : Any]) {
        self.resultCount = (json["result_count"] ?? -1) as! Int
        self.medias = [PhotoModel]()
        if let list = json[self.type.rawValue] as? Array<[String: Any]> {
            switch type {
            case .image:
                self.medias = list.map({ (item) -> PhotoModel in
                    return PhotoModel(json: item)
                })
                break
            case .video:
                self.medias = list.map({ (item) -> PhotoModel in
                    return VideoModel(json: item)
                })
                break
            }
            
        }
    }
    
}

extension MediaPageModel {
    enum MediaType: String {
        case image = "images"
        case video = "videos"
    }
}

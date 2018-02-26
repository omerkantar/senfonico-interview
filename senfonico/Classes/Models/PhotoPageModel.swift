//
//  PhotosModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotoPageModel: BaseModel {
    
    var page: Int = 0
    var pages: String?
    var perPage: Int = 0
    var total: String?
    var photos: [PhotoModel]?
    
    override func mapping(json: [String : Any]) {
        super.mapping(json: json)
        if let page = json["page"] {
            self.page = page as! Int
        }
        if let perPage = json["perpage"]  {
            self.perPage = perPage as! Int
        }
        self.pages = json["pages"] as? String
        self.total = json["total"] as? String
        
        self.photos = [PhotoModel]()
        if let list = json["photos"] as? Array<[String: Any]> {
            self.photos = list.map({ (item) -> PhotoModel in
                return PhotoModel(json: item)
            })
        }
    }
    
    var canPageUp: Bool {
        if let pages = pages {
            if let count = Int(pages) {
                return page != count
            }
        }
        return false
    }
}

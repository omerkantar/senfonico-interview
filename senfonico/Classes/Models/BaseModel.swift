//
//  Model.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class BaseModel {

    var id: String?
    
    var json: [String: Any]
    
    var object: Any? // array de gelebilir
    
    init() {
        self.json = [String: Any]()
    }

    init(json: [String: Any]) {
        self.object = json
        self.json = json
        self.id = json["id"] as? String
        mapping(json: json)
    }
    
    func mapping(json: [String: Any]) { }
}

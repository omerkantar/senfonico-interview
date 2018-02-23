//
//  ResponseModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class ResponseModel: BaseModel {
    
    var data: Any?
    var stat: String?
    var statusCode: Int = 200
    var httpResponse: HTTPURLResponse?
    
    var isSuccess: Bool  {
        if let stat = stat {
            return stat.lowercased().contains("ok")
        }
        return false
    }
    override func mapping(json: [String : Any]) {
        self.data = json["data"]
        self.stat = json["stat"] as? String
    }
}

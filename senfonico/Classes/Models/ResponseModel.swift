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
    var statusCode: Int = 200
    var httpResponse: HTTPURLResponse?
    
    override func mapping(json: [String : Any]) {
        self.data = json["data"]
    }
}

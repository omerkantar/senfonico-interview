//
//  Method.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import Foundation


enum Method: String {
    
    case get = "GET"
    
    case post = "POST"
    
    case put = "PUT"
    
    case patch = "PATCH"
    
    case update = "UPDATE"
    
    case delete = "DELETE"
    
}



enum ContentType: String {
    
    case json = "application/json"
    
    case form = "application/x-www-form-urlencoded; charset=utf-8"
}

//
//  ApiTarget.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - APITarget

protocol APITarget {
    var url: URL { get }
    var method: Method { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var contentType: ContentType { get }
    var urlRequest: URLRequest? { get }
}

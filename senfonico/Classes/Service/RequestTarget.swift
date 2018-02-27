//
//  RequestTarget.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

fileprivate let kJSONPlaceholder = "https://jsonplaceholder.typicode.com"

enum RequestTarget  {
    case coffee
    case posts
    case comments(postId: Int)
    case photos(key: String?, perpage: Int, page: Int)
    case videos(perpage: Int, page: Int)
}


extension RequestTarget: APITarget {
    var method: Method {
        return .get
    }
    
    var contentType: ContentType {
        return .json
    }
    
    var urlRequest: URLRequest? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        if let params = headers {
            urlRequest.allHTTPHeaderFields = params
        }
        
        if let params = self.parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: params)
                urlRequest.httpBody = data
            } catch let error {
                print("APITarget urlRequest error: \(error)")
                let data = NSKeyedArchiver.archivedData(withRootObject: params)
                urlRequest.httpBody = data
            }
        }
        return urlRequest
    }
    
}

// MARK: - URL
extension RequestTarget {
    
    var url: URL {
        if let url = URL(string: basePath + path) {
            return url
        }
        return URL(string: "www.google.com")!
    }
    
    var basePath: String {
        switch self {
        case .photos, .videos:
            return GettyImage.basePath.rawValue
        default:
            break
        }
        return kJSONPlaceholder
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .photos(let key, let perpage, let page):
            let query = key ?? "cats"
            return "/search/images?page=\(page)&page_size=\(perpage)&file_types=jpg&phrase=\(query)&sort_order=most_popular"
        case .videos(let perpage, let page):
            return "/search/videos?page=\(page)&page_size=\(perpage)&sort_order=most_popular"

        default:
            break
        }
        return ""
    }
}

// MARK: - Method & content type
extension RequestTarget {
    var headers: [String: String]? {
        switch self {
        case .photos, .videos:
            return ["Accept": "application/json",
                    "Api-Key": GettyImage.apiKey.rawValue]
        default:
            break
        }
        return ["Content-Type": ContentType.json.rawValue]
    }
}

// MARK: - Parameters
extension RequestTarget {
    var parameters: [String: Any]? {
        switch self {
//        case .photos(let key, let perpage, let page):
//
//            var params = [String: Any]()
//            params["file_types"] = "jpg" as Any
//            params["page"] = page as Any
//            params["page_size"] = perpage as Any
//            params["sort_order"] = "best_match" as Any
//            if let key = key {
//                params["phrase"] = key
//            }
//            return params
      
        default:
            break
        }
        return nil
    }
}



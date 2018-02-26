//
//  RequestTarget.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

//https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f3e60cd8981eafd1ebd610deb941b15b&tags=love&content_type=1&media=photos&format=json&nojsoncallback=1&auth_token=72157666030651698-be6cc3b08d920147&api_sig=456e27c134bc770ccf04215db3a18166

fileprivate let kJSONPlaceholder = "https://jsonplaceholder.typicode.com"

enum RequestTarget  {
    case coffee
    case posts
    case comments(postId: Int)
    case photos(key: String?, perpage: Int, page: Int)
    case videos(key: String?, perpage: Int, page: Int)
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
        urlRequest.allHTTPHeaderFields = ["Content-Type": self.contentType.rawValue]
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
            return FlickrAPI.basePath.rawValue
        default:
            break
        }
        return kJSONPlaceholder
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        default:
            break
        }
        return ""
    }
}

// MARK: - Method & content type
extension RequestTarget {
    var headers: [String: String]? {
        return ["Content-Type": ContentType.json.rawValue]
    }
}

// MARK: - Parameters
extension RequestTarget {
    var parameters: [String: Any]? {
        switch self {
        case .photos(let key, let perpage, let page):
            var params = [String: Any]()
            params["method"] = "flickr.photos.search"
            params["media"] = "photos"
            params["content_type"] = 1 as Any //
            params["page"] = page as Any
            params["per_page"] = perpage as Any
            if let key = key {
                params["text"] = key
            }
            
            return params
        case .videos(let key, let perpage, let page):
            var params = [String: Any]()
            params["method"] = "flickr.photos.search"
            params["media"] = "videos"
            params["page"] = page as Any
            params["per_page"] = perpage as Any

            if let key = key {
                params["text"] = key
            }
            return params
        default:
            break
        }
        return nil
    }
}



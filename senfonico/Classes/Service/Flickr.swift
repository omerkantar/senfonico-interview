//
//  Flickr.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit



enum FlickrAPI: String  {
    case basePath = "https://api.flickr.com/services/rest"
    case key = "f3e60cd8981eafd1ebd610deb941b15b"
    case secret = "0f8b0cff74916f4b"
}

//class FlickrManager {
//    static func imageURL(photoModel: PhotoModel, contentType: String? = nil) -> URL? {
//        return imageURLString(farmId: photoModel.farmId, server: photoModel.server, secret: photoModel.secret, id: photoModel.id, contentType: contentType)
//    }
//    
//    static func imageURLString(farmId: Int, server: String?, secret: String?, id: String?, contentType: String? = nil) -> URL? {
//        guard let server = server, let secret = secret, let id = id else {
//            return nil
//        }
//        let type = contentType ?? "jpg"
//        return "https://farm\(farmId).staticflickr.com/\(server)/\(id)_\(secret).\(type)".url
//    }
//    
//    ////https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f3e60cd8981eafd1ebd610deb941b15b&tags=love&content_type=1&media=photos&format=json&nojsoncallback=1&auth_token=72157666030651698-be6cc3b08d920147&api_sig=456e27c134bc770ccf04215db3a18166
//
//    static func baseParameters() -> [String: Any] {
//        return ["api_key": "f3e60cd8981eafd1ebd610deb941b15b" as Any,
//                "format": "json" as Any,
//                "auth_token": "72157666030651698-be6cc3b08d920147" as Any, "tags": "love" as Any, "content_type": 1 as Any, "api_sig": "456e27c134bc770ccf04215db3a18166" as Any ]
//    }
//}


/*
 
 flickr search: https://www.flickr.com/services/api/flickr.photos.search.html
 
 content_type (Optional)
 Content Type setting:
 1 for photos only.
 2 for screenshots only.
 3 for 'other' only.
 4 for photos and screenshots.
 5 for screenshots and 'other'.
 6 for photos and 'other'.
 7 for photos, screenshots, and 'other' (all).
 
 
 media (Optional)
 Filter results by media type. Possible values are all (default), photos or videos
 */
